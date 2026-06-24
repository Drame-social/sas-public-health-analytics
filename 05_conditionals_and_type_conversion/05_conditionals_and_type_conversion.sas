/* SAS Module 5 */


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

/* Notes Section 5.1 */ 

data ex5_1_a;
	set phdata.atlgrades;
	if grade >= 60 then course = "Pass";
run;

data ex5_1_b;
	set phdata.atlgrades;
	if grade >= 60 then course = "Pass";
		else course = "Fail";
run;

data ex5_1_c;
	set phdata.atlgrades;
		if grade >= 90 then ltrgrade = "A";
		if grade >= 80 then ltrgrade = "B";
		if grade >= 70 then ltrgrade = "C";
		if grade >= 60 then ltrgrade = "D";
		if grade >= 0 then ltrgrade = "F";
run;

data ex5_1_d;
	set phdata.atlgrades;
		if grade >= 90 then ltrgrade = "A";
		if grade >= 80 & grade < 90 then ltrgrade = "B";
		if grade >= 70 & grade < 80 then ltrgrade = "C";
		if grade >= 60 & grade < 70 then ltrgrade = "D";
		if grade >= 0 & grade < 60 then ltrgrade = "F";
run; 

data ex5_1_e;
	set phdata.atlgrades;
		if grade >= 90 then ltrgrade = "A";
			else if grade >= 80 then ltrgrade = "B";
			else if  grade >= 70 then ltrgrade = "C";
			else if grade >= 60 then ltrgrade = "D";
			else ltrgrade = "F";
run; 

/* Notes Section 5.2 */ 

data ex5_2_a;
   	orig_var = '50000';
   	new_var = input(orig_var,8.);
run;

data ex5_2_a;

      orig_var = '50000';
      new_var = input(orig_var,8.);

     drop orig_var; 
     rename new_var = orig_var; 

run;

data ex5_2_b;
   		orig_var = "15%";
   		new_var = input(orig_var, percent8.);
run;

data ex5_2_b;
   		orig_var = "15%";
   		new_var = input(orig_var, percent8.);
   		format new_var percent8.;
run;

data ex5_2_c;
   	orig_var = "43,000.24";
   	new_var = input(orig_var, comma9.2);
   	format new_var comma9.2;
run;

data ex5_2_d;
   	orig_var = '01-11-2019';
   	new_var = input(orig_var,mmddyy10.);
   	format new_var date9.;
run;

data ex5_3_a;
   	orig_var = 537;
   	new_var = put(orig_var,8.);
run;

/* Notes Section 5.3 */  

data ex5_3_a;

   		orig_var = 537;
  		new_var = put(orig_var,8.);

   		drop orig_var;
   		rename new_var = orig_var;

run;

data ex5_3_b;
   input orig_var 8.;
   new_var = put(orig_var, 12.);
   datalines;
123
8345521
.
99
;
run;

data ex5_3_b;
   input orig_var 8.;
   new_var = put(orig_var, 12. -L);
   datalines;
123
8345521
.
99
;
run;

/* MOD 5 #1 */
data ATL1;
	format graderev $20.;    /*adding this so it doesn't truncate values in my new text field*/
	set phdata.atlgrades;
			if grade >= 85 then graderev = "Excellent";
				else if grade >= 70 then graderev = "Good";
				else if  grade >= 60 then graderev = "Okay";
				else graderev = "Not so good";
run; 

/* MOD 5 #2 */
data ATL2;
	set ATL1;
		AttendXNum = input(AttendX,8.);
run;

/* MOD 5 #3 */
data ATL3;
	set ATL2;
		GradeChar = put(grade,2.);
run;
	
/* MOD 5 #4 */	
data ATL4;
	set ATL3;
		if (GROUP = "Blue" or GROUP = "Red") and AttendXNum = 0 then ColorAtd = "BR0";
			else if (GROUP = "Blue" or GROUP = "Red") and AttendXNum = 1 then ColorAtd = "BR1";
			else if (GROUP = "Orange" or GROUP = "Yellow") and AttendXNum = 0 then ColorAtd = "OY0";
			else if (GROUP = "Orange" or GROUP = "Yellow") and AttendXNum = 1 then ColorAtd = "OY1";  /*could also do with just ELSE*/
run;
