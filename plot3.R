## This part of code is common to all the plots


#========================================================================
  ## Reading the data 
  
  ## calculating memory required for the data
  ## memory for a data set = number of rows* number of columns* 8 bytes
  
  memory_bytes <- 2075259*9*8
  memory_mb <- memory_bytes/10^6
  cat("The memory required to store the data set is: ",memory_mb,"mb")
  
  
  ##loading the full data
  data <- read.table("household_power_consumption.txt",sep = ";",na.strings = "?",header = TRUE)
  
  ##Saving the Date in the data set as Date
  data$Date <- as.Date(data$Date,format = "%d/%m/%Y")
  
  
  ## subsetting the data based on the dates mentioned in the project
  data_req <- subset(data,Date == "2007-02-01"| Date == "2007-02-02")
  
  
  ##Merging the Date and time column of the new data set to a new column called date_time
  data_req$date_time <- paste(data_req$Date,data_req$Time)
  data_req$date_time <- as.character(data_req$date_time)
  
  
  ## Changing the Time in the data set as POSXlt format
  data_req$date_time <- as.POSIXlt(data_req$date_time)
  
#=================================================================



## Plot 3
## This plot shows the realation between the various sub meterings 
## The plot also has a legend and is made in 3 parts 
## Opening the new file device of png format
png("plot3.png",width = 480,height = 480)
par(mfrow = c(1,1))

##Part 1
## Plotting the sub_metering_1
with(data_req,plot(date_time,Sub_metering_1,ylab = "Energy sub metering",xlab = "",type = "l"))

##Part 2
## add the line of the sub_metering_2 wrt the time of each day to the plot from part 1
lines(data_req$date_time,data_req$Sub_metering_2,col = "red")


##Part 3
## add the lines of the sub_metering_3 wrt the times of each day to the plot of part 2
lines(data_req$date_time,data_req$Sub_metering_3,col = "blue")

## adding a legend to the plot 
legend("topright", lty = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"))

## switching off the currently active file device.
dev.off()