## Set working directory
setwd("D:/Users/firaihan/Desktop/Data Science Assignments")


## Load tidyverse
library(tidyverse)

## Read the txt file
plot1 <- read_delim("household_power_consumption.txt", ";", col_names = TRUE, na = "?")

## Set the column Date as "Date"
plot1$Date <- as.Date(plot1$Date, "%d/%m/%Y")

## Filter for dates 1/2/2007 and 2/2/2007 only
plot1_filtered <- filter(plot1, Date == "2007-02-01" | Date == "2007-02-02") %>% 
  unite(DateTime, Date, Time)

## Format into POSIXct
plot1_filtered$DateTime <- as.POSIXct(plot1_filtered$DateTime, format ="%Y-%m-%d_%H:%M:%S")

## Open the device
png(filename = "plot1.png")

## Creating the histogram
hist(plot1_filtered$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")

## Close the device
dev.off()
