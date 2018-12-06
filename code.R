library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/DRA-Reach-Initiative-Ukraine-microdata")
data <- read_excel("C:/Users/LENOVO T46OS/Desktop/DRA-Reach-Initiative-Ukraine-microdata/data1.xlsx")

#Somalia Joint Multi Cluster Needs Assessment Final Dataset - https://data.humdata.org/dataset/ukraine-humanitarian-trend-analysis-2018
selectedKeyVars <- c('region',	'district',	'settlement',	'settlement_other',	
                    'idp_settlement', 'idp_settlement_name',	'resp_gender',
                    'breadwinner',	'household_expenditure', 'males_0_6m',
                    'females_0_6m',	'males_6m_4y', 'females_6m_4y',
                    'males_5_12',	'females_5_12',	'males_13_15',	'females_13_15',
                    'males_16_17',	'females_16_17',	'males_18_40',	'females_18_40',
                    'males_41_59',	'females_41_59',	'males_60_over',
                    'females_60_over', 'total_hh',
                    'children_0_4',	'school_age_male',	'school_age_female',
                    'school_age_total',	'total_children','disabled_chronic',
                    'sick_children',	'mental', 'disabled_chronic_male',	
                    'disabled_chronic_female',	'sick_boys_under5',	'sick_girls_under5',	
                    'stress_boys',	'stress_girls',	'stress_men',	'stress_women',	
                    'region_idp',	'district_idp',	'settlement_idp',	
                    'settlement_idp_other',
                    'returnee_country',	'returnee_country_other',	'returnee_area',
                    'returnee_area_other',	'returnee_settlement',
                    'returnee_settlement_other',	'registered_return',	'refugee',
                    'country_origin', 'girls_harsh_work_type', 'boys_harsh_work_type',
                    'not_safe_men_boys_where', 'not_safe_women_girls_where',
                    'primary_source',	'secondary_source',	'tertiary_source',
                    'livelihood_coping', 'livelihood_used', 'health_issues_adult',
                    'language_spoken', 'Target.Site')

#Convert variables into factors
cols = c('resp_gender', 'breadwinner',	'household_expenditure',
         'region',	'district',	'settlement',	'settlement_other',	
        'idp_settlement',	'idp_settlement_name', 'region_idp',
        'district_idp',	'settlement_idp',	'settlement_idp_other',	'returnee_country'
)
data[,cols] <- lapply(data[,cols], factor)

# Convert the sub file into dataframe
fileRes<-data[,selectedKeyVars]
fileRes <- as.data.frame(fileRes)

#Assess the disclosure risk
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars)

#Disclosure risk assessment 
print(objSDC, "risk")

#Generating an internal (extensive) report
report(objSDC, filename = "index", internal = TRUE) 


