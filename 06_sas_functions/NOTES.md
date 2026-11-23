# Study Guide — Phase 06: SAS Functions

A function takes one or more arguments and returns a value inside a DATA step: `new = FUNCTION(argument, ...);`

## Character functions

| Function | What it does | Example |
|---|---|---|
| `COMPRESS(s, chars)` | Removes characters | `compress('(404) 555-0100', '()- ')` → `4045550100` |
| `COMPRESS(s, , 'kd')` | Keeps digits only | same result as above |
| `STRIP(s)` | Removes leading and trailing blanks | |
| `UPCASE`, `LOWCASE`, `PROPCASE` | Change case | `propcase('MARY SMITH')` → `Mary Smith` |
| `SUBSTR(s, pos, n)` | Extracts part of a string | `substr('30303-1234', 1, 5)` → `30303` |
| `SCAN(s, n, delims)` | Returns the nth word | `scan('a@b.org', 2, '@')` → `b.org` |
| `SCAN(s, -1)` | Returns the last word | last name from a full name |
| `INDEX(s, text)` | Position of text, 0 if absent | `index(colors, 'red') > 0` |
| `TRANWRD(s, from, to)` | Replaces a word | `tranwrd(addr, 'Street', 'St')` |
| `CATX(sep, a, b, ...)` | Joins with a separator, trimming blanks | `catx(', ', city, state)` |
| `COUNTW(s, delims)` | Number of words | number of colors in a list |

## Numeric functions

| Function | Notes |
|---|---|
| `ROUND(x, unit)` | `round(3.14159, .01)` → 3.14 |
| `INT(x)` | Drops the decimal part |
| `ABS(x)`, `SQRT(x)` | Absolute value, square root |
| `SUM(of score1-score5)` | Ignores missing values |
| `MEAN(of score1-score5)` | Mean of non-missing values |
| `N(...)`, `NMISS(...)` | Count of non-missing and missing arguments |
| `MIN(...)`, `MAX(...)` | Ignore missing values |

`score1 + score2` is missing if either value is missing, while `sum(score1, score2)` is not. Choose deliberately.

## Date functions

```sas
today_dt = today();
visit_yr = year(visit_dt);
start_dt = mdy(1, 15, 2017);
months   = intck('month', start_dt, visit_dt);   /* month boundaries crossed */
next_dt  = intnx('month', visit_dt, 6, 'same');  /* same day, six months later */
```

## Missing-value helpers

- `MISSING(x)` works for numeric and character variables.
- `COALESCE(a, b, c)` returns the first non-missing numeric value; `COALESCEC` does the same for character values.

## Practice data

`phdata.mock_data` has phone numbers, emails, addresses, scores, ZIP codes, and comma-separated colors. Good exercises:

1. Strip every non-digit from `phone_num`.
2. Pull the domain out of `email`.
3. Write ZIP codes as five digits with leading zeros: `put(zipcode, z5.)`.
4. Average `score1-score5` and count how many scores each row has.
