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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(mainDT, {
     plot(Global_active_power~DateAndTime, type="l", ylab="Global Active Power", xlab="")
     
     plot(Voltage~DateAndTime, type="l", ylab="Voltage (volt)", xlab="datetime")
     
     plot(Sub_metering_1~DateAndTime, type="l", ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~DateAndTime,col='Red')
     lines(Sub_metering_3~DateAndTime,col='Blue')
     
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.25)
     
     plot(Global_reactive_power~DateAndTime, type="l", ylab="Global_Rective_Power",xlab="datetime")
})

###[ Output to PNG File ]
dev.copy(png, file="plot4.png", height=480, width=640)

dev.off()
