


library("ggplot2")
theme_set(theme_bw())
library(gganimate)
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("sf")



library(tidyverse)
library(janitor)
library(plotrix)
library("ggmap")
library(maptools)
library(maps)





#read the dataset from excel sheet
incubation_data<-read.csv("incubation_data.csv",header = TRUE)



detach(data)

summary(incubation_data)






attach(incubation_data)

#composition of the sample by Gender

x <-table(incubation_data$gender)
table(incubation_data$gender)
lbl <-  c("Female","Male")
piepercent<- round(100*x/sum(x), 1)

# Give the chart file a name.
png(file = "Gender Composition.jpg")

# Plot the chart.
pie3D(x,labels =piepercent,explode = 0.1, main = "Pie Chart of Gender ")
legend("topright",lbl, cex = 0.8,
       fill = rainbow(length(x)))


dev.off()





#plot the location of COVID19 patients using longtitude and lattitude


location1<-data.frame(incubation_data$country)

summary(location1)

visit.x <- incubation_data$lattitude
visit.y <- incubation_data$longtitude
map("world", fill=TRUE, col="green", bg="blue", ylim=c(-60, 90), mar=c(0,0,0,0))
points(visit.x,visit.y, col="red", pch=16)
dev.off()

#composition of ths sample by Age

Age<-cut(age, breaks=c(0,20, 30, 40, 50,60,70,80,90,100), right = FALSE)
Number_Of_COVID19_patients<-table(Age)
barplot(Number_Of_COVID19_patients,xlab="Age",ylab="frequency",col="purple",ylim=c(0,150),
        main="Number Of COVID19 patients according to Age categories",border="red")


#time series of infected people
timeseries <-  ts(reporting_date,start=c(2020-01-17),end=c(2020-02-28,frequency = 24))
freq=table(reporting_date)
plot(freq,type="o",col="blue",ylim=c(0,50),main="Time Series of COVID19 patients in the Sample")

#plot the incubation period for each index

summary(incubation_period)
plot(incubation_period,col="red",pch=16)

