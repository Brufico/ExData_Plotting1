#  =======================================================
# Exploratory Data Analysis, Assignment 1
# ========================================================

#  libraries
library(lubridate)

# Changing temporarily the "LC_TIME" locale
# save
curloctime <- Sys.getlocale("LC_TIME")
# set
Sys.setlocale("LC_TIME", "English")



### Data handling  =======================================

#  data location in the work directory  ==================
dir <- "exdata_data_household_power_consumption"
fname <- "household_power_consumption.txt"
fpath <- file.path(".",dir,fname)



# selectively read rows from the file ========================
# source of the method: Stackoverflow: 
# http://stackoverflow.com/questions/6592219/read-csv-from-specific-row


# read 1st row and get the number of columns
dta_row1 <- read.table(fpath, header = TRUE,
                       sep=";", na.strings = "?", nrow = 1)
nc <- ncol(dta_row1)


# read now all rows, but skip all columns but the first (a bit slow)
message("Reading first column of a large data file - may take a while...")

# reading. if the class of a column is "NULL", the column is skipped
dta <- read.table(fpath, header = TRUE, sep=";",
                  as.is = TRUE, na.strings = "?",
                  colClasses = c(NA, rep("NULL", nc - 1)))


message("computing read.table parameters...")

#  make a column of date-times from the strings in col 1.
#  (Surprisingly, this is fast enough).
dta$dt <- dmy(dta$Date)

# indices of beginning and end of useful data rows
begin <- ymd("2007-02-01")
end <- ymd("2007-02-02")

nb <- which.max(dta$dt >= begin)
ne <- which.max(dta$dt > end)

# number of rows to read
okrows <- ne - nb

message("Reading relevant data...")
# effectively read  the relevant rows
dta <- read.table(fpath, header = TRUE, 
                  sep=";",
                  skip = nb - 1,
                  nrows = okrows,
                  colClasses = c("character", 
                                 "character", 
                                 rep("numeric", nc - 2) ))


#  re-establish variable names lost because of 'skip=...' 
#  (in lowercase)
colnames(dta) <- tolower(names(dta_row1))


# combine dates & times in column "dt"
dta$dt <- dmy(dta$date) + hms(dta$time)




message("Data ready. Commencing plotting")

### Plotting  ===========================================



# Plot 1 ================================================
message("Plot 1 ...")

# Open png device
png(filename = "plot1.png",
    width = 480, height = 480)

# create plot
hist(dta$global_active_power, 
     col="red", 
     main = "Global Active Power",
     ylab = "Frequency",
     xlab = "Global Active Power (kilowatts)" )

# close png device
dev.off()


message("Plot 1 done")
# restore time settings
Sys.setlocale("LC_TIME", curloctime)

