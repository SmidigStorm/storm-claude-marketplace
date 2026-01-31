@STU-PLN-CRS-001 @must
Feature: STU-PLN-CRS-001 Course Planning for Students
  As a student in a degree program
  I want to plan my study progression
  So that I can complete my degree within the standard timeframe

  # OPEN QUESTIONS:
  # - Waitlist: Should students automatically move up from waitlist when others withdraw?
  # - Notifications: Which events should trigger email notification to advisor?

  Course planning is a critical function that lets students
  choose courses for upcoming semesters based on degree program
  requirements and personal interests. The plan must account for
  prerequisites, capacity, and credit requirements.

  Background:
    Given the student "Emma Wilson" with student number "123456" is logged in
    And the student is in the degree program "Computer Science - Bachelor"
    And the degree program requires 180 credits for completion
    And the student has completed 60 credits
    And the following courses are available for next semester:
      | course_code | course_name                  | credits | prerequisites | capacity |
      | CS2100      | Software Project             | 10      | CS1000        | 30       |
      | CS2200      | Computer Architecture        | 10      |               | 50       |
      | MATH2000    | Linear Algebra               | 10      | MATH1000      | 100      |
      | CS2300      | Databases and Data Modeling  | 10      | CS1000        | 40       |
      | PHIL1000    | Introduction to Philosophy   | 10      |               | 200      |

  @must @implemented
  Rule: Students can add courses to their study plan

    This rule covers the basic functionality for building
    a study plan by adding courses.

    @must @implemented
    Scenario: Add a course to the study plan
      Given the study plan for next semester is empty
      And the course "CS2200" has 45 available spots
      When the student adds "CS2200" to the study plan
      Then "CS2200" should appear in the study plan
      And the number of planned credits should be 10
      And the course should display with status "planned"

    @should @planned
    Scenario: Add multiple courses to the study plan
      Given the study plan contains the course "CS2200"
      When the student adds the following courses:
        | course_code |
        | MATH2000    |
        | PHIL1000    |
      Then the study plan should contain 3 courses
      And the number of planned credits should be 30

    @must @implemented
    Scenario: Maximum credits per semester
      Given the degree program allows maximum 30 credits per semester
      And the study plan contains courses totaling 20 credits
      When the student adds a course with 10 credits
      Then the course should be added to the study plan
      And the student should see the message "You have now planned the maximum number of credits"

  @must @implemented
  Rule: Courses with prerequisites can only be planned if prerequisites are met

    The system should automatically verify that the student has passed
    required prerequisite courses before a course can be added to the plan.

    @must @implemented
    Scenario: Plan course with met prerequisites
      Given the student has passed "CS1000" with grade "B"
      And the course "CS2100" requires "CS1000" as a prerequisite
      When the student adds "CS2100" to the study plan
      Then the course should be added to the study plan
      And the prerequisite status should display as "met"

    @must @implemented
    Scenario: Cannot plan course with unmet prerequisites
      Given the student has not passed "MATH1000"
      And the course "MATH2000" requires "MATH1000" as a prerequisite
      When the student attempts to add "MATH2000" to the study plan
      Then the student should see the error message "You are missing the prerequisite: MATH1000 - Calculus"
      And the course should not be added to the study plan
      And the student should see a link to the course description for "MATH1000"

    @should @in-progress
    Scenario: Course with multiple missing prerequisites
      Given the course "CS3000" requires the following prerequisites:
        | course_code | course_name                 |
        | CS2100      | Software Project            |
        | CS2300      | Databases and Data Modeling |
      And the student has not passed any of these courses
      When the student attempts to add "CS3000" to the study plan
      Then the student should see the error message:
        """
        You are missing the following prerequisites:
        - CS2100 - Software Project
        - CS2300 - Databases and Data Modeling
        """
      And the course should not be added to the study plan

  @should @planned
  Rule: The study plan must account for course capacity

    When students plan courses, the system should display available
    capacity and warn about courses that may fill up.

    @should @planned
    Scenario: Plan course with good capacity
      Given the course "PHIL1000" has capacity of 200 students
      And there are 50 students who have planned the course
      When the student adds "PHIL1000" to the study plan
      Then the course should be added with capacity indicator "good"
      And the student should see "150 spots available"

    @should @planned
    Scenario: Plan course with limited capacity
      Given the course "CS2100" has capacity of 30 students
      And there are 25 students who have planned the course
      When the student adds "CS2100" to the study plan
      Then the course should be added with capacity indicator "limited"
      And the student should see the warning "Only 5 spots left - early registration recommended"

    @must @planned
    Scenario: Plan course that is full
      Given the course "CS2100" has capacity of 30 students
      And there are 30 students who have already planned the course
      When the student attempts to add "CS2100" to the study plan
      Then the student should see the warning "Course is full - you will be placed on the waitlist"
      And the student should be given the choice:
        | option                          |
        | Add to waitlist                 |
        | Choose a different course       |
        | Get notified when spot opens    |

  @must @implemented
  Rule: The study plan must follow the degree program's credit requirements

    @must @implemented
    Scenario: Cannot exceed maximum credits
      Given the degree program allows maximum 30 credits per semester
      And the study plan contains courses totaling 30 credits
      When the student attempts to add a course with 10 credits
      Then the student should see the error message "Maximum 30 credits per semester"
      And the course should not be added to the study plan
      And the student should see a link to "Apply for extended study load"

    @could @planned
    Scenario: System recommends credits for standard progression
      Given the student has completed 60 of 180 credits
      And the student is in their third semester
      When the student opens the course planner
      Then the system should recommend "30 credits this semester for standard progression"
      And the student should see a progression graph

  @must @in-progress
  Rule: The study plan must be validated before submission for approval

    @must @implemented
    Scenario: Valid study plan submitted for approval
      Given the study plan contains the following courses:
        | course_code | course_name                 | credits | status  |
        | CS2200      | Computer Architecture       | 10      | planned |
        | PHIL1000    | Introduction to Philosophy  | 10      | planned |
        | CS2300      | Databases and Data Modeling | 10      | planned |
      And all prerequisites are met
      And the total number of credits is 30
      When the student clicks on "Submit for approval"
      Then the study plan should get status "awaiting approval"
      And the academic advisor should receive notification of new study plan
      And the student should see the confirmation "Study plan submitted for approval"

    @must @in-progress
    Scenario Outline: Invalid study plan cannot be submitted for approval
      Given the study plan has the following problem: <problem>
      When the student attempts to submit the plan for approval
      Then the student should see the error message "<error_message>"
      And the study plan should not be submitted for approval
      And the problem should be highlighted in the study plan

      Examples:
        | problem                         | error_message                                      |
        | no courses selected             | Study plan must contain at least one course        |
        | missing prerequisites           | Some courses have unmet prerequisites              |
        | exceeds max credits             | Study plan exceeds maximum number of credits       |
        | course with time conflict       | Two courses have overlapping class times           |

  @should @planned
  Rule: Students can modify the study plan before the approval deadline

    @should @implemented
    Scenario: Remove course from study plan
      Given the study plan contains the courses "CS2200" and "PHIL1000"
      And the study plan has status "draft"
      When the student removes "PHIL1000" from the study plan
      Then the study plan should only contain "CS2200"
      And the number of planned credits should be updated to 10

    @must @planned
    Scenario: Cannot modify approved study plan after deadline
      Given the study plan has status "approved"
      And the modification deadline "August 15, 2024" has passed
      And today's date is "August 20, 2024"
      When the student attempts to modify the study plan
      Then the student should see the error message "Modification deadline has passed"
      And the student should see a link to "Apply for study plan modification"

  @should @planned
  Scenario: Complete course planning flow from start to approval
    Given the student starts with an empty study plan for "Fall 2024"
    When the student completes the following steps:
      | step | action                                | expected_result                  |
      | 1    | Search for courses in computer science| Shows 15 available courses       |
      | 2    | Filter by "required courses"          | Shows 3 required courses         |
      | 3    | Add CS2200 to the plan               | Course is added                  |
      | 4    | Add PHIL1000 to the plan             | Course is added                  |
      | 5    | Check credits                        | Shows 20 of 30 possible          |
      | 6    | Add CS2300 to the plan               | Course is added                  |
      | 7    | Validate the study plan              | No errors found                  |
      | 8    | Submit for approval                  | Status changes to "awaiting"     |
    Then the study plan should be complete
    And the academic advisor should have received notification
    And the student should be able to view status in the student portal

  @should @planned
  Scenario: Handling waitlist when student withdraws
    Given the student is on the waitlist for the course "CS2100"
    And the student is number 3 on the waitlist
    When another student withdraws from the course
    Then the student should move up to position 2 on the waitlist
    And the student should receive notification of updated waitlist status
