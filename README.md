# Public Health Analytics — SAS

*By Aly Drame, MD, MPH, MBA.* A structured SAS programming curriculum applied to public-health data, from environment setup through reporting and visualization. Datasets are synthetic or built-in SAS library data (Emory AEPI537D course material) — no real patient or program records.

---

## Overview

This repository presents a structured SAS programming curriculum applied to public health datasets. Topics are organized to follow the **natural data analysis workflow** — from environment setup and raw data import through transformation, analysis, reporting, automation, and visualization.

The course material originates from AEPI537D (Introduction to SAS Programming) at the Rollins School of Public Health, Emory University. All datasets are either synthetic or built-in SAS library datasets.

---

## Analysis Workflow

```
01 Environment Setup
        ↓
02 Data Import & Creation
        ↓
03 Data Merging & Subsetting
        ↓
04 Categorical Variables & Dates
        ↓
05 Conditionals & Type Conversion
        ↓
06 SAS Functions
        ↓
07 Arrays & Variable Naming
        ↓
08 Longitudinal & Repeated Measures
        ↓
09 Variable Documentation & Formats
        ↓
10 Reporting & Export
        ↓
11 Automation & Macros
        ↓
12 Visualization & Mapping
```

---

## Repository Structure

```
sas-public-health-analytics/
├── README.md
├── data/                                        # All SAS datasets (.sas7bdat)
│   └── raw/                                     # Raw input files (.txt, .xls)
├── docs/                                        # Course syllabus
├── final_exam/                                  # Final exam materials
│
├── 01_environment_setup/                        # SAS interface, libnames, best practices
├── 02_data_import_and_creation/                 # Reading raw data, creating permanent datasets
├── 03_data_merging_and_subsetting/              # Merging, concatenating, subsetting
├── 04_categorical_variables_and_dates/          # IF/THEN grouping, date functions, arithmetic
├── 05_conditionals_and_type_conversion/         # IF-ELSE chains, numeric/character conversion
├── 06_sas_functions/                            # COMPRESS, SUBSTR, SCAN, numeric functions
├── 07_arrays_and_variable_naming/               # Arrays, DO loops, variable renaming patterns
├── 08_longitudinal_and_repeated_measures/       # FIRST./LAST., RETAIN, multiple obs/subject
├── 09_variable_documentation_and_formats/       # RENAME, LABEL, FORMAT, INFORMAT
├── 10_reporting_and_export/                     # ODS, PROC REPORT, PROC EXPORT
├── 11_automation_and_macros/                    # Macro variables, macro programs, %DO loops
└── 12_visualization_and_mapping/               # PROC SGPLOT, choropleth maps
```

---

## Datasets

| Dataset | Description | Used In |
|---------|-------------|---------|
| `phase1.sas7bdat` | Phase 1 cohort — demographic and enrollment variables | Phases 02, 03 |
| `phase2.sas7bdat` | Phase 2 follow-up — visits, lab results | Phases 02, 03 |
| `labs.sas7bdat` | Laboratory results per subject | Phases 02, 03 |
| `cohort1516.sas7bdat` | 2015–2016 cohort enrollment data | Phase 02 |
| `cohort1617.sas7bdat` | 2016–2017 cohort enrollment data | Phase 02 |
| `survey.sas7bdat` | Survey responses dataset | Phase 02 |
| `mod3lab.sas7bdat` | Lab data supplement for merging exercises | Phase 03 |
| `mod4.sas7bdat` | Dataset for categorical variable creation and date exercises | Phase 04 |
| `atlgrades.sas7bdat` | Student grade data — used for IF/ELSE logic exercises | Phases 05, 12 |
| `mod6.sas7bdat` | Case-control dataset for variable management exercises | Phase 09 |
| `mock_data.sas7bdat` | Mixed-type dataset for SAS function practice | Phase 06 |
| `mod8_a–d.sas7bdat` | Four datasets for array and DO-loop exercises | Phase 07 |
| `pets.sas7bdat` | Pet ownership dataset for variable naming exercises | Phase 07 |
| `patients.sas7bdat` | Patient records with multiple visits per subject | Phase 08 |
| `mod9.sas7bdat` | Multi-observation dataset for longitudinal exercises | Phase 08 |
| `flbygroup.sas7bdat` | Flu surveillance data by group | Phase 08 |
| `patients_part2.sas7bdat` | Extended patient follow-up dataset | Phase 08 |
| `screener_data.sas7bdat` | Screening questionnaire data | Phase 08 |
| `tagsetex.sas7bdat` | Tagset example data for ODS reporting | Phase 10 |
| `aidsvu_2016_newdx_county.sas7bdat` | AIDSVu 2016 new HIV diagnoses by US county | Phase 12 |
| `final_clin.sas7bdat` | Final exam — clinical outcomes dataset | Final Exam |
| `final_demo.sas7bdat` | Final exam — demographic dataset | Final Exam |

---

## How to Run

1. Clone or download this repository to your local machine.
2. Open each `.sas` script in SAS 9.4 (or SAS Studio).
3. At the top of each script, update the `libname phdata` path to point to the `/data` folder in this repository:
   ```sas
   libname phdata 'C:\Users\YourName\sas-public-health-analytics\data';
   ```
4. Run scripts in phase order (01 → 12) for the complete workflow.

---

## Key SAS Procedures Covered

| Procedure | Purpose | Phase |
|-----------|---------|-------|
| `DATA step` | Dataset creation, transformation, logic | 02–09 |
| `PROC IMPORT` | Read Excel and delimited text files | 02 |
| `PROC SORT` | Sort datasets before merging | 03 |
| `PROC FREQ` | Frequency tables, cross-tabulations | 04–09 |
| `PROC MEANS` / `PROC UNIVARIATE` | Descriptive statistics | 04–08 |
| `PROC FORMAT` | Define custom value formats | 09 |
| `PROC PRINT` | Display dataset contents | 02–10 |
| `PROC REPORT` | Publication-ready tabular reports | 10 |
| `PROC EXPORT` | Export data to Excel, CSV, RTF | 10 |
| `ODS` statements | Control output destination and style | 10 |
| `%MACRO` / `%MEND` | Define and call macro programs | 11 |
| `PROC SGPLOT` | Statistical graphics | 12 |
| `PROC GMAP` / `PROC SGMAP` | Choropleth maps | 12 |

---

## Public Health Context

Public health data analysis frequently involves messy, multi-source datasets — survey records, clinical extracts, administrative files, and surveillance reports. The skills in this repository address the full pipeline a public health analyst encounters:

- Importing heterogeneous data formats (text, Excel, proprietary)
- Merging datasets from different collection arms (clinical + demographic + lab)
- Creating analysis-ready variables (age groups, exposure windows, date intervals)
- Handling longitudinal data with multiple encounters per subject
- Producing clean, labeled output for reports and publications
- Automating repetitive tasks with macros
- Visualizing geographic and distributional patterns

---

*Educational materials from AEPI537D, Rollins School of Public Health, Emory University. All datasets are synthetic or built-in SAS library data. No real patient, provider, or program records are included.*
