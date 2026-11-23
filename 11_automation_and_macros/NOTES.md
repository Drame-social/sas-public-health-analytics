# Study Guide — Phase 11: Automation & Macros

The macro language writes SAS code for you. It runs before the code is compiled, so it works with text, not data values.

## Macro variables

```sas
%let ds = phdata.final_clin;
%let outcome = bleeds;

proc means data=&ds n mean;
  var &outcome;
run;
```

- Reference with `&name`. Use double quotes when a macro variable appears in text: `title "Summary of &outcome";` (single quotes stop resolution).
- `%put &=outcome;` writes the value to the log.
- Automatic variables include `&sysdate9` and `&sysuserid`.

## Macro programs

```sas
%macro summarize(data=, class=, var=);
  proc means data=&data n nmiss mean std;
    class &class;
    var &var;
  run;
%mend summarize;

%summarize(data=phdata.final_clin, class=hlevel, var=bleeds)
%summarize(data=phdata.final_clin, class=hlevel, var=weightkg)
```

Keyword parameters (`data=`) make calls easy to read and let you set defaults.

## Loops

```sas
%macro inventory;
  %let list = mod3lab mod4 mod6 mod9;
  %do i = 1 %to %sysfunc(countw(&list));
    %let ds = %scan(&list, &i);
    title "Contents of &ds";
    proc contents data=phdata.&ds varnum; run;
  %end;
  title;
%mend inventory;
%inventory
```

## Conditional logic

```sas
%macro freq_or_means(var=, type=);
  %if &type = cat %then %do;
    proc freq data=phdata.final_clin; tables &var; run;
  %end;
  %else %do;
    proc means data=phdata.final_clin; var &var; run;
  %end;
%mend;
```

## Values from data into macro variables

```sas
proc sql noprint;
  select count(*) into :n_patients trimmed
  from phdata.final_demo;
quit;
%put Patients: &n_patients;
```

## Debugging

```sas
options mprint mlogic symbolgen;   /* show generated code and macro decisions */
```

Turn these off with `options nomprint nomlogic nosymbolgen;` when finished.

## Check yourself

1. Why does `title 'Summary of &outcome';` print the literal text `&outcome`?
2. Write a call to `%summarize` for `weightkg` by `htype`.
3. What does `options mprint;` add to the log?
