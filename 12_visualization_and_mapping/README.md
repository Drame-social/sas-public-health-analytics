# Phase 12 — Visualization & Mapping

**Module:** Module 12  
**Topics:** Statistical graphics with PROC SGPLOT, choropleth maps with PROC SGMAP/GMAP

## What You Will Learn
- Create scatter plots, bar charts, histograms, box plots, and line plots with `PROC SGPLOT`
- Overlay multiple plot types (scatter + regression line, histogram + density)
- Build choropleth maps of US counties using `PROC SGMAP` and the built-in MAPS library
- Customize colors, axes, titles, and legends

## Files
| File | Description |
|------|-------------|
| `Module_12_Visualization_and_Mapping.pdf` | Lecture notes with examples |

## Datasets Used (from `/data`)
`aidsvu_2016_newdx_county.sas7bdat` — AIDSVu 2016 new HIV diagnoses by US county  
Also uses: SASHELP.CLASS, SASHELP.PRDSALE, MAPS.US, MAPS.COUNTIES (built-in SAS libraries)

## Key SAS Syntax
```sas
/* Bar chart */
PROC SGPLOT DATA=phdata.atlgrades;
  VBAR grade / FILLATTRS=(COLOR=steelblue);
  TITLE 'Grade Distribution';
RUN;

/* Scatter with regression */
PROC SGPLOT DATA=sashelp.class;
  SCATTER X=height Y=weight;
  REG     X=height Y=weight;
RUN;

/* County-level choropleth map */
PROC SGMAP PLOTDATA=phdata.aidsvu_2016_newdx_county MAPDATA=MAPS.COUNTIES;
  CHOROMAP value=rate_per_100k / MAPID=FIPS;
  TITLE 'HIV New Diagnoses per 100,000 — 2016';
RUN;
```
