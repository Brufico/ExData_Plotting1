---
title: "Readme_too"
author: "BFC"
date: "9 janvier 2016"
output: html_document
---

# __Requirements__
* The data is assumed to have already been downloaded, and unzipped.
* It should reside in a subdirectory of the working directory named "exdata_data_household_power_consumption".
* The name of the file itself is assumed to be "household_power_consumption.txt"
* this is the situation you will get if you just download the original zip file in the working directory and unzip it, using the default destination directory.

# __Code__
The code is in the files "plot1.R", "plot2.R", "plot3.R" and "plot4.R", as per the instructions.
However, "plot1.R" should be sourced before sourcing any other script file, as it contains the data-reading code. (see below).
For convenience, a script "plot_master.R" is also provided, which sources the scripts "plot1.R" to "plot4.R" in sequence.

# __Data reading and preparation__

## Location of the data-reading code
In order not to repeat the same operations, the data is read at the beginning of the script "plot1.R", and that code is not repeated in later plot scripts. Thus "plot1.R" must be sourced before sourcing any other script file.

## Handling the data size issue
If read entirely, the data would reside in a dataframe which might be too large for some computers. In order to avoid this, the following method (based on:  http://stackoverflow.com/questions/6592219/read-csv-from-specific-row) has been used :

1. Read the first row only and get the number of columns and the column names
2. Read the file, skipping all columns but the first, which contains the date (using `read.table` with argument `colClasses` and `"NULL"`)
3. Compare the dates in this dataframe  to the beginning and end dates (2007-02-01 and 2007-02-02) and compute the ranks of the relevant rows of data (the dates are assumed arranged chronologically)
4. Read only the relevant rows of data (using the parameters `skip`and `nrow`). Note : When using `read.table` with `skip`, the columns names are not correctly read and must be reestablished using the result of step 1, above.

## Handling missing values
 I used the parameter `na.strings = "?"` in `read.table`. This does not seem to be a real issue with this data.

## Handling dates and times

### Package `lubridate`
`lubridate` has been used for all date-time operations. Notably, a new variable "dt" is added to the dataframe, which contains the date-times of each row of measurements, obtained by combining the first two columns.

### Local time setting
On plots 2 to 4, the x-scale is a time scale (hence the need for the variable "dt"), and the labels shown are the names of the week-days, which depend on the local settings. In order to closely match the desired result, the local time setting (french) has been altered to english, then restored using `Sys.getlocale("LC_TIME")` and `Sys.setlocale("LC_TIME", <string-value>)`.
Using these functions, one should be aware that the `<string-value>` to use are system-dependent. On my machine (Windows/Rstudio) , I used "English" with good results, but this may not work on your machine (see http://stackoverflow.com/questions/17031002/get-weekdays-in-english-in-rstudio)
This should be done only once at the beginning and end of the operations. However, as the code is divided in four scripts, the time setting is modified at the beginning of each script, and then restored at the end of the same script.


# __Plotting__
The plots have been tested on the screen, then the code has been altered to use the `png` device, with a size of 480 x 480 pixels, as per instructions. The plots are saved in the working directory under the names "plot1.png", "plot2.png", "plot3.png" and "plot4.png"