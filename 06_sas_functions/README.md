# Phase 06 — SAS Functions

**Module:** Module 7  
**Topics:** String functions, numeric functions, date functions, missing value functions

## What You Will Learn
- Use character functions: `COMPRESS`, `STRIP`, `SUBSTR`, `SCAN`, `UPCASE`, `LOWCASE`, `CATS`, `CATX`
- Use numeric functions: `ROUND`, `INT`, `ABS`, `MIN`, `MAX`, `SUM`
- Use date/time functions: `TODAY()`, `MDY()`, `YEAR()`, `MONTH()`, `DAY()`
- Handle missing values with `MISSING()`, `COALESCE()`, `NMISS()`

## Files
| File | Description |
|------|-------------|
| `06_sas_functions.sas` | Solution script with annotated examples |
| `Module_07_SAS_Functions.pdf` | Lecture notes |

## Datasets Used (from `/data`)
`mock_data.sas7bdat`

## Key SAS Syntax
```sas
/* Remove non-alphanumeric characters */
clean_id = COMPRESS(raw_id, '', 'kd');  /* keep digits only */

/* Extract substring */
state_code = SUBSTR(fips_code, 1, 2);

/* Concatenate with separator */
full_name = CATX(' ', first_name, last_name);

/* Count non-missing values across variables */
n_responses = N(q1, q2, q3, q4, q5);
```
