# Study Guide — Phase 01: Environment Setup

## Key ideas

- **Program, log, output.** You write code in the editor, SAS reports what happened in the log, and results appear in the output or results viewer. Read the log after every run: a program can finish without an ERROR and still be wrong, so check NOTE and WARNING lines too (for example "uninitialized variable" or "missing values were generated").
- **DATA step and PROC step.** A DATA step reads and changes data one row at a time. A PROC step runs a ready-made procedure (PRINT, FREQ, MEANS, SORT) on a whole dataset.
- **Libraries.** A library is a nickname for a folder. `WORK` is temporary and is emptied when the session ends. A library you define with `LIBNAME` is permanent.
- **Two-level names.** `phdata.mod4` means dataset `mod4` in library `phdata`. A one-level name such as `mod4` means `work.mod4`.

## Setting up this repository

Every script starts with the same line, run from the repository root:

```sas
libname phdata './data';      /* folder that holds the .sas7bdat files */
```

If your session does not start in the repository folder, replace `./data` with the full path to the `data` folder.

## Looking at a dataset

```sas
proc contents data=phdata.mod4;            /* variables, types, lengths, labels */
run;

proc print data=phdata.mod4 (obs=10);      /* first 10 rows */
run;
```

## Syntax rules worth memorizing

- Every statement ends with a semicolon. A missing semicolon is the most common cause of confusing errors.
- End each step with `run;` (or `quit;` for interactive procedures such as PROC SQL).
- Names can be up to 32 characters, start with a letter or underscore, and are not case sensitive.
- Comments: `/* ... */` anywhere, or `* ... ;` as a statement.
- Character values go in quotes; numeric values do not. Missing numeric is `.`, missing character is `' '`.

## Good habits

- Put the LIBNAME and any `%let` settings at the top of the program.
- Create new datasets instead of overwriting the original data.
- After each DATA step, compare the number of observations in the log with what you expected.
- Use clear dataset names (`demo_clean`, `visits_sorted`) instead of `temp1`, `temp2`.

## Check yourself

1. What happens to `work.mydata` when you close SAS?
2. Why can a program with no ERROR lines in the log still be wrong?
3. What does `phdata.patients` refer to?
