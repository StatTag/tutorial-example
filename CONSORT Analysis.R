#Enter Enrollment Data
ID <- c(1001,1002,1003,1004,1005,1006,1007,1008,1009,1010) 
Sex <- c("Male","Female","Male","Male","Female","Male","Female","Female","Female","Male") 
Age <- c(55,45,64,56,43,63,59,62,51,49) 
Screen <- c(1,1,1,1,1,1,1,1,1,0)
Randomize <-c(1,0,1,1,1,0,1,1,1,NA)
Treatment <- c(0,NA,0,1,1,NA,1,0,0,NA)

Enrollment <- data.frame(ID,Sex,Age,Screen,Randomize,Treatment) 

#Enrollment <- subset(Enrollment, Enrollment$ID != 1007)
#Enrollment <- subset(Enrollment, Enrollment$ID != 1003)

#1. No. Patients Identified for Screening
nrow(Enrollment)

#2. No. Patients screened
sum(na.omit(Enrollment$Screen) == 1)

#3. No. Patients Pending screening
sum(na.omit(Enrollment$Screen) == 0)

#4. No. Patients Randomized
sum(na.omit(Enrollment$Randomize) == 1)

#5. No. Patients Pending Randomization
sum(na.omit(Enrollment$Randomize) == 0)

#6. No. Patients in Treatment Group
sum(na.omit(Enrollment$Treatment) == 1)

#7. No. Patients in Control Group
sum(na.omit(Enrollment$Treatment) == 0)

#Create descriptives table of age and gender by treatment group
library(tableone)
TableOne <- CreateTableOne(data = Enrollment, vars=c("Sex","Age"), strata= "Treatment")
Table1 <- print(TableOne, quote = FALSE, noSpaces = TRUE, printToggle = FALSE, test=FALSE,explain=FALSE,showAllLevels = TRUE)
#8. Output Table 1
write.csv(Table1, file = "Table1.csv")

#9. Print list of patients pending screening
print(Enrollment[Enrollment$Screen == 0,1])