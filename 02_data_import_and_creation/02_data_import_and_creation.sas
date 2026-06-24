/* SAS Module 2 */


/*
 * LIBNAME SETUP
 * Update the path below to your local project data directory.
 * All SAS datasets (.sas7bdat) are located in the /data folder
 * at the root of this repository.
 *
 * Example (Windows): libname phdata 'C:\Users\YourName\sas-public-health-analytics\data';
 * Example (Unix/Mac): libname phdata '/home/yourname/sas-public-health-analytics/data';
 */
libname phdata './data';

/* Notes Section 2.1 */ 

DATA LESSON1;
INPUT STUDYID GENDER $ HEIGHT WEIGHT HAIR $ EYE $;
DATALINES;
01 FEMALE 64 120 BROWN BROWN
02 MALE 70 180 BLOND BLUE
03 MALE 72 200 BROWN BLUE
04 FEMALE 68 140 BROWN BROWN
05 MALE 71 170 BLOND BLUE
;
RUN;

DATA LESSON2;
INFILE 'H:\AEPI537D\RAWDATA.TXT';
INPUT STUDYID CACO $ AGE EXPOSURE $;
RUN;

DATA LESSON3;
INPUT @1 STUDYID @6 CACO $ @14 DATE MMDDYY10.;
DATALINES;
1000 CONTROL 08/19/1997
1001 CASE    04/24/2000
1003 CONTROL 12/02/1998
1004 CASE    09/16/1998
;
RUN;

/* phdata.LESSON4 dataset made using the import wizard */

PROC IMPORT OUT= WORK.LESSON5 DATAFILE= "H:\AEPI537D\RAWDAT2.xlsx" 
            DBMS=xlsx REPLACE;
     		SHEET="Sheet1"; 
     		GETNAMES=YES;
RUN;

/* Notes Section 2.2 */ 

/* Notes Section 2.3 */ 

PROC CONTENTS DATA=phdata.PHASE1;
RUN;

PROC CONTENTS varnum DATA=phdata.PHASE2;
RUN;

PROC CONTENTS DATA=phdata.LABS;
RUN;

PROC PRINT DATA=phdata.PHASE1;
	VAR STUDYID SEX AGE;
RUN;

PROC PRINT DATA=phdata.PHASE1 NOOBS LABEL;
VAR STUDYID SEX AGE;
LABEL STUDYID= 'Participant ID' 
      SEX= 'Sex at birth'
      AGE= 'Age' ;	
RUN;

PROC FREQ DATA=phdata.PHASE2;
	TABLES SEX AGE;
RUN;

PROC UNIVARIATE DATA=phdata.PHASE2;
	VAR AGE;
RUN;

/* Notes Section 2.4 */ 

DATA PHASE12;
	SET phdata.PHASE1 phdata.PHASE2;
RUN;

PROC PRINT DATA = PHASE12;
RUN;

PROC PRINT DATA = phdata.LABS;
RUN;

PROC SORT DATA = PHASE12;
	BY STUDYID;
RUN;

PROC SORT DATA = phdata.LABS;
	BY STUDYID;
RUN;

DATA phdata.LESSON6;
	MERGE PHASE12 phdata.LABS;
	by studyid;
RUN;

PROC PRINT DATA = phdata.LESSON6;
RUN;

/* MOD 2 #2 */

DATA fcohort;
	SET phdata.Cohort1516 phdata.Cohort1617;
RUN;

/* MOD 2 #3 */

PROC SORT DATA=fcohort;
	BY STUDYID;
RUN;

PROC SORT DATA=phdata.survey;
	BY STUDYID;
RUN;

DATA phdata.combo;
	MERGE fcohort phdata.survey;
	BY STUDYID;
RUN;

/* MOD 2 #4 */

/*
a. How many observations are there in the dataset? 356
b. How many variables are there in the dataset? 11
c. How many of the study subjects are women? 240
d. How many of the study subjects are single? 295
e. What is the average number of years of employment reported? 7.66
*/

proc contents data = phdata.combo;
run;

proc freq data = phdata.combo;
	tables sex;
run;

proc freq data = phdata.combo;
	tables marital;
run;
data fix_marital;
	set phdata.combo;
	marital = UPCASE(marital);
run;
proc freq data = fix_marital;
	tables marital;
run;

proc univariate data = phdata.combo;
	var yrswork;
run;
