# Phase 02 — Data Import & Dataset Creation

**Module:** Module 2  
**Topics:** Reading raw data (TXT, Excel), creating permanent SAS datasets, concatenating and merging

## What You Will Learn
- Import delimited text files and Excel spreadsheets using `PROC IMPORT` and `DATA` step `INFILE`
- Create permanent SAS datasets using a LIBNAME
- Concatenate datasets with `DATA step SET`
- Perform a full merge of two datasets sharing a common key variable

## Files
| File | Description |
|------|-------------|
| `02_data_import_and_creation.sas` | Solution script — all data import and creation examples |
| `Module_02_Data_Import_and_Creation.pdf` | Lecture notes |
| `Module_02_Data_Import_Supplement.pdf` | Supplemental worked examples |

## Datasets Used (from `/data`)
`RAWDATA.TXT`, `RAWDAT1.xls`, `phase1.sas7bdat`, `phase2.sas7bdat`, `labs.sas7bdat`, `cohort1516.sas7bdat`, `cohort1617.sas7bdat`, `survey.sas7bdat`

## Key SAS Syntax
```sas
/* Import delimited text */
DATA mydata;
  INFILE 'path/to/RAWDATA.TXT' DLM='09'x FIRSTOBS=2;
  INPUT var1 var2 $ var3;
RUN;

/* Import Excel */
PROC IMPORT DATAFILE='path/to/RAWDAT1.xls' OUT=mydata DBMS=XLS REPLACE; RUN;

/* Concatenate */
DATA combined; SET phdata.cohort1516 phdata.cohort1617; RUN;

/* Merge */
PROC SORT DATA=phdata.phase1; BY studyid; RUN;
PROC SORT DATA=phdata.phase2; BY studyid; RUN;
DATA merged; MERGE phdata.phase1 phdata.phase2; BY studyid; RUN;
```
