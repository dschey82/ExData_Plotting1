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
dated$Sub_metering_1 <- as.numeric(levels(dated$Sub_metering_1)[dated$Sub_metering_1])
dated$Sub_metering_2 <- as.numeric(levels(dated$Sub_metering_2)[dated$Sub_metering_2])

par(mfrow=c(1,1))
plot(dated$Time, dated$Sub_metering_1, xlab="", ylab="Energy sub metering", type="l", col="black")
lines(dated$Time, dated$Sub_metering_2, col="red")
lines(dated$Time, dated$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lwd=1)
dev.copy(png, "plot3.png")
dev.off()
setwd(old_dir)
