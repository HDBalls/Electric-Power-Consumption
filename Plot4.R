#Global Active Power Plot4
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

# Format the columns
electricity_subset <- electricity_all[electricity_all$Date %in% c("1/2/2007","2/2/2007"),]
GlobalActivePower <- as.numeric(electricity_subset$Global_active_power)
GlobalReactivePower <- as.numeric(electricity_subset$Global_reactive_power)
voltage <- as.numeric(electricity_subset$Voltage)
subMetering1 <- as.numeric(electricity_subset$Sub_metering_1)
subMetering2 <- as.numeric(electricity_subset$Sub_metering_2)
subMetering3 <- as.numeric(electricity_subset$Sub_metering_3)

#Join the date and Time into a separate column
DateTime <- strptime(paste(electricity_subset$Date, electricity_subset$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

#Add the day column to the dataset
electricity_subset$Day_Of_Week_Text <- lubridate::wday(electricity_subset$Date_Date, label = TRUE, abbr = TRUE)

#Generate the base plots
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
# First plot - Global Active Power
plot(DateTime, GlobalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# Second plot - Voltage
plot(DateTime, voltage, type="l", xlab="datetime", ylab="Voltage")
# Third plot - Energy Submetering
plot(DateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(DateTime, subMetering2, type="l", col="red")
lines(DateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Fourth plot - Global_reactive_power
plot(DateTime, GlobalActivePower, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)


#Export the png file using the assignment sizes
dev.copy(png, file = "Plot4.png")

#Close the device after every generation of the graphs
dev.off()