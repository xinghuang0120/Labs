# ---------- Lab3: Cleaning Dataframes ----------

# -----------------------------------------------
# Step 1: Create a function (named readStates) to read a CSV file into R
 # create a function called "readStates" that can read in a CSV file from a URL
 readStates <- function(Statefile)
 {
   dataset <- read.csv(url(Statefile))
   # return the results
   return(dataset)
 }
 # use the function to read the URL
 States <- readStates("http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv")
 
 # 3. Fix the issues (removing columns, removing rows, changing column names)
 # remove useless colums and rows (only keep row 9 through 59 and column 1 through 5)
 clStates <- States[(9:59), (1:5)]
 # change names for the left five columns
 colnames(clStates)<-c("stateName", "Jul2010", "Jul2011", "base2010", "base2011")
 
 # 4 & 5
 # remove "." in stateName column (replace "." by nothing)
 # note that "." must be escaped using backslashes, or everything in the column would be replace by nothing
 clStates$stateName<-gsub("\\.","",clStates$stateName)
 # check the numbers of rows and columns, and data types for each column
 str(clStates)
 # remove all comma in the last four columns, and convert those columns to numeirc type
 clStates$Jul2010 <- as.numeric(gsub(",", "", clStates$Jul2010))
 clStates$Jul2011 <- as.numeric(gsub(",", "", clStates$Jul2011))
 clStates$base2010 <- as.numeric(gsub(",", "", clStates$base2010))
 clStates$base2011 <- as.numeric(gsub(",", "", clStates$base2011))
 # re-check the data types for each column
 str(clStates)
 
 
# -----------------------------------------------
# Step 2: Store and Explore the dataset
 # 6. Store the dataset into a dataframe called dfStates
 dfStates <- clStates

 # 7. Test your dataframe by calculating the mean for the July2011 data
 mean(dfStates$Jul2011)
 

# -----------------------------------------------
# Step 3:  Find the state with the Highest Population
 # Based on the July2011 data, what is the population of the state with the highest population?
 # 8. find the highest population in column Jul2011, and store the population number in "highestPopulation'
 max(dfStates$Jul2011)
 # get the index of highest population first, and then get its state name
 dfStates[which.max(dfStates$Jul2011), 1]
 
 # 9. Sort the data, in increasing order, based on the July2011 data
 # create a permutation which can rearrange column "Jul2011" into ascending order
 sortOrder <- order(dfStates$Jul2011)
 # rearrange the dataframe by the created permutation
 sortState <- dfStates[sortOrder,]

 
# -----------------------------------------------
# Step 4:  Explore the distribution of the states
 # 10. Write a function that takes two parameters. The first is a vector and the second is a number.
 # create a function called "Distribution" that takes two parameters
 Distribution <- function(vector,number)
 {
   # only keep the elements within the vector that are less than the number, and store the number of eligible elements into the variable "count"
   count <- length(vector[vector < number])
   # calculate the percentage and return the results
   return(count/length(vector))
 }
 ??length()
 
 # 12. test the function, the result should be 0.2
 Distribution(c(1,2,3,4,5), 2)
 
 # 13. test the function with the vector ‘dfStates$Jul2011Num’, and the mean of dfStates$Jul2011Num’.
 Distribution(dfStates$Jul2011, mean(dfStates$Jul2011))

 