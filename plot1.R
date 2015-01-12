
## data.table needed for between function
require(data.table)

## Set working directory
setwd("C:/Users/brianhamilton82/Desktop/Brians Stuff/Coursera/Exploratory Data Analysis/Course Project 1")

## Read in text file
household_power_consumption <- read.csv("C:/Users/brianhamilton82/Desktop/Brians Stuff/Coursera/Exploratory Data Analysis/Course Project 1/household_power_consumption.txt", sep=";")

## Convert Date and time to Date time column
household_power_consumption$Date_Time <- as.POSIXct(strptime(paste(household_power_consumption$Date,household_power_consumption$Time), "%d/%m/%Y %H:%M:%S"))


## Filter data frame by new DateTime column
hp_filter <- household_power_consumption[between(household_power_consumption$Date_Time
                           ,as.POSIXct(strptime("2007-02-01 00:00:00", "%Y-%m-%d %H:%M:%S"))
                           ,as.POSIXct(strptime("2007-02-02 23:59:59", "%Y-%m-%d %H:%M:%S"))),]

## Convert field to numeric
hp_filter$Global_active_power <- as.numeric(as.character(hp_filter$Global_active_power))


## Open PNG device, create plot, and close
png(filename="plot1.png", width=480, height=480)
hist(hp_filter$Global_active_power
     , main = "Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , col = "red")
dev.off() 


