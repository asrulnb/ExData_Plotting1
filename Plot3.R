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


###[ Plot the Graph ]
with(mainDT, {
     plot(Sub_metering_1~DateAndTime, type="l", ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~DateAndTime,col='Red')
     lines(Sub_metering_3~DateAndTime,col='Blue')
})

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)

###[ Output to PNG File ]
dev.copy(png, file="plot3.png", height=480, width=480)

dev.off()
