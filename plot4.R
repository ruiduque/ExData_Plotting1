##
## House Hold Power Comsumption Analysis - Plot_4
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
               Sub_metering_3 = as.numeric(Sub_metering_3),
               Global_reactive_power = as.numeric(Global_reactive_power)) %>%
        filter(Date == "2007-02-01" | Date == "2007-02-02")

# Remove the complete dataset and retain only the two days required for analysis
rm(power_data_total)

# Plot 4 line graphs...
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(power_data, { 
        plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        plot(Date_Time, Voltage, type ="l", xlab = "datetime", ylab = "Voltage", yaxt = "n") 
        axis(2, at=seq(234000,246000,4000), labels = seq(234,246,4))
        { 
                plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
                points(Date_Time, Sub_metering_2, type = "l", col = "red")
                points(Date_Time, Sub_metering_3, type = "l", col = "blue")
                legend("topright", bty = "n", lty=c(1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        }
        plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

dev.off()

