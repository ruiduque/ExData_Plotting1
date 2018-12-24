##
## House Hold Power Comsumption Analysis - Plot_1
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
                mutate(Date = dmy(Date)) %>%
                filter(Date == "2007-02-01" | Date == "2007-02-02") %>%
                mutate(Global_active_power = as.numeric(Global_active_power))

# Remove the complete dataset and retain only the two days required for analysis
rm(power_data_total)

# Plot the histogram for Global Active Power
png(file = "plot1.png", width = 480, height = 480)
hist(power_data$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

