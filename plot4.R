
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
hp_filter$Sub_metering_1 <- as.numeric(as.character(hp_filter$Sub_metering_1))
hp_filter$Sub_metering_2 <- as.numeric(as.character(hp_filter$Sub_metering_2))
hp_filter$Sub_metering_3 <- as.numeric(as.character(hp_filter$Sub_metering_3))


## Open PNG device, create plot, and close
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(hp_filter$Date_Time, hp_filter$Global_active_power
     , xlab = ""
     , ylab = "Global Active Power"
     , col = "black"
     , type = "l")

plot(hp_filter$Date_Time, hp_filter$Voltage
     , xlab = "datetime"
     , ylab = "Voltage"
     , col = "black"
     , type = "l")

plot(hp_filter$Date_Time, hp_filter$Sub_metering_1
     , type = "l"
     , xlab = ""
     , ylab = "Energy sub metering"
     , col = "black")
lines(hp_filter$Date_Time, hp_filter$Sub_metering_2, type = "l", col = "red")
lines(hp_filter$Date_Time, hp_filter$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), bty="n")

plot(hp_filter$Date_Time, hp_filter$Global_reactive_power
     , xlab = "datetime"
     , ylab = "Global_reactive_power"
     , col = "black"
     , type = "l")


dev.off() 

