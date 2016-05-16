library(lubridate)

setwd("~/Desktop")

y<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

y[,"Date"]<-as.Date(y[,"Date"], format="%d/%m/%Y")

log1<-y[,"Date"]>="2007-02-01"
log2<-y[,"Date"]<="2007-02-02"
log<-log1 & log2

sub_y<-y[log,]

df<-sub_y[,"Global_active_power"]

df<-as.character(df)
df<-as.numeric(df)

png(file="plot1.png",width = 480, height = 480, units = "px")
hist(df, col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()


