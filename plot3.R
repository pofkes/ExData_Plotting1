#Code for reading and formatting the data
require(dplyr)
require(lubridate)
require(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "data.zip")
unzip("data.zip", exdir = "./power")
#use the fast fread command from the data table package
mydata<- fread(list.files("./power", full.names = TRUE), na.strings = "?")
mydata<-as.data.frame(mydata)
#reformat Date column to contain full date and time in posix format using lubridate package
mydata<-mutate(mydata, Date = dmy_hms(paste(Date, Time)))
mydata<-select(mydata, -Time)
#Subset data to include only times for the two days, as in assignment
mydata<-filter(mydata, as.Date(Date)>=ymd("2007/02/01"),as.Date(Date)<=ymd("2007/02/02") )
mydata<-rename(mydata, datetime = Date)

#Code for plot 3
par( "bg" = "transparent")
plot(mydata$datetime,mydata$Sub_metering_1, type = "n",ylab = "Energy sub metering", xlab = "")
points(mydata$datetime, mydata$Sub_metering_1, type = "l", col = "black")
points(mydata$datetime, mydata$Sub_metering_2, type = "l", col = "red")
points(mydata$datetime, mydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1) ,legend = names(mydata)[6:8] , col = c("black", "red", "blue"))
dev.copy(png, "./power/plot3.png", width = 480, height = 480)
dev.off()