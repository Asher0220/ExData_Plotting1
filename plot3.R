# Set your directory
setwd("C:/Users/Asus/Desktop/R/jjasantos")

# Read the data
data_orig <- read.table("household_power_consumption.txt", 
                        header=TRUE, sep=";", na.strings = "?", 
                        colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

# Convert the date variable to date class
data_orig$Date <- as.Date(data_orig$Date, "%d/%m/%Y")

# Use data from the dates 2007-02-01 and 2007-02-02
data_sub <- subset(data_sub,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Delete incomplete observations
data_sub <- data_sub[complete.cases(data_sub),]

# Join Date and Time columns
DT <- paste(data_sub$Date, data_sub$Time)

# Set a name for the vector
DT <- setNames(DT, "DateTime")

# Delete Date and Time columns
data_sub <- data_sub[ ,!(names(data_sub) %in% c("Date","Time"))]

# Add DT column
data_sub <- cbind(DT, data_sub)

# Format DT column
data_sub$DT <- as.POSIXct(DT)

# Construct plot3
with(data_sub, {
  plot(Sub_metering_1~DT, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DT,col='Red')
  lines(Sub_metering_3~DT,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save plot3 to a PNG file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()