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

* SAS Module 8 Solution;

* Array Example 1 ;

data METHOD1;
	set phdata.mod8_A;
		if var1=9 then var1=.;
		if var2=9 then var2=.;
		if var3=9 then var3=.;
		if var4=9 then var4=.;
		if var5=9 then var5=.;
		if var6=9 then var6=.;
		if var7=9 then var7=.;
		if var8=9 then var8=.;
		if var9=9 then var9=.;
		if var10=9 then var10=.;
		if var11=9 then var11=.;
		if var12=9 then var12=.;
		if var13=9 then var13=.;
		if var14=9 then var14=.;
		if var15=9 then var15=.;
run;

data METHOD2;
	set phdata.mod8_A;
	array blanks {15} var1 var2 var3 var4 var5 var6 var7 var8 var9 var10 var11      
      var12 var13 var14 var15;
	do i = 1 to 15;
		if blanks {i} = 9 then blanks {i} = . ;
	end;
run;

* Array Example 2 ;

DATA TEMP1;
	SET phdata.mod8_B;
		SCORE = TEST1 + TEST2 + TEST3;
RUN;

PROC FREQ DATA = TEMP1;
	TABLES SCORE;
RUN;

DATA TEMP2;
	SET TEMP1;
		SCORE2 = 0; *This is a second version of SCORE that we will calculate using an array;

		ARRAY SCARRAY {3} TEST1 TEST2 TEST3;

		DO i = 1 TO 3;
			IF SCARRAY {i} = 1 THEN SCORE2 = SCORE2 + 1;
			IF SCARRAY {i} = 0 THEN SCORE2 = SCORE2 + 0;
			IF SCARRAY {i}= . THEN SCORE2 = .;  
		END;
RUN;

PROC FREQ DATA = TEMP2;
	TABLES SCORE*SCORE2;
RUN;

* Array Example 3 ;

DATA TEMP1;
SET phdata.mod8_C;

	LOC = 0;

	ARRAY HISTCLOT{10}  LOCATN1 LOCATN2 LOCATN3 LOCATN4 LOCATN5 LOCATN6 LOCATN7       
                          LOCATN8 LOCATN9 LOCATN10;

	DO i = 1 TO 10;
		IF HISTCLOT{i} IN (1,2,6,7) THEN LOC = 1;
	END;

	IF RELTCLOT = 1 AND LOC = 1 THEN FAMHIS = 1;
		ELSE FAMHIS = 0;

RUN;

PROC FREQ DATA = TEMP1;
		TABLES RELTCLOT*LOC*FAMHIS / LIST;
RUN;

* Array Example 4 ;

DATA TEMP3;
	SET phdata.mod8_D;

	DRUGS = 0;

	ARRAY DRGARRAY {21} DRUG1A DRUG1B DRUG1C DRUG2A DRUG2B DRUG2C 
                        DRUG3A DRUG3B DRUG3C DRUG4A DRUG4B DRUG4C 
  						DRUG5A DRUG5B DRUG5C DRUG6A DRUG6B DRUG6C    
				  		DRUG7A DRUG7B DRUG7C;

	DO j=1 TO 21;

		IF DRGARRAY {j} = 1 OR DRGARRAY {j} = 2 THEN DRUGS = DRUGS + 1;
		IF DRGARRAY {j} >=3 THEN DRUGS = DRUGS + 0;

	END;

RUN;

PROC FREQ DATA=TEMP3;
	TABLES DRUGS;
RUN;

PROC PRINT DATA=TEMP3;
VAR DRUG1A DRUG1B DRUG1C DRUG2A DRUG2B DRUG2C DRUG3A DRUG3B DRUG3C DRUG4A     
	DRUG4B DRUG4C DRUG5A DRUG5B DRUG5C DRUG6A DRUG6B DRUG6C DRUG7A DRUG7B DRUG7C DRUGS;
WHERE ID = 4; 
RUN;

* Bonus Example on Addition and Missing Values ;

data addition;
input studyid var1 var2 var3;
datalines;
1001 1 1 1
1002 1 0 1
1003 1 1 1
1004 0 0 0
1005 . 1 1
1006 1 0 1
1007 0 0 .
1008 1 . 0
1009 . . 1
1010 1 0 1
;
run;

data addition_rev;
	set addition;

	/*method 1*/ sum_w_plus = var1 + var2 + var3;

	/*method 2*/ sum_w_sum = sum(var1 , var2 , var3);

run;

* Mod 8 # 1;
DATA NEW;
SET ORIG;
ARRAY BLANKS {4} VAR1 VAR2 VAR3 VAR4 VAR5 VAR6;
DO i = 1 to 6;
IF BLANKS {i} = 9 THEN BLANKS {i} = . ;
END;
RUN;
/* Mistake: 4 variables listed in the array statement but 6 actual variables included and 6 in the DO loop. To correct, change {4} to {6}. */

* Mod 8 # 2;
data temp1;
set lab6.pets;

petnum=0;

array total {4} dog cat bird fish;
do i=1 to 4;
if total{i}=1 then petnum=petnum+1;
if total{i}=0 then petnum=petnum+0;
if total{i}=8 or total{i}=9 then petnum=.;
end;
run;
proc freq data=temp1;
tables petnum;
run;

* Mod 8 # 3;
proc print data=temp1;
var id other_spec1 other_spec2 other_spec3 other_spec4;
where other=1;
run;

* Mod 8 # 4;
data temp2;
set temp1;

othrpets=0;

array opets {4} other_spec1 other_spec2 other_spec3 other_spec4;

do i=1 to 4;
if opets {i}=' ' then othrpets=othrpets+0;
else othrpets=othrpets+1;
end;
run;

/*or could use instead:*/

/*
do i=1 to 6;
if opets {i} ne ' ' then othrpets=othrpets+1;
end;
run;
*/

proc freq data=temp2;
tables othrpets;
run;

* Mod 8 # 5;
data temp3;
set temp2;
allpets = petnum + othrpets;
run;
proc print data = temp3;
var allpets petnum othrpets;
run;
