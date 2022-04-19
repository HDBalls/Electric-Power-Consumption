#Global Active Power Plot2
#Add the household_power_consumption.txt file to your working directory

#Install the packages for data load
install.packages("sqldf")
library(sqldf)
library(lubridate)
library("data.table")

#Import the file to a dataset with the appropriate filters to limit the data
electricity_all <- read.csv.sql("household_power_consumption.txt" ,"select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

#Convert Date to the correct representation
electricity_all$Date_Date <- as.Date(electricity_all$Date, format = "%d/%m/%Y")


#Add the day column to the dataset
electricity_all$Day_Of_Week_Text <- lubridate::wday(electricity_all$Date_Date, label = TRUE, abbr = TRUE)

#Generate the base plot
plot(electricity_all$DateTime, as.numeric(as.character(electricity_all$Global_active_power)), 
     type = "l", xlab = "Date", ylab = "Global Active Power (kilowatts)")

#Export the png file using the assignment sizes
dev.copy(png, file = "Plot2.png",width=480,height=480,res=72)

#Close the device after every generation of the graphs
dev.off()