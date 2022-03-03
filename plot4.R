## This part of code is common to all the plots
## This file contains the code for Plot 4 which is explained below the common code 

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





## Plot 4
## This plot consists of 4 diffrent plots 
## Each plot is described below as well as plotted
## Opening the new file device of png format
png("plot4.png",width = 480,height = 480)


## First, we set the parameter of the plot to plot 4 plots row wise in the same plot
par(mfrow = c(2,2))


##Now, we plot the first plot, which is Global active power versus the time of each day
with(data_req,plot(date_time,Global_active_power,type = "l",ylab = "Global Active Power",xlab = ""))


## The second plot shows the relation between Voltage consumed and the time of each day
with(data_req,plot(date_time,Voltage,type = "l",ylab = "Voltage",xlab = "datetime"))



## The third plot is the same as the sub metering plot
## It shows the variation of various sub metering over time for each day in the data set
with(data_req,plot(date_time,Sub_metering_1,ylab = "Energy sub metering",xlab = "",type = "l"))
lines(data_req$date_time,data_req$Sub_metering_2,col = "red")
lines(data_req$date_time,data_req$Sub_metering_3,col = "blue")
legend("topright", lty = 1,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),bty = "n")

## The last and final plot is the Global reactive power versus the time on each day
with(data_req,plot(date_time,Global_reactive_power,type = "l",xlab = "datetime"))

## switching off the currently active file device
dev.off()