# Phase 11 — Automation & Macros

**Module:** Module 11  
**Topics:** Macro variables, macro programs, %DO loops, conditional macro logic

## What You Will Learn
- Assign and reference macro variables with `%LET` and `&varname`
- Write reusable macro programs with `%MACRO` / `%MEND`
- Use `%DO` loops to automate repetitive analyses across strata or time periods
- Apply `%IF-%THEN-%ELSE` for conditional macro logic
- Call system macros (`%PUT`, `%EVAL`, `%SYSFUNC`)

## Files
| File | Description |
|------|-------------|
| `Module_11_Automation_and_Macros.pdf` | Lecture notes with annotated examples |

## Note
No external datasets required — macro examples use inline DATA step data.

## Key SAS Syntax
```sas
/* Macro variable */
%LET condition = diabetes;
PROC FREQ DATA=phdata.patients;
  TABLES &condition * outcome;
RUN;

/* Macro program */
%MACRO freq_table(dsn, var);
  PROC FREQ DATA=&dsn;
    TABLES &var / MISSING;
  RUN;
%MEND freq_table;

/* Call the macro */
%freq_table(phdata.patients, diagnosis_code);

/* %DO loop — run for each year */
%MACRO annual_report;
  %DO yr = 2018 %TO 2022;
    PROC MEANS DATA=phdata.patients;
      WHERE year = &yr;
      VAR age bmi;
    RUN;
  %END;
%MEND annual_report;
%annual_report;
```
