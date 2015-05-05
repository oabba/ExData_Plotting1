# Sequence of operations 
# 1 - This file autonomously downloads, unzips and extract the 
# data.
# 2 - loading all the data into R
# 3 - Extracting the data from Feb 01-02, 2007 as a new dataframe.
# 4 - Construct a new variable in the new dataframe
#     that occupies the date as well as time information.
# 5 - Generage plot1 and save it into plot1.png.

# We store the downloaded file as datasetProject01.zip
# Let us download it if it does not exist and also extract it since
# it is in .zip format

if (!file.exists("datasetProject01.zip")) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile="./datasetProject01.zip", cacheOK=FALSE)  
  #Extracting the zip folder
  unzip("datasetProject01.zip")  
}

# Loading the data
data <- read.table("household_power_consumption.txt", header=TRUE, 
                   na.strings="?", stringsAsFactors=FALSE, sep = ";")
# Extracting the required data
mask <- data[,1]  == "1/2/2007" | data[,1]  == "2/2/2007"
reqData <- data[mask,]

# Make a new variable in which both the date and time
# information is stored
reqData$DateTime <- paste(reqData$Date,reqData$Time)
# Converting to date/time class
reqData$DateTime <- strptime(reqData$DateTime, format="%d/%m/%Y %H:%M:%S")

# Loading the PNG device
png(file="plot1.png", width = 480, height = 480)
# plot 01
par(mfrow=c(1,1))
with(reqData, hist(Global_active_power, col="red", 
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power"))
dev.off()
#