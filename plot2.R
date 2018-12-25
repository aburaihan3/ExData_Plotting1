## Set working directory
setwd("D:/Users/firaihan/Desktop/Data Science Assignments")

## Load tidyverse
library(tidyverse)

## Read the txt file
plot2 <- read_delim("household_power_consumption.txt", ";", col_names = TRUE, na = "?")

## Set the column Date as "Date"
plot2$Date <- as.Date(plot2$Date, "%d/%m/%Y")

## Filter for dates 1/2/2007 and 2/2/2007 only
plot2_filtered <- filter(plot2, Date == "2007-02-01" | Date == "2007-02-02") %>% 
  unite(DateTime, Date, Time)

## Format into POSIXct
plot2_filtered$DateTime <- as.POSIXct(plot2_filtered$DateTime, format ="%Y-%m-%d_%H:%M:%S")

## Open the device
png(filename = "plot2.png")

## Create the plot
plot(plot2_filtered$Global_active_power~plot2_filtered$DateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

## Close the device
dev.off()