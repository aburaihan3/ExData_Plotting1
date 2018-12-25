## Set working directory
setwd("D:/Users/firaihan/Desktop/Data Science Assignments")

## Load tidyverse
library(tidyverse)

## Read the txt file
plot4 <- read_delim("household_power_consumption.txt", ";", col_names = TRUE, na = "?")

## Set the column Date as "Date"
plot4$Date <- as.Date(plot4$Date, "%d/%m/%Y")

## Filter for dates 1/2/2007 and 2/2/2007 only
plot4_filtered <- filter(plot4, Date == "2007-02-01" | Date == "2007-02-02") %>% 
  unite(DateTime, Date, Time)

## Format into POSIXct
plot4_filtered$DateTime <- as.POSIXct(plot4_filtered$DateTime, format ="%Y-%m-%d_%H:%M:%S")

## Open the device
png(filename = "plot4.png")

## Create the plot
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(plot4_filtered, {
  plot(Global_active_power~DateTime, type = "l", 
       ylab="Global Active Power", xlab = "")
  plot(Voltage~DateTime, type = "l", 
       ylab="Voltage", xlab = "datetime")
  plot(Sub_metering_1~DateTime, type = "l", 
       ylab="Energy sub metering", xlab = "")
  lines(Sub_metering_2~DateTime,col = 'Red')
  lines(Sub_metering_3~DateTime,col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type = "l", 
       ylab="Global_reactive_power", xlab = "datetime")
})

## Close the device
dev.off()
