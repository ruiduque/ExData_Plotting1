##
## House Hold Power Comsumption Analysis - Plot_3
##
## Coursera - Exploratory Data Analysis
##

ibrary(tidyverse)
library(lubridate)

file_for_analysis <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
main_dir <- getwd()

## Check if folder "./data" exists. If not, create it and download data file
if(!file.exists("./data")){
        dir.create("data")
        setwd("./data/")
        download.file(file_for_analysis, "raw_data.zip")
        unzip("raw_data.zip")
        setwd(main_dir)
}


power_data_total <- read_csv2("data/household_power_consumption.txt")

# Convert date and retain only records for 01-02-2007 & 02-02-2007
power_data <- power_data_total %>%
        mutate(Date = dmy(Date), Date_Time = as_datetime(paste(Date, Time)),
               Sub_metering_1 = as.numeric(Sub_metering_1),
               Sub_metering_2 = as.numeric(Sub_metering_2),
               Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

# Remove the complete dataset and retain only the two days required for analysis
rm(power_data_total)

# Plot the line graph for Global Active Power by date_time
png(file = "plot3.png", width = 480, height = 480)

with(power_data, plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(power_data, points(Date_Time, Sub_metering_2, type = "l", col = "red"))
with(power_data, points(Date_Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

