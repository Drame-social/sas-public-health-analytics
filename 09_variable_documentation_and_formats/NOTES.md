# Study Guide — Phase 09: Variable Documentation & Formats

Documentation makes a dataset usable by someone else, including you six months later.

## Renaming

```sas
data mod6_rev;
  set phdata.mod6 (rename=(sex1=gender_code));   /* dataset option */
  rename wt3lev = weight_cat;                     /* statement, applied on output */
run;
```

## Labels

A label is a longer description shown in procedure output; the variable name stays the same.

```sas
data mod6_rev;
  set mod6_rev;
  label entryage = 'Participant age at enrollment'
        kids     = 'Total number of kids in household'
        bmi      = 'Body mass index (kg/m2)';
run;
```

`PROC CONTENTS` lists each variable with its label.

## Value formats

A format maps stored values to display text without changing the data.

```sas
proc format;
  value yesnof  0 = 'No'  1 = 'Yes';
  value agefmt  15 - 24 = '<25'
                25 - 29 = '25-29'
                30 - high = '30+';
run;

proc freq data=phdata.mod6;
  tables (smoke plane vitamin) * wt3lev;
  format smoke plane vitamin yesnof.;
run;
```

The same format can group values in a table without creating a new variable, as `agefmt.` does for `entryage`.

## Saving formats

Formats defined with a plain `PROC FORMAT` live in WORK and disappear at the end of the session. To keep them:

```sas
libname library './data';
proc format library=library;
  value yesnof 0 = 'No' 1 = 'Yes';
run;
```

SAS searches the `LIBRARY` libref automatically. If you open a dataset with permanent formats but no format catalog, add `options nofmterr;` so SAS still opens it.

## Building a codebook

```sas
proc contents data=phdata.mod6 varnum;   /* variables in dataset order */
run;

proc freq data=phdata.mod6;
  tables sex1 wt3lev smoke / missing;    /* categorical values and missing counts */
run;

proc means data=phdata.mod6 n nmiss mean min max;
  var weight bmi entryage;
run;
```

## Sending output to a document

```sas
ods rtf file='./outputs/mod6_tables.rtf';
proc freq data=phdata.mod6;
  tables entryage marital1;
  format entryage agefmt.;
run;
ods rtf close;
```

## Check yourself

1. Does applying `format smoke yesnof.;` change the stored value of `smoke`?
2. Where does SAS look for a format named `yesnof.` that is not in WORK?
3. What is the difference between a label and a format?
