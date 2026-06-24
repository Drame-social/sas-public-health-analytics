# Phase 04 — Categorical Variables & Dates

**Module:** Module 4  
**Topics:** Creating categorical (grouped) variables, arithmetic operations, SAS date handling

## What You Will Learn
- Group continuous variables (age, BMI) into categorical variables using IF/THEN logic
- Perform arithmetic operations on numeric variables in the DATA step
- Work with SAS date values — read, calculate intervals, and format them
- Use `PROC UNIVARIATE` and `PROC MEANS` to determine grouping cutpoints

## Files
| File | Description |
|------|-------------|
| `04_categorical_variables_and_dates.sas` | Solution script |
| `Module_04_Categorical_Variables_and_Dates.pdf` | Lecture notes |

## Datasets Used (from `/data`)
`mod4.sas7bdat`

## Key SAS Syntax
```sas
/* Create age group variable */
DATA clean;
  SET phdata.mod4;
  IF age < 30        THEN agegroup = 1;
  ELSE IF age < 50   THEN agegroup = 2;
  ELSE IF age >= 50  THEN agegroup = 3;
RUN;

/* Calculate age from birthdate */
age_yrs = INTCK('year', bdate, today());

/* Format a date variable */
FORMAT enroll_date MMDDYY10.;
```
