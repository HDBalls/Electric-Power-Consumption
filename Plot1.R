#Global Active Power Plot1
#Add the household_power_consumption.txt file to your working directory

#Install the packages for data load
install.packages("sqldf")
library(sqldf)

#Import the file to a dataset with the appropriate filters to limit the data
electricity_all <- read.csv.sql("household_power_consumption.txt", "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", sep=";")

#Generate the base histogram with annotations and other formatting 
with(electricity_all, hist(Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power"))

#Export the png file using the assignment sizes
dev.copy(png, file = "Plot1.png",width=480,height=480,res=72)

#Close the device after every generation of the graphs
dev.off()


