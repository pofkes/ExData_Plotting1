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

#Code for creating plot 2
par( "bg" = "transparent")
#In case the default language in the computer is not english, set it to english
Sys.setlocale("LC_ALL","English")
plot(mydata$datetime,mydata$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
#R plots the required time format for x axis by default, but to be sure, I specified the date time format
axis.POSIXct(1,mydata$datetime, format = "%a")
dev.copy(png, "./power/plot2.png", width = 480, height = 480)
dev.off()