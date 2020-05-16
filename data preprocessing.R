library(tidyverse)
library(janitor)


#input the data from COVID19_line_list dataset
data<-read.csv("COVID19_line_list.csv",header = TRUE)

#mutate to do calculations with dates
data <- data %>% 
  mutate(tReport = as.integer((reporting.date %>% as.Date(format = "%m/%d/%Y")) - as.Date("2019-12-31")),
         tSymptomOnset = as.integer((symptom_onset %>% as.Date(format = "%m/%d/%Y")) - as.Date("2019-12-31")),
         tStartExposure = as.integer((exposure_start %>% as.Date(format = "%m/%d/%Y")) - as.Date("2019-12-31")),
         tEndExposure = as.integer((exposure_end %>% as.Date(format = "%m/%d/%Y")) - as.Date("2019-12-31"))) %>%
  
  
  # if no start of exposure then use 14 days to reduce the risk when estimating the quarantine period
  mutate(texposure = ifelse(is.na(exposure_start),tSymptomOnset-14,tStartExposure),
         
         
         symptom_onset=as.Date(tSymptomOnset,"2019-12-31"),
         
         expose_date=as.Date(texposure,"2019-12-31"),
         
         reporting_date=as.Date(tReport,"2019-12-31"),
         
         
         incubation_period = ifelse(texposure > tSymptomOnset,NA,tSymptomOnset- texposure))

attach(data)


patient_details<-data.frame(reporting_date,location,country,lattitude,longtitude,age,gender,expose_date,symptom_onset,symptom,incubation_period)

#remove the rows with null entries
incubation_data<-na.omit(patient_details)


write.csv(incubation_data,"incubation_data.csv")

