/* SAS Module 7 */


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

/* 7.1 - COMPRESS */

data phone; 
	input Phone $15.; 
	   Phone1 = compress(Phone); 
	   Phone2 = compress(Phone,'(-) '); 
	   Phone3 = compress(Phone,,'kd'); 
datalines; 
(708)245-3350
(202) 555-76 99
555-555-1212
;
run;

/* 7.2 - SUBSTR */

data letters_numbers; 
	input id $9.; 
    	length State $ 2; 
    	    State = substr(id,3,2); 
   	    	Num = input(substr(id,5),4.); 
datalines; 
XYNY123 
XYNJ1234 
;
run;

/* 7.3 - UPCASE, LOWCASE, PROPCASE */

data names_cases; 
   input Name $15.; 
   		Upper = upcase(Name); 
   		Lower = lowcase(Name); 
   		Proper = propcase(Name," '"); 
datalines; 
jOHn DOE 
D'Angelo 
; 
run;

/* 7.4 - SCAN */

data presidents; 
   length Last_Name $ 15; 
   input @1  Name  $20.; 
   		Last_Name = scan(Name,-1,' '); 
datalines; 
Donald Trump        
Barack Obama        
George W. Bush 
Bill Clinton    
George H. W. Bush
Ronald Reagan
Jimmy Carter
Gerald Ford
Richard Nixon
Lyndon B. Johnson 
; 
run;

data veggies; 
    input veg_list $30.; 
datalines; 
beet,carrot,broccoli
beet,celery
beet,pepper,tomato
; 
run;

data veggies2;
	set veggies;
		Veg1= SCAN(veg_list,1,',');
		Veg2= SCAN(veg_list,2,',');
		Veg3= SCAN(veg_list,3,',');
run;

/* 7.5 - FIND, SUBSTR, LOWCASE */

data svu_emails;
	input email $50.; 
datalines; 
olivia.benson@gmail.com
ice-t@yahoo.com
elliot.stabler@gmail.com
donaldcragen@aol.com
doctor_huang@hotmail.com
docwarner@gmail.com
jmunch911@aol.com
amanda.rollins@comcast.net
; 
run;

data svu_emails2;
	set svu_emails;
		email_domain1=find(email, "@");  
		email_truncate=substr(email, email_domain1+1);  
		email_domain2=find(email_truncate, ".");  
		email_domain_name=lowcase(substr(email_truncate, 1, email_domain2-1));  
	drop email_domain1 email_domain2 email_truncate;
run;

/* 7.6 - TRANWRD */

data add_convert; 
   input @1 address $20. ; 
	   Address = tranwrd(Address,'Street','St.'); 
	   Address = tranwrd(Address,'Avenue','Ave.'); 
	   Address = tranwrd(Address,'Road','Rd.'); 
datalines; 
89 Lazy Brook Road  
123 River Rd. 
9731 South Avenue
12 Main Street 
; 
run;

/* 7.7 - MDY, MONTH, WEEKDAY, DAY, YEAR, YRDIF */

data date_functs; 
   input (Date1 Date2)(:mmddyy10.) M D Y; 
	   SAS_Date = MDY(M,D,Y); 
	   WeekDay = weekday(Date1); 
	   MonthDay = day(Date1); 
	   Year = year(Date1); 
	   Age = yrdif(Date1,Date2); 
   format Date: mmddyy10.; 
datalines; 
10/21/1955 10/21/2012 6 15 2011 
;
run;

/* 7.8 - SMALLEST, LARGEST */

data small_large; 
   input x1-x5; 
	   S1 = smallest(1,of x1-x5); 
	   S2 = smallest(2,of x1-x5); 
	   L1 = largest(1,of x1-x5); 
	   L2 = largest(2,of x1-x5); 
datalines; 
7 2 . 6 4 
10 . 2 8 9 
; 
run;

/* 7.9 - TRIMN, STRIP */

data concat_string; 
   length Concat $ 8; 
   One = '   ABC   '; 
   Two = 'XYZ'; 
   One_two = ':' || One || Two || ':'; 
   Trim = ':' || trimn(One) || Two || ':'; 
   Strip = ':' || strip(One) || strip(Two) || ':'; 
   Concat = cats(':',One,Two,':'); 
   put one_two= / Trim= / Strip= / 
       Concat=; 
run;

/* 7.10 - CEIL, FLOOR, INT, ROUND */

data truncate;
	input x @@;
		ceil = ceil(x);
		floor = floor(x);
		int = int(x);
		round = round(x);
datalines;
7.2 7.8 -7.2 -7.8
;
run;

/* 7.11 - ZIPFIPS, ZIPNAME, ZIPNAMEL, ZIPSTATE */

data zips_states;
	input zip @@; 
		fips = zipfips(zip);
		state_caps = zipname(zip);
		state_mixed = zipnamel(zip);
		state_abbre = zipstate(zip);
	format zip z5.;
datalines; 
30322 33018 98101 02801 73301
; 
run;

/* 7.12 - COUNTC, CATS */

data Survey; 
   input (Q1-Q5)($1.); 
   	Num = countc(cats(of Q1-Q5),'y','i'); 
datalines; 
yynnY 
nnnnn 
; 
run;

/* 7.13 - ARRAY */

data convert; 
   input (A B C)($) x1-x3 y z; 

   
   array nums[*] _numeric_; 

   array chars[*] _character_; 

   do i = 1 to dim(nums); 
      if nums[i]=999 then nums[i]=.;  
   end; 

   do i = 1 to dim(chars); 
      chars[i] = propcase(chars[i]," '"); 
   end; 

   drop i; 
   

datalines; 
RON jOhN mary 1 2 999 3 999 
;   
run;

/* 7.14 � Bonus Example � REVERSE, INPUT, SUBSTR, STRIP */

PROC IMPORT OUT= WORK.bonus7 DATAFILE= "H:\AEPI537D\bonus7.xlsx" 
            DBMS=xlsx REPLACE;
     		SHEET="Sheet1"; 
     		GETNAMES=YES;
RUN;

data bonus7_a;
	set bonus7;
		newvar=substr(reverse(strip(Last_Visit)),1,10); 
run;

data bonus7_b;
	set bonus7_a;
		newvar2=left(reverse(newvar));
run;

data bonus7_c;
	set bonus7_b;
		newdate=input(newvar2,mmddyy10.);
run;

data bonus7_d;
	set bonus7_b;
		newdate=input(newvar2,mmddyy10.);
		format newdate monyy7.;
run;

/* MOD 7 */
data mock_data_rev;
set phdata.mock_data;

*MOD 7 #1; 
Address = tranwrd(Address,'Street','St.');

*MOD 7 #2; 
SUPLNM = scan(supervisor,-1,' ');

*MOD 7 #3; 
STATE = zipstate(zipcode);

*MOD 7 #4; 
THISYEAR = year(Date);

*MOD 7 #5; 
VALRND = round(value);

*MOD 7 #6; 
PHONEFIX = compress(phone_num,,'kd');

*MOD 7 #7; 
LRGNUM = largest(1,of score1-score5);

*MOD 7 #8; 
C1= SCAN(colors,1,',');
C2= SCAN(colors,2,',');
C3= SCAN(colors,3,',');

*MOD 7 #9; 
CODE_NEW = strip(code);

*MOD 7 #10; 
CODE_NEW2 = lowcase(CODE_NEW);

run;
