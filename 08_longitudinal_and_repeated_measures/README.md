# Phase 08 — Longitudinal & Repeated Measures Data

**Module:** Module 9  
**Topics:** Datasets with multiple observations per subject, FIRST./LAST. variables, RETAIN statement

## What You Will Learn
- Understand the structure of longitudinal datasets (one row per visit/event per subject)
- Use `FIRST.` and `LAST.` after PROC SORT to identify first and last records per subject
- Use `RETAIN` to carry values across observations for the same subject
- Count events, flag conditions, and calculate within-subject summaries
- Transpose repeated measures with `PROC TRANSPOSE`

## Files
| File | Description |
|------|-------------|
| `08_longitudinal_and_repeated_measures.sas` | Solution script |
| `NOTES.md` | Study guide with key concepts, worked examples, and practice questions |

## Datasets Used (from `/data`)
`patients.sas7bdat`, `mod9.sas7bdat`, `flbygroup.sas7bdat`, `patients_part2.sas7bdat`, `screener_data.sas7bdat`

## Key SAS Syntax
```sas
/* Count visits per patient */
PROC SORT DATA=phdata.patients OUT=visits; BY id visdate; RUN;

DATA summary;
  SET visits;
  BY id;
  RETAIN visit_count 0;
  IF FIRST.id THEN visit_count = 0;
  visit_count + 1;
  IF LAST.id THEN OUTPUT;
RUN;
```
