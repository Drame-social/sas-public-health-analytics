# Phase 09 — Variable Documentation & Formats

**Module:** Module 6 (repositioned — applied after all data transformations)  
**Topics:** Renaming variables, applying labels, defining and using formats and informats

## What You Will Learn
- Rename variables with the `RENAME` statement and dataset option
- Apply descriptive labels to variables for cleaner output
- Define custom formats with `PROC FORMAT` (map codes to meaningful text)
- Apply formats and informats to numeric, character, and date variables
- Use `PROC FREQ` and `PROC PRINT` with label and format output

## Files
| File | Description |
|------|-------------|
| `09_variable_documentation_and_formats.sas` | Solution script |
| `Module_06_Variable_Documentation_and_Formats.pdf` | Lecture notes |
| `sample_output.rtf` | Example ODS RTF output |

## Datasets Used (from `/data`)
`mod6.sas7bdat`

## Key SAS Syntax
```sas
/* Rename and label */
DATA clean;
  SET phdata.mod6;
  RENAME ill = case_status;
  LABEL age    = 'Age at enrollment (years)'
        exposed = 'Exposure status (1=yes, 0=no)';
RUN;

/* Define and apply a format */
PROC FORMAT;
  VALUE casefmt 1='Case' 0='Control' .='Missing';
RUN;

PROC FREQ DATA=clean;
  TABLES case_status;
  FORMAT case_status casefmt.;
RUN;
```
