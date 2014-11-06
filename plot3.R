path <- "E:/Coursera/Exploratory/assignment1/"
setwd(path)

# read data and subset
file.name <- unzip("exdata_data_household_power_consumption.zip", list=TRUE)$Name[1]
unzip("exdata_data_household_power_consumption.zip",files=file.name,overwrite=TRUE)

file.raw <- read.table("household_power_consumption.txt",
 sep=";", stringsAsFactors = FALSE,
 na.strings = c("NA",""),header=TRUE)
 
file.sub <- file.raw[file.raw$Date == "1/2/2007" |
 file.raw$Date == "2/2/2007",]
row.names(file.sub) <- NULL

#processing
dateconvert <- function(x) strptime(paste(x[1],x[2],sep=" "), "%d/%m/%Y %H:%M:%S")

datetime <- cbind(file.sub[,1:2])
datetime <- apply(datetime,1,dateconvert)
index.tmp  <- unlist(lapply(datetime,as.POSIXct))
index <- as.POSIXct(index.tmp,origin="1970-01-01")
 
data.raw <- sapply(file.sub[,3:9],as.numeric)
data.df <- data.frame(index,data.raw)

png("plot3.png")
plot(as.POSIXct(index),data.df$Sub_metering_1, type = 'l',
ylab = "Energy sub metering",xlab="")
lines(as.POSIXct(index),data.df$Sub_metering_2,col="red")
lines(as.POSIXct(index),data.df$Sub_metering_3,col="blue")
legend("topright", lwd =1, col = c("black","red","blue"),
legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
