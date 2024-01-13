###Welcome!
#This is our first practical for how to transform data for statistical 
#analysis, and how to perform simple baseline statistics


1.1
#Let's install a few packages for our analysis today
install.packages("plyr")

#Now, you try: install the package called "scales"



1.2
#Let's bring those packages to this working environment with the library()
#function
library(plyr)

#Now, bring the package "scales" to this working environment



1.3
#We have our packages installed and in our working environment
#Let's import our data file "PROMOTE_BC3_cohort_Participants.txt" using 
#the read.delim() function.
#The data is locally on your computer and we want to bring it into R
#Remember to flip your dashes if working on Windows!
#Use the command "?" in front of any function to get information about
#how it works
#For example:
?read.delim
#For R functions out of the packages in this working directory use two questionmarks
??read.delim


#Example
Participants <- read.delim('C:/Users/sonja/Documents/JUNIA_applied_biostatistics/RAW_DATA/PROMOTE_BC3_cohort_Participants.txt',header = T)


2.1
#Great!
#Explore the data frame "Participants" with the following functions:
str()
colnames()
nrow()
ncol()
summary()
#How many variables were measured from these participants?
#How many participants were enrolled in the study?

2.2
#We can also examine a single variable, for example the heights of the participants
#Lets examine the heights of each participant and the frequency distribution
#of the heights.
#What shape is the distribution?
#What is the reason for this?
#Example:
summary(Participants$Height..cm...EUPATH_0010075.)
hist(Participants$Height..cm...EUPATH_0010075.)



#Examine the age of the participants enrolled using the summary() and hist() function
#What shape is the distribution?
#What is the reason for this?


2.3
#We can also examine levels of categorical variables, for example what
#drugs did the participant use during labor and delivery
unique(Participants$Medications.during.labor.and.delivery..EUPATH_0042212.)



#Examine the different reasons for withdrawal from this study using the
#unique() function




2.4
#We can also see proportions of this data with the count() function from the package "plyr"
#We will examine it by saving the results into the data frame "Medications_used"
Medications_used <- count(Participants$Medications.during.labor.and.delivery..EUPATH_0042212.)
View(Medications_used)



#Let's do the same for the reasons for withdrawal. Use the count() function
#and save it as a data frame with a name of your choosing using the "<-" function
#View your data frame with the View() function
#In the primary publication it stated tha 687 participants went through with the study.
#Is this reflected in the documentation for withrawal? Who was eliminated from the study?





3.01
#Let's start examining some basic characteristics of the participants enrolled
#We will want to characterize our study population by 1) Age, 2) Height, 3) Gestational Age 
#at Enrollment, 4) whether they used a bed net the night before, 5) whether 
#they have placental malaria, 6) whether they had a low birth weight
#and 7) the treatment arm they were part of.
#Locate the columns we need with the colnames() function on the Participants data frame
colnames()


#Lets subset those columns into a separate "Characteristics" Data frame from the 
#"Participants" data frame
Characteristics <- Participants[]


#Use the str() function to examine the data frame "Characteristics"
#You should have 782 observations over 7 variables
str()


3.02
#In order to perform a means calculation, we have to change the character
#variables into numeric
#To do that we have to change the character strings "yes" and "no" into
#number 1's and 0's

#To do that, we will use the lapply() function to apply the gsub() function
#to modify the data frame "Characteristics"
#Do this in two steps: 1) change Yes -> 1 and 2) No-> 0 in the whole data frame
#Remember to convert your result into a data frame with the function
#data.frame(), and save it as "Numerical_Data"
Numerical_Data <-


#Lets check our dataframe "Numerical_Data" with the str() function
str(Numerical_Data)


3.03
#Even though our Data is represented as numbers, R considers them as characters
#Let's change that!
#Use lapply() again to apply the function as.numeric() onto the first 6 columns of the
#"Numerical_Data" dataframe. Save it into the "Numerical_Data" by using
#The data.frame() function
#Remember! Only change the first 6 columns into numeric, and examine it through
#the str() function
Numerical_Data <-




3.04
#Bravo!
#Now, we will split the data frame in half with the split() function
#based on which drug (DP or SP) each of the participants got assigned to
#Split the data based on the study arm and name it as "split_list"
split_lsit



3.05
#Our split created two Data frames under the list called "split_list"
#Lets unlist the data by subsetting them into two data frames one for 
#those patients who were treated with DP, and one for those patients who
#were treated with SP

#HINT:
#To access a first column of a dataframe you use dataframe[,1]
#To access the first dataframe in a list, you use list[[1]]
#Save the two dataframes in the list as DP_DF and SP_DF, respectively
DP_DF<-
SP_DF<-


3.06
#GREAT!
#Now our Data is in two dataframes, and we can perform our basic statistics
#Let's find the mean for all our variables except the treament arm
#by using the colMeans() function.
#Remember to omit your missing values, and use the round() function to round
#The means to 2 digits






3.07
#We now have two vectors, which are Named numericals. Lets change those into
#By using first making them a list with a as.list() function, then
#data frames with the data.frame() function




3.08
#Let's name our observations of the means now using the rownames() function
#So that we don't lose track of our data




3.09
#Let's make two dataframes into one "Means" dataframe by using the rbind() function
Means <-


3.10
#Lets make our data horizontal instead of longitudinal
#We will use the transpose t() function and save it as a data.frame()
#as Means_DF
Means_DF <-


3.11
#One way to calculate a proportions (percentages) from binary data is by calculating
#the mean. So for the "yes" and "no" variables, we were calculating the
#percentages of occurrences (Yes=1, No=0)
#Let's change those observations using the percent() function. 
#Apply this function using the function lapply() on the 2,5 and 6 row of our
#Means_DF dataframe
Means_DF



3.12
#Finally, we can rename our rows and columns for presentation with the
#rownames() and colnames () function



3.11 
#You can view your dataframe with the View() function or simply clicking the 
#dataframe in the top right corner



4.0
#The above section is was to refamiliarize you with basic R commands for 
#transforming datasets and performing basic functions in R
#We will use these commands and many more in the upcoming lessons.
#Now, it is your turn to choose variables from the PROMOTE_BC3_cohort_Participants.txt dataset
#That you find interesting and describe the group of individuals involved in this study
#Choose at least 5 variables
#Look into the package "table1" and its documentation for automated 
#generation of descriptive statistics.
#Include this table and a interpretation in your final presentation during
#the last class



#####################################################################################

#TO INCLUDE IN THE PRESENTATION:
4.0 #Descriptive statistics and its interpretation

#####################################################################################
