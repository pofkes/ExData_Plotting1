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
#code for creating plot 1
#font size in global parameters set to 0.9 to make the axis icons fit completely - may not be the same font size as in the assignment
par("cex" = 0.9, "bg" = "transparent")
hist(mydata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
dev.copy(png, "./power/plot1.png", width = 480, height = 480)
dev.off()
