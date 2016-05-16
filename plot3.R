setwd("~/Desktop")

y<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

y[,"Date"]<-as.Date(y[,"Date"], format="%d/%m/%Y")

date<-y[,"Date"]
time<-y[,"Time"]
date_time<-paste(date,time)

date_time<-strptime(date_time,"%Y-%m-%d %H:%M:%S")

y<-cbind(y,date_time)

log1<-y[,"Date"]>="2007-02-01"
log2<-y[,"Date"]<="2007-02-02"
log<-log1 & log2

sub_y<-y[log,]

df<-sub_y[,c("date_time","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

df[,"Sub_metering_1"]<-as.character(df[,"Sub_metering_1"])
df[,"Sub_metering_1"]<-as.numeric(df[,"Sub_metering_1"])

df[,"Sub_metering_2"]<-as.character(df[,"Sub_metering_2"])
df[,"Sub_metering_2"]<-as.numeric(df[,"Sub_metering_2"])

df[,"Sub_metering_3"]<-as.character(df[,"Sub_metering_3"])
df[,"Sub_metering_3"]<-as.numeric(df[,"Sub_metering_3"])

png(file="plot3.png",width = 480, height = 480, units = "px")
with(df,{plot(date_time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")})
points(df[,"date_time"],df[,"Sub_metering_3"],type="l",col="blue")
points(df[,"date_time"],df[,"Sub_metering_2"],type="l",col="red")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()



