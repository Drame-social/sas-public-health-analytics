# Study Guide — Phase 04: Categorical Variables & Dates

## Choosing cut points

Look at the distribution before grouping a continuous variable.

```sas
proc univariate data=phdata.mod4;
  var weight;
run;
```

Use cut points that mean something (clinical thresholds, published categories) or data-driven ones such as tertiles.

## Grouping with IF-THEN

```sas
data temp;
  set phdata.mod4;
  if 0 < weight <= 126      then wt3lev = 0;
  else if 126 < weight <= 149 then wt3lev = 1;
  else if weight > 149        then wt3lev = 2;
run;
```

**The missing-value trap.** SAS treats a missing numeric value as smaller than any number. A condition such as `if weight <= 126` is true for missing weights, so they land in the lowest group. Start ranges at `0 <` or test `if missing(weight)` first.

Always check new categories against the source variable:

```sas
proc freq data=temp;
  tables weight*wt3lev / missing list;
run;
```

## Data-driven groups

```sas
proc rank data=phdata.mod4 out=ranked groups=3;
  var weight;
  ranks wt_tertile;          /* 0, 1, 2 */
run;
```

Tied values are kept in the same group, so group sizes may not be exactly equal.

## Arithmetic and derived variables

```sas
bw_oz    = birthlb*16 + birthoz;
bw_gm    = bw_oz*28.35;
ht_in    = heightft*12 + heightin;
weightkg = weight*0.4536;
heightm  = ht_in*0.0254;
bmi      = weightkg / heightm**2;
```

If any operand is missing, the result is missing and the log reports "Missing values were generated". Functions such as `SUM()` and `MEAN()` ignore missing values instead.

## SAS dates

- A SAS date is the number of days since 1 January 1960. That is why `bd` in `mod4` looks like 5691.
- Formats change how a date is displayed, not its value: `format bd mmddyy10.;`
- Build a date from parts with `MDY(month, day, year)`; extract parts with `YEAR()`, `MONTH()`, `DAY()`.
- Differences between dates are in days:

```sas
calc_age = (surveydt - bd) / 365.25;     /* exact age in years */
entryage = int(calc_age);                /* completed years    */
```

`YRDIF(bd, surveydt, 'AGE')` gives the same idea with calendar-aware rules.

## Check yourself

1. Why would `if weight <= 135 then wt2lev = 0;` misclassify some records?
2. What number does SAS store for 2 January 1960?
3. What is the difference between applying a format and creating a new variable?
