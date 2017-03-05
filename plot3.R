# Read in the Data
# dt <- read.table("household_power_consumption.txt", sep = ";", skip = grep("1/2/2007|2/2/2007", readLines("household_power_consumption.txt")))
dt <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = F)

# Subset the Data
dt2 <- dt[dt$Date == "1/2/2007" | dt$Date == "2/2/2007",]

# Remove original Dataframe to free up memory
rm(dt)

#Convert Date Column to Data type Date from factor
dt2$Date <- as.Date(dt2$Date,"%d/%m/%Y")
dt2$Time <- format(dt2$Time, format = "%H:%M:%S")

# Format the column 3-9 to numeric data type
dt2[,3:9] <- sapply(dt2[,3:9], as.numeric)

library(lubridate)
# Create and format 
dt2$dateTime <- paste(dt2$Date, dt2$Time)
dt2$dateTime <- ymd_hms(dt2$dateTime)

# Open a png file to write 
png(file = "plot3.png", width = 480, height = 480, units = "px")
# Draw the Plot
with(dt2, plot(dt2$Sub_metering_1 ~ dateTime, type = "l", col = "red", ylab = "Energy Sub Metering", xlab= ""))
lines(dt2$Sub_metering_2 ~ dt2$dateTime, type = "l", col = "red")
lines(dt2$Sub_metering_3 ~ dt2$dateTime, type = "l", col = "blue")

# Draw the legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, col = c("black", "red","blue", lty = c(1,1,1)))
dev.off()