*Enter Enrollment Data;
input id Sex Age screen randomize treatment
1001 0 55 1 1 0
1002 1 45 1 0 .
1003 0 64 1 1 0
1004 0 56 1 1 1
1005 1 43 1 1 1
1006 0 63 1 0 .
1007 1 59 1 1 1
1008 1 62 1 1 0
1009 1 51 1 1 0
1010 0 49 0 . .
end

label define sexlab 0 "Male" 1 "Female"
label values Sex sexlab

label define txlab 0 "Control" 1 "Treatment"
label values treatment txlab

*drop if id == 1007
*drop if id == 1003

*#1. No. Patients Identified for Screening
count
di r(N)

*#2. No. Patients screened
count if screen == 1
di r(N)

*#3. No. Patients Pending screening
count if screen == 0
di r(N)

*#4. No. Patients Randomized
count if randomize == 1
di r(N)

*#5. No. Patients Pending Randomization
count if screen == 1 & randomize == 0
di r(N)

*#6. No. Patients in Treatment Group
count if treatment == 1
di r(N)

*#7. No. Patients in Control Group
count if treatment == 0
di r(N)

*Create descriptives table of age and gender by treatment group
*#8. Output Table 1
table1, by(treatment) vars(Sex cat \ Age contn) format(%9.1f) saving("table1.xlsx", replace)

*#9. Print list of patients pending screening
list if screen == 0
