# Study Guide — Phase 08: Longitudinal & Repeated Measures

## Data structure

`phdata.patients` has one row per clinic visit: several rows per `id`. Before analyzing, know what one row represents and how many rows each person has.

## Counting records per person

```sas
proc sort data=phdata.patients out=visits; by id visdate; run;

proc freq data=visits noprint;
  tables id / out=nvisits (rename=(count=totvisit) drop=percent);
run;

proc freq data=nvisits;
  tables totvisit;
run;
```

## FIRST. and LAST.

After sorting, a `BY` statement in a DATA step creates temporary flags. `first.id` is 1 on the first row of each id, and `last.id` is 1 on the last row.

```sas
data baseline;           /* first visit per person */
  set visits;
  by id;
  if first.id;
run;

data lastvisit;
  set visits;
  by id;
  if last.id;
run;
```

## RETAIN: carry values across rows

Normally SAS resets new variables to missing on each row. `RETAIN` keeps the value.

```sas
data numbered;
  set visits;
  by id;
  retain visit_n 0;
  if first.id then visit_n = 0;
  visit_n + 1;            /* the sum statement also retains automatically */
run;
```

## Previous value with LAG

```sas
data change;
  set visits;
  by id;
  prev_wt = lag(weight);
  if first.id then prev_wt = .;   /* don't borrow from the previous person */
  wt_change = weight - prev_wt;
run;
```

Always call `LAG` on every row (not inside an IF). It returns the value from the last time it was executed, so calling it conditionally gives unexpected results.

## Per-person summaries merged back

```sas
proc means data=visits noprint nway;
  class id;
  var allblds jtblds empft;
  output out=per_person (drop=_type_ _freq_)
         mean(allblds jtblds)=avgblds avgjtblds
         max(empft)=everempft;
run;

data baseline2;
  merge baseline (in=a) per_person;
  by id;
  if a;
run;
```

## Reshaping with PROC TRANSPOSE

```sas
proc transpose data=phdata.mod8_c out=long (rename=(col1=location)) name=position;
  by studyid;
  var locatn1-locatn10;
run;
```

The input must be sorted by the BY variable. Add `where location ne .;` in a later step to drop empty positions.

## Check yourself

1. Why must the data be sorted before using `first.id`?
2. What goes wrong if `prev_wt` is not reset on `first.id`?
3. How many rows per person does the long dataset from PROC TRANSPOSE have before empty positions are removed?
