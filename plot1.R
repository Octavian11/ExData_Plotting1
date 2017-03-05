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

png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(dt2$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatt)", col = "red")
dev.off()