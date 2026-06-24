# Phase 05 — Conditionals & Type Conversion

**Module:** Module 5  
**Topics:** IF-ELSE IF-ELSE chains, converting between numeric and character variables

## What You Will Learn
- Write efficient IF / ELSE IF / ELSE chains to assign values without redundant evaluation
- Convert numeric variables to character using `PUT()`
- Convert character variables to numeric using `INPUT()`
- Handle missing values in conditional logic

## Files
| File | Description |
|------|-------------|
| `05_conditionals_and_type_conversion.sas` | Solution script |
| `Module_05_Conditionals_and_Type_Conversion.pdf` | Lecture notes |

## Datasets Used (from `/data`)
`atlgrades.sas7bdat`

## Key SAS Syntax
```sas
/* ELSE IF chain — efficient, stops at first match */
IF      grade >= 90 THEN grade_letter = 'A';
ELSE IF grade >= 80 THEN grade_letter = 'B';
ELSE IF grade >= 70 THEN grade_letter = 'C';
ELSE                     grade_letter = 'F';

/* Numeric to character */
char_id = PUT(numeric_id, 8.);

/* Character to numeric */
num_score = INPUT(char_score, 8.);
```
