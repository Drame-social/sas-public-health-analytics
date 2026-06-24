# Phase 07 — Arrays & Variable Naming

**Module:** Module 8  
**Topics:** SAS arrays, DO loops over arrays, efficient variable naming patterns

## What You Will Learn
- Define arrays to group related variables for batch processing
- Use DO loops to iterate over array elements — recode, sum, flag, or transform
- Apply naming shortcuts (e.g., `var1-var10`) to reference variable sets
- Combine arrays to calculate scores or composite variables

## Files
| File | Description |
|------|-------------|
| `07_arrays_and_variable_naming.sas` | Solution script |
| `Module_08_Arrays_and_Variable_Naming.pdf` | Lecture notes |

## Datasets Used (from `/data`)
`mod8_a.sas7bdat`, `mod8_b.sas7bdat`, `mod8_c.sas7bdat`, `mod8_d.sas7bdat`, `pets.sas7bdat`

## Key SAS Syntax
```sas
/* Recode 9 (missing sentinel) to . across 10 variables */
ARRAY qvars{10} q1-q10;
DO i = 1 TO 10;
  IF qvars{i} = 9 THEN qvars{i} = .;
END;

/* Sum across an array (ignoring missing) */
total_score = SUM(OF q1-q10);
```
