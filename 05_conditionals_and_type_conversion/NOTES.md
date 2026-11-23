# Study Guide — Phase 05: Conditionals & Type Conversion

## IF-THEN-ELSE

```sas
data grades2;
  set phdata.atlgrades;
  if grade >= 60 then course = 'Pass';
  else course = 'Fail';
run;
```

## Why ELSE IF matters

Separate IF statements are all evaluated, so a later one can overwrite an earlier result:

```sas
if grade >= 90 then ltr = 'A';
if grade >= 80 then ltr = 'B';     /* a 95 becomes 'B' here ... */
if grade >= 0  then ltr = 'F';     /* ... and 'F' here          */
```

With `ELSE IF`, SAS stops at the first true condition:

```sas
if grade >= 90      then ltr = 'A';
else if grade >= 80 then ltr = 'B';
else if grade >= 70 then ltr = 'C';
else if grade >= 60 then ltr = 'D';
else if not missing(grade) then ltr = 'F';
```

The last line keeps missing grades missing instead of failing them.

## Character length

The first time SAS sees a character variable it fixes its length. If the first value assigned is `'Pass'` (4 characters), a later `'Incomplete'` is cut to `'Inco'`. Set the length up front:

```sas
length course $ 10;
```

## Character to numeric: INPUT()

`INPUT(value, informat)` reads text using the rules of an informat.

| Text | Code | Result |
|---|---|---|
| `'50000'` | `input(x, 8.)` | 50000 |
| `'15%'` | `input(x, percent8.)` | 0.15 |
| `'43,000.24'` | `input(x, comma9.2)` | 43000.24 |
| `'01-11-2019'` | `input(x, mmddyy10.)` | a SAS date |

## Numeric to character: PUT()

`PUT(value, format)` writes a number as text.

```sas
id_txt  = put(studyid, z6.);        /* 537 -> '000537' */
amt_txt = put(43000.24, dollar12.2);
```

## Changing a variable's type and keeping its name

A variable cannot change type in place. Create a new one, drop the old, then rename:

```sas
data fixed;
  set raw;
  zip_num = input(zip, 5.);
  drop zip;
  rename zip_num = zip;
run;
```

## Automatic conversion

If you use a character value in arithmetic, SAS converts it and writes "Character values have been converted to numeric values" in the log. Treat that note as a warning and convert explicitly.

## Check yourself

1. Rewrite the letter-grade code so a grade of 95 is not reassigned.
2. Which function turns `'15%'` into 0.15?
3. Why does a new character variable sometimes lose the end of its values?
