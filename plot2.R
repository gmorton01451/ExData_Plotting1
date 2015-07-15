source("get_and_clean_data.R")
datesOfInterest <- get_and_clean_data()
png("Plot2.png")
plot(datesOfInterest[,DateTime],datesOfInterest[,Global_active_power],type="l",xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()