
# Plot 4 ================================================

# Changing temporarily the "LC_TIME" locale
# save
curloctime <- Sys.getlocale("LC_TIME")
# set
Sys.setlocale("LC_TIME", "English")

message("Plot 4 ...")


# Plot 4 is made of 4 graphs (subplots) in a 2x2 layout

# switch to png device
png(filename = "plot4.png",
    width = 480, height = 480)


# save current graph layout
curpar <- par("mfrow")
# change graph layout to 2x2
par(mfrow = c(2, 2))



# sp1 is plot2-------------------------------------------
plot(dta$dt, dta$global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# sp2 is similar, with "voltage" ------------------------
plot(dta$dt, dta$voltage, 
     type = "l",
     ylab = "Voltage",
     xlab = "datetime")



# sp3 is Plot3, but without a  boundary around the legend box-----

# create plot with 1st series
plot(dta$dt, dta$sub_metering_1 ,  
     type = "l",
     ylab = "Energy sub metering",
     xlab = "")

# Add second series
lines(dta$dt, dta$sub_metering_2 ,  
      type = "l", col="red")

# Add third series
lines(dta$dt, dta$sub_metering_3 ,  
      type = "l", col="blue")

# Add legend
legend("topright",
       legend=c("sub_metering_1", "sub_metering_2", "sub_metering_3"),
       lty = 1, 
       col=c("black","red", "blue"),
       bty="n")


# sp4 is similar to sp1 and sp2,  with "reactive_power" -------
plot(dta$dt, dta$global_reactive_power, 
     type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")




# restore graph layout to original value
par(mfrow = curpar)

# close png device
dev.off()


message("Plot 4 done")
# restore time settings
Sys.setlocale("LC_TIME", curloctime)

