# Read in subset of data file to get column class info
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 100, stringsAsFactors = FALSE, na.strings = "?")

# determine class of each column
classes <- sapply(initial, class)

# Read in entire data file
tabAll <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?", colClasses = classes)

# Convert Date column to Date format from character
tabAll[,1] <- as.Date(tabAll[,1], format = "%d/%m/%Y")

# Subset data to the two days we care about, 2/1/2007 - 2/2/2007
subset_data <- tabAll[tabAll$Date == "2007-02-01" | tabAll$Date == "2007-02-02",]

# Adding a new column containing date and time
subset_data$DateTime <- strptime(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")

# plot 1
png(filename = "plot1.png", width = 480, height = 480)
hist(subset_data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
