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

*#1. No. Patients Identified for Screening;
%let num=%sysfunc(attrn(%sysfunc(open(Enrollment)),nlobs));
%put &num;

*Calculate number of patients screened, randomized, and treated so far;
Proc Freq Data = Enrollment;
	Table Screen Randomize Treatment;
Run;

*Create descriptives of gender by treatment group;
Proc Freq Data = Enrollment;
	Table Sex*Treatment;
Run;

*Summarize age by treatment group;
Proc Means Data = Enrollment;
	Var Age;
	Class Treatment;
Run;

*#9. Print list of patients pending screening;
Proc print Data = Enrollment noobs; Where Screen = 0; Var ID; Run;
