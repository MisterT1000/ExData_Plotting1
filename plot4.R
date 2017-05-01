library(data.table)

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, "exdata_data_household_power_consumption.zip")
unzip("exdata_data_household_power_consumption.zip")

hpc <-
  read.csv(
    file = "household_power_consumption.txt",
    sep = ";",
    na.strings = "?",
    header = TRUE,
    skip = 66630,
    nrows = 2900
  )
names(hpc) <-
  c(
    "Date",
    "Time",
    "Global_active_power",
    "Global_reactive_power",
    "Voltage",
    "Global_intensity",
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  )
hpc <- hpc[hpc$Date == '1/2/2007' | hpc$Date == '2/2/2007', ]
hpc[,1] <- as.Date(hpc[,1], format = "%d/%m/%Y")
hpc[,2] <- as.ITime(hpc[,2], format = "%H:%M:%S")
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))

plot(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
points(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Sub_metering_2,type = "l", col="red")
points(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Sub_metering_3,type = "l", col="blue")
legend("topright", bty = "n", pt.cex=1, cex=0.85, legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), pch="_")

plot(as.POSIXct(paste(hpc$Date, hpc$Time), format="%Y-%m-%d %H:%M:%S"), hpc$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()