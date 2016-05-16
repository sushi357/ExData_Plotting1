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

df<-sub_y[,c("date_time","Global_active_power")]

df[,"Global_active_power"]<-as.character(df[,"Global_active_power"])
df[,"Global_active_power"]<-as.numeric(df[,"Global_active_power"])

png(file="plot2.png",width = 480, height = 480, units = "px")
with(df,{plot(date_time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")})
dev.off()

