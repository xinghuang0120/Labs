# --------------- Lab 6: Viz ---------------

# install.packages("ggplot2")
library(ggplot2)
# install.packages("reshape2")
library(reshape2)

# ------------------------------------------
# Step 1: Load the data
 # Assign the built-in "airquality" dataset into a new variable called "air"
 air <- data.frame(airquality)

# ------------------------------------------
# Step 2: Clean the data
 # find which columns in the dataframe contain NAs.
 colnames(air)[colSums(is.na(air)) > 0]
 # Check if the NAs in column "Ozone" and replace them by the mean value of this column
 air$Ozone[is.na(air$Ozone)] <- mean(air$Ozone, na.rm=TRUE)
 # Check if the NAs in column "Solar.R" and replace those NAs by the mean value of this column
 air$Solar.R[is.na(air$Solar.R)] <- mean(air$Solar.R, na.rm=TRUE)

# ------------------------------------------
# Step 3: Understand the data distribution
 # histograms for each of the variables
 # use the Ozone in "air" dataframe as X variable to create a histogram
 # set the bin width to be 5, border color to be white, and bin color to be black
 ggplot(air, aes(x=Ozone)) + geom_histogram(binwidth=5, color="white", fill="black")
 # use the Solar in "air" dataframe as X variable to create a histogram 
 ggplot(air, aes(x=Solar.R)) + geom_histogram(binwidth=5, color="white", fill="black")
 # use the Wind in "air" dataframe as X variable to create a histogram 
 ggplot(air, aes(x=Wind)) + geom_histogram(binwidth=0.5, color="white", fill="black")
 # use the Temp in "air" dataframe as X variable to create a histogram 
 ggplot(air, aes(x=Temp)) + geom_histogram(binwidth=2, color="white", fill="black")
 # use the Month in "air" dataframe as X variable to create a histogram 
 ggplot(air, aes(x=Month)) + geom_histogram(binwidth=1, color="white", fill="black")
 # use the Day in "air" dataframe as X variable to create a histogram 
 ggplot(air, aes(x=Day)) + geom_histogram(binwidth=1, color="white", fill="black")
 
 # create boxplot for Ozone
 # To make a boxplot for a single variable, we need to create a fake grouping variable (x=factor(0)).
 ggplot(air, aes(x=factor(0), y=Ozone)) + geom_boxplot()
 # create boxplot for Wind
 ggplot(air, aes(x=factor(0), y=round(air$Wind))) + geom_boxplot()


# ------------------------------------------
# Step 3: Explore how the data changes over time
 # Paste the value in Month column, Day column, and "1973" together, and assign the result to the new created column called "Date"
 air$Date <- paste(air$Month, air$Day, 1973, sep="/")
 # convert the "Date" column to date format
 air$Date <- as.Date(air$Date, "%m/%d/%Y")
 # check the structure to see if the conversion works
 str(air)

 # create line charts for ozone, temp, wind and solar.R seperately
 # use dataframe "air" to create a line chart, considering "Date" as x variable, "Ozone" as y variable 
 ggplot(air, aes(x=Date, y=Ozone)) + geom_line()
 # use "Temp" as y variable 
 ggplot(air, aes(x=Date, y=Temp)) + geom_line()
 # use "Wind" as y variable 
 ggplot(air, aes(x=Date, y=Wind)) + geom_line()
 # use "Solar.R" as y variable 
 ggplot(air, aes(x=Date, y=Solar.R)) + geom_line()

 # create one chart with 4 lines, each having a different color
 # Multiply the Wind value by 10 to rescale the values so that they won't be too close to the x axis,
 # and then store the values into a new created column called "scaleWind"
 air$scaleWind <- air$Wind*10
 # create a new dataframe containing the four y variables and the x variable (Date).
 dfAir <- data.frame(air$Ozone, air$Solar.R, air$scaleWind, air$Temp, air$Date)

 # reframe the dataframe to stack all the y variables into a single column before visualization
 dfAir <- melt(dfAir, id=c("air.Date"))
 # create one chart with four lines, using "Date" as x variable, and the four factors as y variables
 # the colors are differentiated by the four variables
 ggplot(dfAir, aes(x=air.Date, y=value, color=variable)) + geom_line()

 
 # ------------------------------------------
 # Step 4: Look at all the data via a Heatmap
 # use data "dfAir" to create the chart, with each day along the x-axis and ozone, temp, wind and solar.r along the y-axis
 ggplot(dfAir, aes(x=air.Date, y=variable)) + 
   # Use geom_tile() function to demonstrate the chart as a heatmap, and fill the color according to variables' value
   geom_tile(aes(fill=value)) + 
   # define the low and high ends of the color gradient
   scale_fill_gradient(low="white", high="blue")
 

 # ------------------------------------------
 # Step 5: Look at all the data via a scatter chart
 # Use data "air" to create a scatter chart, with "Wind" along x-axis and "Temp" along y-axis.
 # Additionally, set the points' size according to "Ozone" value and set the shade of color according to "Solar.R" value.
 ggplot(air, aes(x=Wind, y=Temp)) + geom_point(aes(size = Ozone, color=Solar.R))

 # Step 6: Final Analysis
 # The scatter plot can be very useful, because it demonstrate data with more than two dimensions.
 