## Set working directory
setwd("D:/Users/firaihan/Desktop/Data Science Assignments")

## Load tidyverse
library(tidyverse)

## Read the txt file
plot3 <- read_delim("household_power_consumption.txt", ";", col_names = TRUE, na = "?")

## Set the column Date as "Date"
plot3$Date <- as.Date(plot3$Date, "%d/%m/%Y")

## Filter for dates 1/2/2007 and 2/2/2007 only
plot3_filtered <- filter(plot3, Date == "2007-02-01" | Date == "2007-02-02") %>% 
  unite(DateTime, Date, Time)

## Format into POSIXct
plot3_filtered$DateTime <- as.POSIXct(plot3_filtered$DateTime, format ="%Y-%m-%d_%H:%M:%S")

## Open the device
png(filename = "plot3.png")

## Create the plot
with(plot3_filtered, {
  plot(Sub_metering_1~DateTime, type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2~DateTime,col = 'Red')
  lines(Sub_metering_3~DateTime,col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lwd = c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the device
dev.off()