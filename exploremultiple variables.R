

library(tidyverse)
library(janitor)
library(magrittr) 
library(arules)
library(arulesViz)
library(diplyr)



df<-read.csv("incubation_data.csv",header =TRUE)
attach(df)

#Association between the age and gender in the sample
library(ggplot2)
boxplot(age~gender,col=c("yellow","purple"),data=df,main="boxplot of Age by Gender",ylim=c(1,100))

newdata_male <- subset(df, gender=="male")
newdata_female<-subset(df,gender=="female")

summary(newdata_male$age)
summary(newdata_female$age)

#Association between the ageand country in the sample
library(ggplot2)
boxplot(df$age~df$country,col=c("yellow","purple","lightblue","pink","orang"," brown"),data=df,main="boxplot of Incubation period by Age")


japan<-subset(df,country=="Japan")
China<-subset(df,country=="China")
HongKong<-subset(df,country="Hong Kong")
Thaiwan<-subset(df,country="Thaiwan")
SouthKorea<-subset(df,country="South Korea")


#box plot of age according to the gender

summary(newdata_male$incubation_period)
summary(newdata_female$incubation_period)


#scatter plot of age and incubation period
with(df, plot(age,incubation_period, col=gender, pch=as.numeric(gender)))



#Association between the incubation period with age by gender

qplot(incubation_period,age,color=factor(gender),geom=c("point","smooth"),size=incubation_period,shape=factor(gender))


#density plot of incubation period by gender
qplot(incubation_period,data=df,geom="density",color=gender,linetype=gender,main="density of incubation period")

#density plot of incubation period by country
qplot(incubation_period,data=df,geom="density",color=country,linetype=country,main="density of incubation period by country")



#density plot of incubation period by age
Age<-cut(age, breaks=c(0,20, 30, 40, 50,60,70,80,90,100), right = FALSE)
qplot(incubation_period,data=df,geom="density",color=Age,main="density of incubation period by Age")


#matrix of scatter plots
pairs(df)


#3d scatterplot for age,gender,incubation period
library(scatterplot3d)
scatterplot3d(gender,age,incubation_period,pch=16,color="green")

#parellel plots
library(lattice)
 datak<-data.frame(country,reporting_date,age,gender,incubation_period)

parallelplot(~datak[2:5] | country, data=datak)







