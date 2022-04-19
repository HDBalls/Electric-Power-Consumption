#Global Active Power Plot3
#Add the household_power_consumption.txt file to your working directory

#Install the packages for data load
install.packages("sqldf")
library(sqldf)
library(lubridate)
library("data.table")

#Import the file to a dataset with the appropriate filters to limit the data
electricity_all <- read.csv.sql("household_power_consumption.txt" ,"select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

#Convert Date then Time to the correct representation
electricity_all$Date_Date <- as.Date(electricity_all$Date, format = "%d/%m/%Y")

#Join the date and Time into a separate column
DateTime <-paste(electricity_all$Date,electricity_all$Time)
electricity_all$DateTime <-strptime(DateTime, "%d/%m/%Y %H:%M:%S")

#Add the day column to the dataset
electricity_all$Day_Of_Week_Text <- lubridate::wday(electricity_all$Date_Date, label = TRUE, abbr = TRUE)

# Format the columns
electricity_subset <- electricity_all[electricity_all$Date %in% c("1/2/2007","2/2/2007"),]
GlobalActivePower <- as.numeric(electricity_subset$Global_active_power)
GlobalReactivePower <- as.numeric(electricity_subset$Global_reactive_power)
voltage <- as.numeric(electricity_subset$Voltage)
subMetering1 <- as.numeric(electricity_subset$Sub_metering_1)
subMetering2 <- as.numeric(electricity_subset$Sub_metering_2)
subMetering3 <- as.numeric(electricity_subset$Sub_metering_3)

#Generate the base plot
plot(timeseries, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(timeseries, subMetering2, type="l", col="red")
lines(timeseries, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


#Export the png file using the assignment sizes
dev.copy(png, file = "Plot3.png",width=480,height=480,res=72)

#Close the device after every generation of the graphs
dev.off()