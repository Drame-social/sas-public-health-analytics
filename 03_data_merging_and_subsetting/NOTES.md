# Study Guide — Phase 03: Merging & Subsetting

## Merging by a key

A match-merge combines rows that share a key value. Both datasets must be sorted by the key first.

```sas
proc sort data=phdata.phase2 out=phase2; by studyid; run;
proc sort data=phdata.labs   out=labs;   by studyid; run;

data p2_labs;
  merge phase2 labs;
  by studyid;
run;
```

Without any condition, the result keeps every ID found in either dataset (a full join). Variables that come from the dataset where an ID is absent are missing.

## Controlling which records are kept: IN=

`IN=` creates a temporary 0/1 flag showing whether the current row came from that dataset.

```sas
data p2_with_labs;
  merge phase2 (in=a) labs (in=b);
  by studyid;
  if a;                 /* keep every phase2 record (left join) */
  * if a and b;         /* keep matches only (inner join)       */
  * if a and not b;     /* phase2 records with no lab result    */
run;
```

The last form is useful for data quality checks: it lists records that failed to match.

## Common merge problems

- **Not sorted.** SAS stops with "BY variables are not properly sorted".
- **Different key types.** `studyid` numeric in one file and character in the other will not merge; convert one first.
- **Same non-key variable in both files.** The value from the dataset listed last overwrites the first. Rename one with `(rename=(age=age_lab))`.
- **Duplicate keys in both files.** A many-to-many merge does not produce all combinations in a DATA step; use PROC SQL if that is really what you need.

## Subsetting rows

```sas
data women;
  set phdata.mod3lab;
  where sex = 'female';                 /* filters as data are read */
run;

data married_smokers;
  set phdata.mod3lab;
  if marital = 'married' and smoke = 1; /* subsetting IF */
run;
```

`WHERE` works only on variables already in the input data and is usually faster. A subsetting `IF` can test variables you create earlier in the same DATA step.

## Subsetting columns

```sas
data lifestyle;
  set phdata.mod3lab (keep=studyid sex smoke sleep calorie fruit vitamin);
run;

data no_dates;
  set phdata.mod3lab (drop=bd surveydt);
run;
```

## Check yourself

1. Which `IF` statement keeps only IDs present in both datasets?
2. Why must both datasets be sorted before a MERGE?
3. When can you not use `WHERE` and must use a subsetting `IF`?
