get_and_clean_data <- function() {
  ## read in the whole file
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
  household_power_consumption <- fread(unzip(temp),sep=";",header=TRUE,na.strings="?",
                                       colClasses=c(Date="character",Time="character",Global_active_power="character",
                                                    Global_reactive_power="character",Voltage="character",Global_intensity="character",
                                                    Sub_metering_1="character",Sub_metering_2="character",Sub_metering_3="character"))
  unlink(temp)
  ## Use data tables
  require(data.table)
  # household_power_consumption <- fread("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",
  #                                     colClasses=c(Date="character",Time="character",Global_active_power="character",
  #                                                  Global_reactive_power="character",Voltage="character",Global_intensity="character",
  #                                                  Sub_metering_1="character",Sub_metering_2="character",Sub_metering_3="character"))
  ## remove rows with NA
  final <- complete.cases(household_power_consumption)
  clean_household_power_consumption <- household_power_consumption[final,]
  ## convert text date and time to date and time type
  clean_household_power_consumption[,"newCol"] <- paste(clean_household_power_consumption$Date,clean_household_power_consumption$Time,sep=" ")
  DateTime <- as.POSIXct(strptime(clean_household_power_consumption[,newCol],"%d/%m/%Y %H:%M:%S",tz="GMT"),tz="GMT")
  ## make a "copy" with just the columns we need and date/time converted to POSIXct
  keeps <- c("Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
  clean_copy_household_power_consumption <- clean_household_power_consumption[,keeps,with=FALSE]
  clean_copy_household_power_consumption <- cbind(DateTime,clean_copy_household_power_consumption)
  ## Extract dates of interest (2007-02-01 - 2007-02-02)
  datesOfInterest1 <- clean_copy_household_power_consumption[as.Date(DateTime) == as.Date("2007-02-01")]
  datesOfInterest2 <- clean_copy_household_power_consumption[as.Date(DateTime) == as.Date("2007-02-02")]
  datesOfInterest <- rbind(datesOfInterest1,datesOfInterest2)
  datesOfInterest
}