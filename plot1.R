library(data.table)
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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(hpc$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()