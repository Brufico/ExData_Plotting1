
# Plot 2 ================================================

# Changing temporarily the "LC_TIME" locale
# save
curloctime <- Sys.getlocale("LC_TIME")
# set
Sys.setlocale("LC_TIME", "English")


message("Plot 2 ...")

# Open png device
png(filename = "plot2.png",
    width = 480, height = 480)

# create plot
plot(dta$dt, dta$global_active_power, 
     type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

# close png device
dev.off()

message("Plot 2 done")
# restore time settings
Sys.setlocale("LC_TIME", curloctime)

