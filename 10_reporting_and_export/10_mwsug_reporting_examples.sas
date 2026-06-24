/* SAS Code for https://www.mwsug.org/proceedings/2010/tutorials/MWSUG-2010-109.pdf */



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

/* Trick 1 */

proc report data = sashelp.class nowindows; 
	columns name sex age height weight;
	define name    /display   'Name'          width=10;
	define sex     /display   'Gender'        width=6;
	define age     /display   'Age'           width=4;
	define height  /analysis  'Height'        format=8.1;
	define weight  /analysis  'Weight'        format=8.1;
run;

/* Trick 2 */

proc report data = sashelp.class nowindows headline headskip; 
	columns name sex age height weight ratio;
	define name    /display   'Name'         width=10;
	define sex     /display   'Gender'       width=6;
	define age     /display   'Age'          width=4;
	define height  /analysis  mean 'Height'     format=8.1;
	define weight  /analysis  mean 'Weight'     format=8.1;
	define ratio   /computed  format=6.2;
	compute ratio;
		ratio = height.mean / weight.mean;
	endcompute;
	rbreak after / summarize dol dul;
run;

/* Trick 3 */

proc report data = sashelp.class nowindows headline headskip; 
	columns sex name age height weight ratio;
	define sex     /group     'Gender'       width=10;
	define name    /display   'Name'         width=6;
	define age     /analysis mean   'Age'    width=4;
	define height  /analysis  mean  'Height'   format=8.1;
	define weight  /analysis  mean  'Weight'   format=8.1;
	define ratio   /computed format=6.2;
	compute ratio;
		ratio = height.mean / weight.mean;
	endcompute;
	break after sex / skip summarize dol dul;
run;

/* Trick 4 */

title 'Calculating Percentages with Proc Report' ;
proc report data = sashelp.class nowindows headline headskip; 
	columns sex name height weight weight_pct;
	define sex     /group      'Gender'       width=10;
	define name    /display    'Name'         width=6;
	define height  /analysis  mean  'Height'  format=8.1;
	define weight  /analysis        'Weight'  format=8.1;
	define weight_pct   / '% of Weight' format=percent8.2;
	*----Calculations for each row ----;
	compute weight_pct;
		weight_pct = weight.sum / weight_sum;
	endcompute;
	*----------------------------------;
	compute before sex;
		weight_sum = weight.sum;
	endcompute;
	break after sex / skip summarize dol dul;
run;

/* Trick 5 */

proc report data = sashelp.class nowindows headline headskip; 
	columns sex name height weight weight_pct;
	define sex     /group   'Gender'         width=10;
	define name    /display  'Name'          width=6;
	define height  /analysis  mean 'Height'  format=8.1;
	define weight  /analysis  noprint        format=8.1;
	define weight_pct  / '% of Weight'      format=percent8.2;
	*----Calculations for each row ----;
	compute weight_pct;
		weight_pct = weight.sum / weight_sum;
	endcompute;
	*----------------------------------;
	compute before sex;
		weight_sum = weight.sum;
	endcompute;
	break after sex / skip summarize dol dul;
run;

/* Trick 6 */

proc report data = sashelp.class nowindows headline headskip; 
	columns sex name height weight weight=weight2 weight_pct;
	define sex         /group     'Gender'       width=10;
	define name        /display   'Name'         width=6;
	define height      /analysis  mean 'Height'  format=8.1;
	define weight      /analysis  noprint        format=8.1;
	define weight2     /analysis  mean           format=8.1;
	define weight_pct  / '% of Weight'           format=percent8.2;
	*----Calculations for each row ----;
	compute weight_pct;
		weight_pct = weight.sum / weight_sum;
	endcompute;
	*----------------------------------;
	compute before sex;
		weight_sum = weight.sum;
	endcompute;
	break after sex / skip summarize dol dul;
run;

/* Trick 7 */

data prep;
	length NAME $ 16;
	set sashelp.class;
	gender = sex ;
run;

proc report data = prep nowindows headline headskip; 
	columns sex gender name weight weight=weight_mn weight=weight_md;
	define sex     /group   'Gender'  width=6;
	define gender  /group   noprint ;
	define name    /group   'Name'          width=16;
	define weight  /analysis        format=8.2;
	define weight_md  /median noprint;
	define weight_mn  /mean noprint;
	*----------------------------------;
	compute after sex;
		name='Median Weight';
		weight.sum = weight_md;
	endcompute;
	*----------------------------------;
	compute after gender;
		name='Average Weight';
		weight.sum = weight_mn;
	endcompute;
	*----------------------------------;
	break after sex / skip summarize dol ol;
	break after gender /  summarize dol;
run;

/* Trick 8 */

data prep2;
	length name $ 15;
	set sashelp.class;
	f=1;
	m=1;
	goal=99;
run;

proc report data = prep2 nowindows ; 
	columns m f goal sex name weight weight=f_weight weight=m_weight;
	define name    /display  width=12;
	define sex    /display  width=12;
	define m    /group noprint ;
	define f    /group noprint ;
	define goal    /group noprint ;
	define weight / analysis mean format=6.1;
	define f_weight / sum noprint;
	define m_weight / sum noprint;
	*----------------------------------;
	compute weight;
		if sex="M" then do; wholdm+weight.mean; mw+1; end;
		if sex="F" then do; wholdf+weight.mean; wf+1; end;
	endcomp;
	*----------------------------------;
	break after f / summarize dul;
		compute after f;	
			name='Female Avg';
			weight.mean = wholdf/wf;
		endcompute;
	break after m / summarize dul;
		compute after m;	
			name='Male Avg';
			weight.mean = wholdm/mw;
		endcompute;
	break after goal / summarize dol dul;
		compute after goal;	
			name='Goal';
			weight.mean = goal;
		endcompute;
	rbreak after / summarize dul;
		compute after ;
			name='Overall Avg';
			weight=weight.mean;
		endcompute;
	
run;

/* Trick 9 */

ods listing close;
ods rtf file = 'H:\AEPI537D\sugi30.rtf';

proc report data = prep2 nowindows ; /*this proc report is pasted from trick 8*/
	columns m f goal sex name weight weight=f_weight weight=m_weight;
	define name    /display  width=12;
	define sex    /display  width=12;
	define m    /group noprint ;
	define f    /group noprint ;
	define goal    /group noprint ;
	define weight / analysis mean format=6.1;
	define f_weight / sum noprint;
	define m_weight / sum noprint;
	*----------------------------------;
	compute weight;
		if sex="M" then do; wholdm+weight.mean; mw+1; end;
		if sex="F" then do; wholdf+weight.mean; wf+1; end;
	endcomp;
	*----------------------------------;
	break after f / summarize dul;
		compute after f;	
			name='Female Avg';
			weight.mean = wholdf/wf;
		endcompute;
	break after m / summarize dul;
		compute after m;	
			name='Male Avg';
			weight.mean = wholdm/mw;
		endcompute;
	break after goal / summarize dol dul;
		compute after goal;	
			name='Goal';
			weight.mean = goal;
		endcompute;
	rbreak after / summarize dul;
		compute after ;
			name='Overall Avg';
			weight=weight.mean;
		endcompute;
	
run;

ods rtf close;

/* Trick 10 */

ods rtf file = 'H:\AEPI537D\sugi30.rtf';

proc report data = prep2(where=(age lt 15)) nowindows        /*this proc report is pasted from trick 8*/
	style(column) = {font_face='Arial'}
	style(summary) = {font=('Arial,Helvetica, Helv') font_size=12.25pt}
	style(header) = {font_face='Arial' font_size=13.70pt};
 
	columns m f goal sex name weight weight=f_weight weight=m_weight;
	define name    /display  width=12;
	define sex    /display  width=12;
	define m    /group noprint ;
	define f    /group noprint ;
	define goal    /group noprint ;
	define weight / analysis mean format=6.1;
	define f_weight / sum noprint;
	define m_weight / sum noprint;
	*----------------------------------;
	compute weight;
		if sex="M" then do; wholdm+weight.mean; mw+1; end;
		if sex="F" then do; wholdf+weight.mean; wf+1; end;
	endcomp;
	*----------------------------------;
	break after f / summarize style=[font_weight=bold font_size=12.50pt
							   background=cyan font_face='Arial'];
		compute after f;	
			name='Female Avg';
			weight.mean = wholdf/wf;
		endcompute;
	break after m / summarize style=[font_weight=bold font_size=12.50pt
							   background=light green font_face='Arial'];
		compute after m;	
			name='Male Avg';
			weight.mean = wholdm/mw;
		endcompute;
	break after goal / summarize style=[font_weight=bold font_size=12.50pt
							   background=pink font_face='Arial'];
		compute after goal;	
			name='Goal';
			weight.mean = goal;
		endcompute;
	rbreak after / summarize style=[font_weight=bold font_size=13.50pt
							   background=yellow font_face='Arial'];
		compute after ;
			name='Overall Avg';
			weight=weight.mean;
		endcompute;
	
run;

ods rtf close;
