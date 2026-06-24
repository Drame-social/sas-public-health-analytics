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

* SAS Module 10 Solution;

* Notes Section 10.1 ;

PROC EXPORT DATA= sashelp.class
    OUTFILE= 'H:\AEPI537D\class.xlsx'
    DBMS=EXCEL REPLACE;
    SHEET="class";
RUN; 

proc export data=sashelp.class(where=(sex='M'))
             outfile="H:\AEPI537D\classmulti.xlsx"
             dbms=excel replace label;
   			sheet="Male";
run;

proc export data=sashelp.class(where=(sex='F'))
             outfile="H:\AEPI537D\classmulti.xlsx"
             dbms=excel replace label;
   			sheet="Female";
run;

PROC FORMAT;
	VALUE YNF
		0='NO'
		1='YES';
	VALUE TYPE
		1='Rarely'
		2='Sometimes'
		3='Always';
	VALUE GROUP
		1='Group A'
		2='Group B'
		3='Group C';
RUN;

data tagsetex_fmt;
	set phdata.tagsetex;
		format var1 ynf. var2 type. var3 group.;
run;

PROC EXPORT DATA= tagsetex_fmt
    OUTFILE= 'H:\AEPI537D\tagsetex_fmt.xlsx'
    DBMS=EXCEL REPLACE;
    SHEET="tagsetex_fmt";
RUN;

ods Tagsets.ExcelXP file='H:\AEPI537D\tagsetex_fmt.xml';

	proc print data=tagsetex_fmt noobs; run; 

ods Tagsets.ExcelXP close;

* Notes Section 10.2 ;

* SAS code for PROC REPORT article is in separate SAS program file ;

* Notes Section 10.2 (Tips) ;

proc contents data= sashelp.class out=check_contents noprint; run;	
data check_contents2; set check_contents; keep varnum name label; run;
proc sort data= check_contents2; by varnum; run;
proc print data= check_contents2 noobs; var name label; run;


/* Mod 10 #1 */

proc export data=sashelp.iris(where=(species='Setosa'))
             outfile="H:\AEPI537D\irismulti.xlsx"
             dbms=excel replace label;
   			sheet="Setosa";
run;
proc export data=sashelp.iris(where=(species='Versicolor'))
             outfile="H:\AEPI537D\irismulti.xlsx"
             dbms=excel replace label;
   			sheet="Versicolor";
run;
proc export data=sashelp.iris(where=(species='Virginica'))
             outfile="H:\AEPI537D\irismulti.xlsx"
             dbms=excel replace label;
   			sheet="Virginica";
run;

/* Mod 10 #2 */

proc report data = sashelp.iris nowindows; 
	columns species petalwidth;
	define species    /group   'Iris Species'          width=20;
	define petalwidth  /analysis mean 'Petal Width'        format=8.1;
run;



