# Phase 10 — Reporting & Export

**Module:** Module 10  
**Topics:** ODS (Output Delivery System), PROC REPORT, exporting to Excel/CSV/RTF/HTML

## What You Will Learn
- Use ODS statements to direct output to RTF, HTML, Excel, and PDF destinations
- Build structured, publication-ready tables with `PROC REPORT`
- Export datasets to external file formats using `PROC EXPORT`
- Control report appearance with ODS styles and formatting options

## Files
| File | Description |
|------|-------------|
| `10_reporting_and_export.sas` | Solution script |
| `10_mwsug_reporting_examples.sas` | Advanced ODS examples from MWSUG 2010 article |
| `Module_10_Reporting_and_Export.pdf` | Lecture notes |
| `MWSUG_2010_Advanced_Reporting.pdf` | MWSUG 2010 article on advanced ODS reporting |

## Datasets Used (from `/data`)
`tagsetex.sas7bdat` (also uses SASHELP.CLASS, SASHELP.IRIS)

## Key SAS Syntax
```sas
/* Export to Excel */
PROC EXPORT DATA=results OUTFILE='output.xlsx' DBMS=XLSX REPLACE; RUN;

/* ODS to RTF */
ODS RTF FILE='report.rtf' STYLE=Journal;
PROC REPORT DATA=results NOWD;
  COLUMN region count pct;
  DEFINE region / DISPLAY 'Region';
  DEFINE count  / ANALYSIS SUM 'N';
  DEFINE pct    / COMPUTED FORMAT=8.1 '% of Total';
RUN;
ODS RTF CLOSE;
```
