##
## House Hold Power Comsumption Analysis - Plot_2
##
## Coursera - Exploratory Data Analysis
##

library(tidyverse)
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
        mutate(Date = dmy(Date), Date_Time = as_datetime(paste(Date, Time)), Global_active_power = as.numeric(Global_active_power)) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

# Remove the complete dataset and retain only the two days required for analysis
rm(power_data_total)

# Plot the line graph for Global Active Power by date_time
png(file = "plot2.png", width = 480, height = 480)
with(power_data, plot(Date_Time, Global_active_power, type = "l", 
                      xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()

