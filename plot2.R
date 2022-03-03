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



##Plot 2
## The plot is a line plot with the x axis as the time of the day for each day
## and the y axis is the Global Active Power
par(mfrow = c(1,1))
with(data_req,plot(date_time,Global_active_power,type = "l",ylab = "Global Active Power (killowatts)",xlab = ""))

## copying the plot to a png file with height and width 480 using the dev.copy function
dev.copy(png,"plot2.png",width = 480,height = 480)


## switching off the currently active file device
dev.off()