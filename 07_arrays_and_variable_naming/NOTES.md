# Study Guide — Phase 07: Arrays & Variable Naming

## Why arrays

When the same step applies to many variables, an array lets you write it once. An array is only a temporary name for a group of variables inside one DATA step; it is not saved with the data.

## Variable lists

| List | Meaning |
|---|---|
| `var1-var15` | var1, var2, ..., var15 (numbered range) |
| `locatn1-locatn10` | the same idea for any prefix |
| `drug1a--drug7c` | every variable from drug1a to drug7c in dataset order |
| `_numeric_`, `_character_` | all numeric or all character variables |

## Recode a missing-value code

In `phdata.mod8_a`, the value 9 means "missing" in var1–var15.

```sas
data clean;
  set phdata.mod8_a;
  array v{15} var1-var15;
  do i = 1 to 15;
    if v{i} = 9 then v{i} = .;
  end;
  drop i;
run;
```

`DIM(v)` returns the number of elements, so `do i = 1 to dim(v);` keeps working if the list grows.

## Score across items

```sas
array t{3} test1-test3;
score = 0;
do i = 1 to 3;
  if missing(t{i}) then do; score = .; leave; end;
  score + t{i};
end;
```

`score = sum(of test1-test3);` is shorter but ignores missing items. Decide which rule your analysis needs.

## Flag if any element matches

```sas
array loc{10} locatn1-locatn10;
anyloc = 0;
do i = 1 to 10;
  if loc{i} in (1, 2, 6, 7) then anyloc = 1;
end;
```

## Count non-missing entries

```sas
array d{*} drug1a--drug7c;     /* {*} lets SAS count the elements */
ndrugs = n(of d{*});
```

## Creating new variables with an array

Listing names that do not exist yet creates them:

```sas
array wtlb{3} wt1-wt3;
array wtkg{3} wtkg1-wtkg3;     /* new variables */
do i = 1 to 3;
  wtkg{i} = wtlb{i} * 0.4536;
end;
```

## Common mistakes

- All elements of one array must be the same type (numeric or character).
- Forgetting `drop i;` leaves the loop counter in the output data.
- An array reference outside its range, such as `v{16}`, stops the step with an error.

## Check yourself

1. Rewrite the recode so it no longer depends on knowing there are 15 variables.
2. When would `sum(of ...)` give a different answer from the loop in the scoring example?
