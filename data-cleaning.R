#Set working directory, the below example indicates my specific working directory
setwd("~/Documents/CPBP8000_project/CPBP8000_project")
#Install necessary packages that will simplify lines of code needed for data cleaning
pacman::p_load(tidyverse,
               devtools,
               janitor,dplyr)
#Read mental health and technology usage raw data csv and load into a data frame
raw_mhealthtech<-read.csv("mental_health_and_technology_usage_2024.csv")
View(raw_mhealthtech)
#Remove underscores and spaces from all column names, and make all column names lowercase
colchange_mhealthtech<-raw_mhealthtech%>%rename_with(~gsub("_","",.x)%>%tolower())
View(colchange_mhealthtech)
#Select the specific columns of the data set that have defined descriptions in Kaggle
defcol_mhealthtech<-colchange_mhealthtech%>%select(userid,age,gender,screentimehours,mentalhealthstatus,stresslevel,sleephours)
View(defcol_mhealthtech)
#Filter for ages 18-29,female and male gender,high or low stress level, excellent or poor mental health, and eliminate confounding variable of low sleep by filtering for at least 7 hours of sleep
filter_mhealthtech<-defcol_mhealthtech%>%filter(age<=29,gender!="Other",stresslevel=="Low"|stresslevel=="High",mentalhealthstatus=="Excellent"|mentalhealthstatus=="Poor",sleephours>=7)
View(filter_mhealthtech)
#Select the specific columns of interest for the final data frame
mhealthtech<-filter_mhealthtech%>%select(age,gender,screentimehours,mentalhealthstatus,stresslevel)
View(mhealthtech)