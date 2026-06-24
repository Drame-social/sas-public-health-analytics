/* SAS Module 6 */


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

/* Notes Section 6.1 */

DATA TEMP;
	SET phdata.mod6;
		RENAME ILL = CACO;
RUN;

PROC FREQ DATA = TEMP;
	TABLES CACO;  
RUN;

DATA TEMP;
	SET phdata.mod6 (RENAME=(ILL = CACO));
RUN;

PROC FREQ DATA = TEMP;
	TABLES CACO;  
RUN;

DATA TEMP2;
	SET TEMP;
	LABEL SEX1   = 'GENDER' 
          WT3LEV = 'WEIGHT CATEGORY' ;
RUN;

PROC FREQ DATA = TEMP2;
	TABLES SEX1*WT3LEV;
RUN;

DATA phdata.mod6_rev;
	SET TEMP2;
RUN;

/* Notes Section 6.2 */

PROC FORMAT;
	VALUE YESNOF
		0='NO'
		1='YES' ;
RUN;

PROC FREQ DATA=TEMP2;
	TABLES (SMOKE PLANE VITAMIN)*WT3LEV;
	FORMAT SMOKE PLANE VITAMIN YESNOF.;
RUN;

PROC FORMAT;
	VALUE AGEFMT
		15 - 24 = '<25'
		25 - 29 = '25-29'
		30 - 100 = '30+';
RUN;

PROC FREQ DATA=TEMP2;
	TABLES ENTRYAGE*SMOKE;
	FORMAT ENTRYAGE AGEFMT.;
RUN;

LIBNAME LIBRARY 'H:\AEPI537D';    

PROC FORMAT LIBRARY = LIBRARY; 

  VALUE GENDERF
	1='FEMALE'
	0='MALE';

  VALUE SMOKERF
	0='NO'
	1='YES';

RUN;
 
DATA phdata.mod6_fmt;
	SET TEMP2;
	FORMAT SEX1 GENDERF. SMOKE SMOKERF. ;
RUN;

LIBNAME LIBRARY 'H:\AEPI537D';

PROC FREQ DATA=phdata.mod6_rev;
	TABLES SEX1*SMOKE;
RUN;

PROC FREQ DATA=phdata.mod6_fmt;
	TABLES SEX1*SMOKE;
RUN;

/* Notes Section 6.3 */

ODS RTF FILE='H:\AEPI537D\SAMPLE.RTF';
PROC FREQ DATA=TEMP2;
	TABLES ENTRYAGE*SMOKE;
	FORMAT ENTRYAGE AGEFMT.;
RUN;
ODS RTF CLOSE;  


ODS NORESULTS;
ODS PDF FILE = 'H:\AEPI537D\SAMPLE.PDF';
PROC FREQ DATA=phdata.mod6_fmt;
	TABLES SEX1*SMOKE;
RUN;
ODS PDF CLOSE;

/*ODS RESULTS;*/

/*Proc template; list styles; RUN;*/

ODS PDF FILE = 'H:\AEPI537D\SAMPLE.PDF' style = journal;
PROC FREQ DATA=phdata.mod6_fmt;
	TABLES SEX1*SMOKE;
RUN;
ODS PDF CLOSE;

/* Notes Section 6.4 */

DATA TEMP3(DROP=KIDS HOUSE);
	SET phdata.mod6_rev;
		IF STUDYID=29 THEN CACO=0;
RUN;

PROC CONTENTS DATA = phdata.mod6_rev;
RUN;

PROC CONTENTS DATA = TEMP3;
RUN;

PROC COMPARE DATA = phdata.mod6_rev COMPARE = TEMP3;
	ID STUDYID;
RUN;

DATA DBP;
INPUT STUDYID BP;
DATALINES;
01 126
01 131
01 135
01 124
02 145
02 144
02 140
02 142
03 150
03 148
03 152
03 160
04 120
04 119
04 115
04 120
05 125
05 130
05 135
05 128
;
RUN;

PROC PRINT DATA = DBP; RUN;

PROC TRANSPOSE DATA = DBP OUT = DBP2;
RUN;

PROC PRINT DATA = DBP2; RUN;

PROC TRANSPOSE DATA = DBP OUT = DBP3 
  (RENAME = (COL1 = TIME1 COL2 = TIME2 COL3 = TIME3 COL4 = TIME4));
	  BY STUDYID;
	  VAR BP;
RUN;

PROC PRINT DATA = DBP3; 
RUN;

data _NULL_;
	call symput ("db", put(today(), date9.));
run;

ods pdf file = "H:\AEPI537D\ANOTHERSAMPLE_&db..pdf" style = journal ;
		PROC PRINT DATA = DBP3; RUN;
ods pdf close;

/* MOD 6 #1 */

/* 1a */
data TEMPLAB;
set phdata.mod6_REV;
label ENTRYAGE = 'Participant age at enrollment'
KIDS = 'Total number of kids in household';
run;

/* 1b 1c */
PROC FORMAT;
  value AGEf
	15 - 17 = '<18'
	18 - 29 = '18-29'
	30 - 39 = '30-39'
	40 - 49 = '40-49'
	50 - 100 = '50+' ;
  value MARITALf
	0 = 'Married'
	1 = 'Unmarried' ;
RUN;

/* MOD 6 #2 */
ODS RTF FILE='H:\AEPI537D\MOD6Q2.RTF';
	proc freq data=TEMPLAB;
	tables ENTRYAGE MARITAL1;
	format ENTRYAGE AGEf. MARITAL1 MARITALf.;
	run;
ODS RTF CLOSE;

/* MOD 6 #3 */
PROC TRANSPOSE DATA = tpose OUT = tpose2
(RENAME = (COL1 = score1 COL2 = score2 COL3 = score3));
BY ID;
VAR score;
RUN;
PROC PRINT DATA = tpose2; RUN;





