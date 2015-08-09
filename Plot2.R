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
datetime <- paste(dmy(mainDT$Date), " ", mainDT$Time) ## put together with proper formating
mainDT <- mutate(mainDT, DateAndTime = ymd_hms(datetime)) ## to ensure the final Date and Time format


###[ Output to PNG File ]
plot(mainDT$Global_active_power~mainDT$DateAndTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)

dev.off()
