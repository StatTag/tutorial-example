import pandas as pd
enrollment = pd.DataFrame([
    [1001,"Male",55,1,1,0],
    [1002,"Female",45,1,0,None],
    [1003,"Male",64,1,1,0],
    [1004,"Male",56,1,1,1],
    [1005,"Female",43,1,1,1],
    [1006,"Male",63,1,0,None],
    [1007,"Female",59,1,1,1],
    [1008,"Female",62,1,1,0],
    [1009,"Female",51,1,1,0],
    [1010,"Male",49,0,None,None]
], columns = ["ID", "Sex", "Age", "Screen", "Randomize", "Treatment"])

enrollment = enrollment[enrollment.ID != 1007]
enrollment = enrollment[enrollment.ID != 1003]

#1. No. Patients Identified for Screening
len(enrollment)

#2. No. Patients screened
enrollment[enrollment.Screen == 1].count()["ID"]

#3. No. Patients Pending screening
enrollment[enrollment.Screen == 0].count()["ID"]

#4. No. Patients Randomized
enrollment[enrollment.Randomize == 1].count()["ID"]

#5. No. Patients Pending Randomization
enrollment[enrollment.Randomize == 0].count()["ID"]

#6. No. Patients in Treatment Group
enrollment[enrollment.Treatment == 1].count()["ID"]

#7. No. Patients in Control Group
enrollment[enrollment.Treatment == 0].count()["ID"]

# Create descriptives table of age and gender by treatment group
from tableone import TableOne
table1 = TableOne(enrollment, ["Sex", "Age"], None, "Treatment", None)

#8. Output Table 1
table1

#9. Print list of patients pending screening
list(enrollment[enrollment.Screen == 0]["ID"])
