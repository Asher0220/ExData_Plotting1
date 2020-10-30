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

# Construct plot2
plot(data_sub$Global_active_power~data_sub$DT, type="l", 
  ylab="Global Active Power (kilowatts)", xlab="")

# Save plot2 to a PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

