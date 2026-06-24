# Phase 03 — Data Merging & Subsetting

**Module:** Module 3  
**Topics:** Partial merges, subsetting with IF/WHERE, creating new variables from merged data

## What You Will Learn
- Merge datasets when not all subjects appear in both files (one-to-many and partial merges)
- Subset rows using `IF` and `WHERE` conditions in the DATA step
- Create new derived variables after a merge
- Use `IN=` dataset options to detect merge matches

## Files
| File | Description |
|------|-------------|
| `03_data_merging_and_subsetting.sas` | Solution script |
| `03_dataset_creation_examples.sas` | Additional dataset creation code |
| `03_dataset_creation_examples_v2.sas` | Alternate version with comments |
| `Module_03_Merging_and_Subsetting.pdf` | Lecture notes |

## Datasets Used (from `/data`)
`phase1.sas7bdat`, `phase2.sas7bdat`, `labs.sas7bdat`, `mod3lab.sas7bdat`

## Key SAS Syntax
```sas
/* Partial merge with IN= */
DATA p2wlabs;
  MERGE phdata.phase2 (IN=a) phdata.labs (IN=b);
  BY studyid;
  IF a;  /* keep only subjects in phase2 */
RUN;

/* Subset with WHERE */
DATA adults;
  SET phdata.phase1;
  WHERE age >= 18;
RUN;
```
