source("get_and_clean_data.R")
datesOfInterest <- get_and_clean_data()
png("Plot4.png")
par(mfrow=c(2,2))
plot(datesOfInterest[,DateTime],datesOfInterest[,Global_active_power],type="l",xlab="",
     ylab="Global Active Power")
plot(datesOfInterest[,DateTime],datesOfInterest[,Voltage],type="l",xlab="datetime",
     ylab="Voltage")
plot(datesOfInterest[,DateTime],datesOfInterest[,Sub_metering_1],type="n",xlab="",
     ylab="Energy sub metering")
lines(datesOfInterest[,DateTime],datesOfInterest[,Sub_metering_1],col="black")
lines(datesOfInterest[,DateTime],datesOfInterest[,Sub_metering_2],col="red")
lines(datesOfInterest[,DateTime],datesOfInterest[,Sub_metering_3],col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1)
plot(datesOfInterest[,DateTime],datesOfInterest[,Global_reactive_power],type="l",xlab="datetime",
     ylab="Global_reactive_power")
dev.off()