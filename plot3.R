
# Plot 3 ================================================

# Changing temporarily the "LC_TIME" locale
# save
curloctime <- Sys.getlocale("LC_TIME")
# set
Sys.setlocale("LC_TIME", "English")

message("Plot 3 ...")


# Open png device
png(filename = "plot3.png",
    width = 480, height = 480)

# create plor with 1st series
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
       col=c("black","red", "blue"))

# close png device
dev.off()


message("Plot 3 done")

# restore time settings
Sys.setlocale("LC_TIME", curloctime)

