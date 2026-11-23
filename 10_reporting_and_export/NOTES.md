# Study Guide — Phase 10: Reporting & Export

## The Output Delivery System (ODS)

ODS sends procedure output to a destination. Open the destination, run the procedures, then close it.

```sas
ods rtf   file='./outputs/report.rtf';
ods pdf   file='./outputs/report.pdf' style=journal;
ods excel file='./outputs/report.xlsx' options(sheet_name='Summary');

proc freq data=phdata.final_demo;
  tables htype;
run;

ods excel close;
ods pdf close;
ods rtf close;
```

- `style=` changes the look (`journal` is plain black and white).
- `ods select` and `ods exclude` keep only the tables you want.
- `ods noproctitle;` removes procedure titles.
- Close every destination you open, or the file stays incomplete.

## PROC REPORT

PROC REPORT builds a table from defined columns.

```sas
proc report data=phdata.final_clin nowd;
  column hlevel bleeds,(n mean median);
  define hlevel / group 'Severity level';
  define bleeds / analysis 'Bleeds';
  define n      / 'N';
  define mean   / format=8.1 'Mean';
  define median / format=8.1 'Median';
run;
```

Column usages: `group` makes one row per value, `analysis` computes statistics, `display` shows the raw value, `computed` is calculated in a COMPUTE block.

## Exporting data

```sas
proc export data=phdata.final_demo
            outfile='./outputs/final_demo.csv'
            dbms=csv replace;
run;

proc export data=phdata.final_demo
            outfile='./outputs/final_demo.xlsx'
            dbms=xlsx replace;
  sheet='demographics';
run;
```

Use PROC EXPORT for data and ODS for formatted tables.

## Titles and footnotes

```sas
title1 'Bleeds by severity level';
footnote1 'Educational practice data';
/* ... procedures ... */
title; footnote;          /* clear them afterward */
```

## Check yourself

1. Which destination statement creates a multi-sheet Excel workbook?
2. In PROC REPORT, what is the difference between `group` and `display`?
3. Why should every `ods ... file=` have a matching `close`?
