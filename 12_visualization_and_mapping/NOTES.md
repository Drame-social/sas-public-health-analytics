# Study Guide — Phase 12: Visualization & Mapping

## PROC SGPLOT basics

One procedure covers most statistical graphics. Each plot statement adds a layer.

```sas
proc sgplot data=phdata.final_clin;
  vbar hlevel / stat=freq;
  title 'Patients by severity level';
run;
title;
```

| Statement | Chart |
|---|---|
| `vbar x / group=g groupdisplay=cluster` | Clustered bar chart |
| `histogram x` (add `density x`) | Histogram with optional density curve |
| `vbox y / category=x` | Box plots by group |
| `scatter x=a y=b` (add `reg x=a y=b`) | Scatter plot with fitted line |
| `series x=time y=value / group=g` | Lines over time |

## Combining data before plotting

```sas
proc sort data=phdata.final_demo out=demo; by id; run;
proc sort data=phdata.final_clin out=clin; by id; run;

data demo_clin;
  merge demo clin;
  by id;
run;

proc sgplot data=demo_clin;
  vbar hlevel / group=htype groupdisplay=cluster;
run;

proc sgplot data=demo_clin;
  vbox bleeds / category=hlevel;
run;
```

## Readable charts

- Label axes: `xaxis label='Severity level'; yaxis label='Bleeds';`
- Order categories deliberately, for example with a numeric code and a format, instead of alphabetically.
- Save an image with `ods graphics / imagename='bleeds_box' imagefmt=png;` and an `ods listing gpath='./outputs';` destination.

## County maps

`phdata.aidsvu_2016_newdx_county` holds 2016 HIV new-diagnosis rates for Georgia counties. Two details matter before mapping:

- **Suppression codes.** Negative values are codes, not rates (the source withholds rates for counties with few cases). Set them to missing so they are not drawn as low rates. The file also ends with a blank row.
- **Joining to boundaries.** The map data must share a key with the rates, such as state and county FIPS codes.

```sas
data rates;
  set phdata.aidsvu_2016_newdx_county;
  if missing(county_name) then delete;     /* blank last row */
  if newdx_rate < 0 then newdx_rate = .;
run;

/* SAS 9.4M5 and later: county outlines from the MAPSGFK library */
proc sgmap mapdata=mapsgfk.us_counties (where=(statecode='GA'))
           maprespdata=rates;
  choromap newdx_rate / mapid=county;   /* county must exist in both datasets */
run;
```

The `mapid=` variable has to exist in both the map data and the rate data with the same type and coding. Run `PROC CONTENTS` on the map dataset first, because variable names differ between SAS releases. Older releases use `PROC GMAP` with `MAPS.COUNTY`.

## Interpreting rates

Rates in counties with small populations swing widely from year to year, which is why the source suppresses them. A choropleth map gives large rural counties more visual weight than their population warrants, so pair it with a table of counts.

## Check yourself

1. Why should suppressed values be set to missing before mapping?
2. Which statement draws box plots of `bleeds` for each `hlevel`?
3. What key links the rate data to the county boundaries?
