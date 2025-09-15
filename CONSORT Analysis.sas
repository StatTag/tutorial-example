%let path = %qsubstr(%sysget(SAS_EXECFILEPATH),1,%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILEname)));

*Enter Enrollment Data;
data Enrollment;
   infile datalines delimiter=','; 
   input ID Sex $ Age Screen Randomize Treatment;
   datalines;                      
1001,Male,55,1,1,0
1002,Female,45,1,0,.
1003,Male,64,1,1,0
1004,Male,56,1,1,1
1005,Female,43,1,1,1
1006,Male,63,1,0,.
1007,Female,59,1,1,1
1008,Female,62,1,1,0
1009,Female,51,1,1,0
1010,Male,49,0,.,.
;

/*
Data Enrollment; Set Enrollment;
	*If id = 1007 then delete;
	*If id = 1003 then delete;
Run;
*/

*#1. No. Patients Identified for Screening;
%let num=%sysfunc(attrn(%sysfunc(open(Enrollment)),nlobs));
%put &num;

*Calculate number of patients screened, randomized, and treated so far;
Proc Freq Data = Enrollment;
	Table Screen Randomize Treatment;
	ods Output onewayfreqs = Frequencies;
Run;

Data Frequencies; set Frequencies;
	If Screen = 1 then call symput('Screened',put(frequency,3.0));
	If Screen = 0 then call symput('NotScreen',put(frequency,3.0));
	If Randomize = 1 then call symput('Randomized',put(frequency,3.0));
	If Randomize = 0 then call symput('NotRandomized',put(frequency,3.0));
	If Treatment = 1 then call symput('Treatment',put(frequency,3.0));
	If Treatment = 0 then call symput('Control',put(frequency,3.0));
Run;

*#2. No. Patients screened;
%put &Screened;
*#3. No. Patients Pending screening;
%put &NotScreen;
*#4. No. Patients Randomized;
%put &Randomized;
*#5. No. Patients Pending Randomization;
%put &NotRandomized;
*#6. No. Patients in Treatment Group;
%put &Treatment;
*#7. No. Patients in Control Group;
%put &Control;

*Create descriptives table of age and gender by treatment group;
Proc Freq Data = Enrollment;
	Table Sex*Treatment;
	Ods output CrossTabFreqs = Sex;
Run;

Data Sex (keep = Treatment Sex N_PCT); Set Sex;
	Where _TYPE_ = "11";
	Length N_PCT $12.;
	N_PCT = trim(left(put(frequency,3.0)))||" ("||trim(left(put(RowPercent,4.1)))||")";
Run;

Proc Transpose Data = Sex Out = Sex;
	Var N_PCT;
	By Sex;
	Id Treatment;
Run; 

Data Sex (Keep = Variable Control Treatment); Set Sex;	
	Variable = Sex;
	Control = _0;
	Treatment = _1;
Run;

Proc Means Data = Enrollment;
	Var Age;
	Class Treatment;
	Ods output Summary = Age;
Run;

Data Age (keep = Treatment Mean_SD); Set Age;
	Length mean_sd $12.;
	Mean_SD = trim(left(put(Age_Mean,4.1)))||" ("||trim(left(put(Age_StdDev,4.1)))||")";
Run;

Proc Transpose Data = Age Out = Age;
	Var Mean_SD;
	Id Treatment;
Run; 

Data Age (Keep = Variable Control Treatment); Set Age;	
	Variable = "Age";
	Control = _0;
	Treatment = _1;
Run;

Data TableOne; Set Sex Age; Run; 

*#8. Output Table 1;
ods csv file = "&path.Table1.csv";
Proc print Data = TableOne noobs; Run;
ods csv close;

*#9. Print list of patients pending screening;
Proc print Data = Enrollment noobs; Where Screen = 0; Var ID; Run;
