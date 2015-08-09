###[ Initializing Library ]

rm(list = ls())

library(dplyr)
library(data.table)
library(lubridate)
library(datasets)
library(graphics)

###[ Set working Directory to where the R source file is ]
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

###[ Part 1 : Read data from file ]
mainDT <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")

###[ Part 2 : Filter Data ]
mainDT <- filter(mainDT,(Date == "1/2/2007"|Date == "2/2/2007"))

###[ Convert Data ]
mainDT <- mutate(mainDT, Date = dmy(Date)) ## to Date Format

mainDT <- mutate(mainDT, Global_active_power = as.numeric(Global_active_power)) ## to numeric


###[ Output to PNG File ]
png(filename="Plot1.png", width=480, height=480)
hist(mainDT$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")


dev.off()

