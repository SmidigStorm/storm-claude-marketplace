# Table Field Specifications

Detailed Airtable field definitions for each table.

## Domain

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Domain name |
| Description | multilineText | Domain description |

## Subdomain

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Subdomain name |
| Description | multilineText | Subdomain description |
| Prefix | singleLineText | 3-letter code (e.g., CAR, BET, GAM) |
| Domain | multipleRecordLinks | → Domain |

## Capability

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Capability name |
| Description | multilineText | What this capability covers |
| Prefix | singleLineText | 3-letter code (e.g., DEA, PLA, HIT) |
| Subdomain | multipleRecordLinks | → Subdomain |

## Entity

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Entity name |
| Description | multilineText | Entity description |
| Subdomain | multipleRecordLinks | → Subdomain |

## Attribute

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Attribute name |
| Datatype | singleSelect | String, Integer, Boolean, Date, DateTime, Decimal, Array, Object |
| Description | multilineText | Attribute description |
| Required | checkbox | Is this attribute required? |
| Entity | multipleRecordLinks | → Entity |

## Relationship

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Relationship name (e.g., "has many", "belongs to") |
| Description | multilineText | Relationship description |
| FromEntity | multipleRecordLinks | → Entity (source) |
| ToEntity | multipleRecordLinks | → Entity (target) |
| Cardinality | singleSelect | 1:1, 1:N, N:N |

## Process

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Process name |
| Description | multilineText | Process description |
| Trigger | singleLineText | What initiates the process |
| Steps | multilineText | Process steps |
| Subdomain | multipleRecordLinks | → Subdomain |

## Glossary

| Field | Type | Description |
|-------|------|-------------|
| Term | singleLineText | The term |
| Definition | multilineText | What it means |
| Context | multilineText | When/how it's used |
| Subdomain | multipleRecordLinks | → Subdomain |

## Requirement

| Field | Type | Description |
|-------|------|-------------|
| ReqID | singleLineText | Unique ID: SUB-CAP-NNN (e.g., CAR-DEA-001) |
| Title | singleLineText | Requirement title |
| Description | multilineText | Detailed description |
| Status | singleSelect | Draft, Review, Approved, Implementing, Done, Deprecated |
| Priority | singleSelect | Must, Should, Could, Wont (MoSCoW) |
| Capability | multipleRecordLinks | → Capability |

## Rule

| Field | Type | Description |
|-------|------|-------------|
| Rule | multilineText | The business rule |
| Requirement | multipleRecordLinks | → Requirement |

## Example

| Field | Type | Description |
|-------|------|-------------|
| Example | multilineText | Example input/scenario |
| ExpectedResult | multilineText | Expected outcome |
| Rule | multipleRecordLinks | → Rule |

## OpenQuestion

| Field | Type | Description |
|-------|------|-------------|
| Question | multilineText | The question |
| Answer | multilineText | Answer when resolved |
| Status | singleSelect | Open, Answered, Closed |
| Requirement | multipleRecordLinks | → Requirement |

## TestSuite

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Suite name |
| Description | multilineText | What this suite covers |

## Test

| Field | Type | Description |
|-------|------|-------------|
| Name | singleLineText | Test name |
| Description | multilineText | Test description |
| Steps | multilineText | Test steps |
| ExpectedResult | multilineText | Expected outcome |
| TestSuite | multipleRecordLinks | → TestSuite |
| Requirement | multipleRecordLinks | → Requirement (inspired by) |

## TestRun

| Field | Type | Description |
|-------|------|-------------|
| RunDate | date | When the test was run |
| Status | singleSelect | Pass, Fail, Partial, Skipped |
| Notes | multilineText | Run notes/observations |
| TestSuite | multipleRecordLinks | → TestSuite |

## Fact

| Field | Type | Description |
|-------|------|-------------|
| Fact | multilineText | Raw observation from research |
| Source | singleLineText | Where this came from (interview, survey, etc.) |
| Date | date | When observed |

## Insight

| Field | Type | Description |
|-------|------|-------------|
| Insight | multilineText | Pattern or conclusion |
| Facts | multipleRecordLinks | → Fact (supporting evidence) |

## Recommendation

| Field | Type | Description |
|-------|------|-------------|
| Recommendation | multilineText | Actionable suggestion |
| Priority | singleSelect | High, Medium, Low |
| Insights | multipleRecordLinks | → Insight (based on) |

## BacklogItem

| Field | Type | Description |
|-------|------|-------------|
| Title | singleLineText | Item title |
| Description | multilineText | What and why |
| Type | singleSelect | Feature, Fix, Tech Debt, Spike |
| Order | number | Priority order (1 = highest) |
| Status | singleSelect | Backlog, Ready, In Progress, Done |
| Requirements | multipleRecordLinks | → Requirement (multiple) |
| Recommendation | multipleRecordLinks | → Recommendation (origin) |
