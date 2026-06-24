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

* SAS Module 9 Solution;

/* Notes Section 9.1 */

DATA TEMP;
	SET phdata.PATIENTS;
RUN;

PROC SORT DATA=TEMP;
	BY ID;
RUN;

DATA TEMP2;
	SET TEMP;
		VISIT=1;
RUN;

PROC SUMMARY DATA=TEMP2;
	CLASS ID;
	VAR VISIT;
	OUTPUT OUT=TEMP3 SUM=TOTVISIT;
RUN;

PROC FREQ DATA=TEMP3;
	TABLES TOTVISIT;
	WHERE _TYPE_=1;
RUN;

PROC SORT DATA=TEMP;
	BY ID VISDATE;
RUN;

DATA FIRSTVISIT;
	SET TEMP;
		BY ID;
		IF FIRST.ID=1;
RUN;

PROC FREQ DATA=FIRSTVISIT;
	TABLES EMPFT;
	TITLE Employment status at study baseline;
RUN;

PROC SUMMARY DATA=TEMP2;
	CLASS ID;
	VAR ALLBLDS;
	OUTPUT OUT=TEMP4 MEAN=AVGBLDS;
RUN;

PROC UNIVARIATE DATA=TEMP4;
	VAR AVGBLDS;
	WHERE _TYPE_=1;
	TITLE; *This line turns off the title from the previous frequency procedure;
RUN;

PROC SORT DATA=FIRSTVISIT;
	BY ID;
RUN;

PROC SORT DATA=TEMP4;
	BY ID;
RUN;
 
DATA TEMP5(DROP=_TYPE_ _FREQ_);
	MERGE FIRSTVISIT(IN=A) TEMP4;
	BY ID;
	IF A;
RUN;

PROC SUMMARY DATA=TEMP2;
	CLASS ID;
	VAR ALLBLDS JTBLDS EMPFT;
	OUTPUT OUT=TEMP4 MEAN(ALLBLDS JTBLDS)=AVGBLDS AVGJTBLDS
                     MAX(EMPFT)=EVEREMPFT ;
RUN;

PROC SORT DATA=FIRSTVISIT;
	BY ID;
RUN;

PROC SORT DATA=TEMP4;
	BY ID;
RUN;
 
DATA TEMP5(DROP=_TYPE_ _FREQ_);
	MERGE FIRSTVISIT(IN=A) TEMP4;
	BY ID;
	IF A;
RUN;

PROC FREQ DATA=phdata.mod9;
	TABLES STUDYID;
RUN;

PROC SORT DATA=phdata.mod9;
	BY STUDYID;
RUN;

DATA DUPES;
	SET phdata.mod9;
		BY STUDYID;
		IF ^(FIRST.STUDYID AND LAST.STUDYID);
RUN;

/* Notes Section 9.2 */

PROC SORT DATA = phdata.FLBYGROUP; by SITE AGEGROUP; RUN;

DATA FLBYGROUP_REV;
	SET phdata.FLBYGROUP;		
		COUNT + 1;
		BY SITE AGEGROUP;
		IF FIRST.AGEGROUP then COUNT=1;
RUN;

DATA FLBYGROUP_REV2;
		SET FLBYGROUP_REV;
			BY SITE AGEGROUP;
			IF LAST.AGEGROUP;
RUN;

/* Notes Section 9.3 */

PROC SORT DATA= phdata.mod9 NODUPKEY OUT=NODUPES DUPOUT=DUPESONLY;
	BY STUDYID;
RUN;

/* Notes Section 9.4 */

data retain_ex1_a;
input month income;
datalines;
 1 12451
 2 54325
 3 43514
 4 13455
 5 45161
 6 54151
 7 54261
 8 43251
 9 43515
 10 83711
 11 45236
 12 54361
 ;
run;

data retain_ex1_b;
	set retain_ex1_a;
		cumulative_income = sum(income,cumulative_income);
run;

data retain_ex1_c;
	set retain_ex1_a;
 	retain cumulative_income;
 		cumulative_income = sum(income,cumulative_income);
run;  

data prdsale;
	set sashelp.prdsale;
		where country = 'CANADA' and product = 'SOFA';
 	drop region division prodtype predict quarter;
run;

proc sort data = prdsale;
	by month actual ;
run;

data first_last;
	set prdsale;
  	by month;
 
 	if first.month then month_order = 'FIRST';
 	if last.month then month_order = 'LAST';
run; 

proc sort data = prdsale;
	by month ;
run;
data prdsale_noretain;
	set prdsale;
  	by month;
 
 	if first.month then cumulative_actual = actual;
 		else cumulative_actual = cumulative_actual + actual;
run;

proc sort data = prdsale;
	by month ;
run;
data prdsale_retain;
	set prdsale;
  	by month;
 
	retain cumulative_actual;
	 
	if first.month then cumulative_actual = actual;
		else cumulative_actual = cumulative_actual + actual;
 
run;  

DATA TEMP6;
	SET phdata.PATIENTS;
RUN;

PROC SORT DATA = TEMP6;
	BY ID VISDATE;
RUN;

DATA TEMP7;
SET TEMP6;

BY ID;

IF JTBLDS > 0 THEN EVERJTBLDS = 1;
ELSE IF JTBLDS = 0 THEN EVERJTBLDS = 0;

IF FIRST.ID THEN HXJTBLDS = EVERJTBLDS;

ELSE DO;
IF EVERJTBLDS = 1 THEN HXJTBLDS = 1;
ELSE HXJTBLDS = KEEPJTBLDS;
END;

KEEPJTBLDS = HXJTBLDS;
RETAIN KEEPJTBLDS;

RUN;

/* Mod 9 #1 */

PROC SORT DATA=phdata.PATIENTS_PART2;
	BY ID;
RUN;

DATA ONEOBS;
	SET phdata.PATIENTS_PART2;
	BY ID;
	IF FIRST.ID=1;
RUN;

/* Mod 9 #2 */

DATA TEMP1;
	SET phdata.PATIENTS_PART2;
	VISIT=1;
RUN;

PROC SUMMARY DATA=TEMP1;
	CLASS ID;
	VAR VISIT;
	OUTPUT OUT=TEMP2 SUM=ALLVISITS;
RUN;

PROC FREQ DATA=TEMP2;
	TABLES ALLVISITS;
	WHERE _TYPE_=1;
RUN;

/* Mod 9 #3 */

PROC SORT DATA=phdata.PATIENTS_PART2;
	BY ID VISDATE;
RUN;

DATA LASTVISIT;
	SET phdata.PATIENTS_PART2;
	BY ID;
	IF LAST.ID=1;
RUN;

PROC MEANS DATA=LASTVISIT MEAN;
	VAR JTBLDS;
RUN;

/*or*/

PROC UNIVARIATE DATA=LASTVISIT;
VAR JTBLDS;
RUN;
 
/* Mod 9 #4 */

PROC SUMMARY DATA=TEMP1;
	CLASS ID;
	VAR WEIGHTKG;
	OUTPUT OUT=TEMP3 MEAN=AVGWT;
RUN;

PROC SORT DATA=LASTVISIT;
	BY ID;
RUN;

PROC SORT DATA=TEMP3;
	BY ID;
RUN;
 
DATA TEMP4(DROP=_TYPE_ _FREQ_);
	MERGE LASTVISIT(IN=A) TEMP3;
	BY ID;
	IF A;
RUN;

/* Mod 9 #5 */

/* Date and time stamp (optional) */
data _NULL_;
                  call symput ("db", put(today(), date9.));
run;
	
proc sort data = phdata.screener_data ; by site ; run;
data screener_data_totals;
		set phdata.screener_data;
		retain total_screened total_partial total_complete total_inelig total_elig;
		by site;

		if first.site then do;
			total_screened = 0;
			total_partial  = 0;
			total_complete = 0;
			total_elig = 0;	
			total_inelig = 0;	
		end;

		* total screened ;   total_screened = 	total_screened + 1;
	
		* partial ;   if Vstatus = "Partial" then total_partial = total_partial + 1; 
		* complete ;  if Vstatus = "Complete" then total_complete = total_complete + 1; 

		* eligible ;  if Vstatus = "Complete" & elig = 1 then total_elig = total_elig + 1; 
		* ineligible ; if Vstatus = "Complete" & elig = 0 then total_inelig = total_inelig + 1;
	

		label
				total_screened = "# screening records"
				total_partial = "# partial screeners"
				total_complete = "# complete screeners"
				total_inelig = "# ineligible"
				total_elig = "# eligible"	
		;
	run;
	data screener_data_totals_last;
		set screener_data_totals;
			by site;
				if last.site then output;
				keep site total_screened total_partial total_complete total_inelig total_elig ;
	run;

	ods path reset;
	ods pdf file = "H:\AEPI537D\Screener_Report_&db..pdf" style = journal  ;
	options orientation=portrait ;
		title "Screener Report";
		proc print data = screener_data_totals_last noobs label; run;
	ods pdf close;
