old_dir <- getwd()
setwd("c:/users/dansc/documents/coursera/exploratory data analysis/project1")
if (!file.exists("exdata-data-household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                    destfile="exdata-data-household_power_consumption.zip")
}
unzip("exdata-data-household_power_consumption.zip")

data <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
dated <- subset(data, Date >= as.Date("2007-02-01", "%Y-%m-%d") & Date <= as.Date("2007-02-02", "%Y-%m-%d"))
temp <- paste(dated$Date, as.character(dated$Time))
times <- strptime(temp, format = "%Y-%m-%d %H:%M:%S")
dated$Time <- times
dated$Global_active_power <- as.numeric(levels(dated$Global_active_power)[dated$Global_active_power])

par(mfrow=c(1,1))
hist(dated$Global_active_power, col="red", xlab = "Global active power (kilowatts)",
        ylab  = "Frequency", main = "Global Active Power")
dev.copy(png, "plot1.png")
dev.off()
setwd(old_dir)
