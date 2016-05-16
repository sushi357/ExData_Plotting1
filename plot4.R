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


#voltage section
df_vol<-sub_y[,c("date_time","Voltage")]

df_vol[,"Voltage"]<-as.character(df_vol[,"Voltage"])
df_vol[,"Voltage"]<-as.numeric(df_vol[,"Voltage"])


#reactive power section
df_reac<-sub_y[,c("date_time","Global_reactive_power")]

df_reac[,"Global_reactive_power"]<-as.character(df_reac[,"Global_reactive_power"])
df_reac[,"Global_reactive_power"]<-as.numeric(df_reac[,"Global_reactive_power"])


#global active power section
df_glo<-sub_y[,c("date_time","Global_active_power")]

df_glo[,"Global_active_power"]<-as.character(df_glo[,"Global_active_power"])
df_glo[,"Global_active_power"]<-as.numeric(df_glo[,"Global_active_power"])


#sub metering section
df_sub<-sub_y[,c("date_time","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

df_sub[,"Sub_metering_1"]<-as.character(df_sub[,"Sub_metering_1"])
df_sub[,"Sub_metering_1"]<-as.numeric(df_sub[,"Sub_metering_1"])

df_sub[,"Sub_metering_2"]<-as.character(df_sub[,"Sub_metering_2"])
df_sub[,"Sub_metering_2"]<-as.numeric(df_sub[,"Sub_metering_2"])

df_sub[,"Sub_metering_3"]<-as.character(df_sub[,"Sub_metering_3"])
df_sub[,"Sub_metering_3"]<-as.numeric(df_sub[,"Sub_metering_3"])


#plotting section
png(file="plot4.png",width = 480, height = 480, units = "px")

par(mfcol=c(2,2))

with(df_glo,{plot(date_time,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")})

with(df_sub,{plot(date_time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")})
points(df_sub[,"date_time"],df_sub[,"Sub_metering_3"],type="l",col="blue")
points(df_sub[,"date_time"],df_sub[,"Sub_metering_2"],type="l",col="red")
legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(df_vol,{plot(date_time,Voltage,type="l",ylab="Voltage",xlab="datetime")})

with(df_reac,{plot(date_time,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")})

dev.off()

