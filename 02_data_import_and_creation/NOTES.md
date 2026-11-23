# Study Guide — Phase 02: Data Import & Dataset Creation

## Ways to get data into SAS

| Source | Tool | Notes |
|---|---|---|
| Delimited text (.txt, .csv) | DATA step with `INFILE` and `INPUT`, or `PROC IMPORT` | DATA step gives full control over types and lengths |
| Excel (.xls, .xlsx) | `PROC IMPORT DBMS=XLSX` (or `XLS`) | Check variable types afterward with PROC CONTENTS |
| Values typed in the program | DATA step with `DATALINES` | Good for small lookup tables and tests |
| Existing SAS dataset | `SET` in a DATA step | Reads one dataset or stacks several |

## Reading a text file

`data/raw/RAWDATA.TXT` has no header row; each line holds an ID, case/control status, age, and exposure separated by spaces.

```sas
data rawtxt;
  infile './data/raw/RAWDATA.TXT';
  input studyid $ caco $ age exposure $;     /* $ marks character variables */
run;
```

## Importing a spreadsheet

```sas
proc import datafile='./data/raw/RAWDAT1.xls'
            out=work.rawxls dbms=xls replace;
  getnames=yes;                               /* first row holds column names */
run;
```

## Creating data in the program

```sas
data sites;
  input site_id site_name $ 3-15 enrolled;   /* column input for a value with spaces */
  datalines;
1 Clinic North 42
2 Clinic South 37
;
run;
```

## Temporary versus permanent

```sas
data work.cohort_all;      /* temporary: gone when the session ends */
data phdata.cohort_all;    /* permanent: saved to the data folder */
```

## Stacking datasets (concatenation)

Rows from the second dataset are added below the first. Variables with the same name line up; a variable that exists in only one dataset is missing for rows from the other.

```sas
data cohort_all;
  set phdata.cohort1516 phdata.cohort1617;
run;
```

Watch for the same variable stored as numeric in one file and character in the other. SAS stops with an error, and you must convert one of them first (see Phase 05).

## Checking the result

- The log line "The data set WORK.COHORT_ALL has N observations" should equal the sum of the inputs.
- Run `PROC FREQ` on key categorical variables to catch spelling variants such as `Female` and `female`. `UPCASE()` or `LOWCASE()` can standardize them.

## Check yourself

1. When would you choose a DATA step with `INFILE` over `PROC IMPORT`?
2. After stacking 204 and 152 rows, how many rows should the result have?
3. What does the `$` after a variable name in `INPUT` do?
