# numeric
# continuous variables: can be interval, most often ratio
x <- 10.5
class(x)

# integer
# continuous variables: interval values 
x <- 1000L
class(x)

# character/string
# categorical variables: nominal or ordinal
x <- "R is exciting"
class(x)

# logical/boolean
# categorical variables: only with 2 levels
x <- TRUE
class(x)

# complex
# functions
x <- 9i + 3
class(x)

###############################################################################################
#Dummy variables

df <- data.frame(gender = c("m", "f", "m"),
                 age = c(19, 20, 20),
                 city = c("Delhi", "Mumbai", 
                          "Delhi"))

# Print original dataset
print(df)

# Create dummy variable
df$gender_m <- ifelse(df$gender == "m", 1, 0)

# Print resultant
print(df)

###############################################################################################


#Atomic Vector using the R command c() that stands for combine.
x <- c(1, 2.5, 4.5)
str(x)
#subsetting 
x[2]


#Named vector 
vec <- c(1.2, 35.6, 35.2, 0.9, 46.7) 

# assigning names to the vector 
names(vec)<-c("Ele1", "Ele2",  
              "Ele3", "Ele4", "Ele5") 
vec <- as.numeric(vec) 



#List of which elements can be of any type, including lists
myList <- list(1:5, "Hello", c(TRUE, FALSE, TRUE), c(3.3, 9.9, 12.2))
#Subsetting
myList[[3]]
#Attributes in list
attr(myList,"My Attribute") <- "My First Attribute"
#Accessing attributes
attr(myList,"My Attribute")


#Matrice is a two-dimensional Atomic array. Easier for mathematical problems,
#requires less computational power
#all variables must be same type (e.g. chacarter, numeric..)
myMatrix <- matrix(1:6, ncol = 3, nrow = 2)
myMatrix
str(myMatrix)
#Subsetting
myMatrix[1,2]


#Arrays take vectors and can then convert them into multiple dimensions
#think of square matrices
#all variables must be same type (e.g. chacarter, numeric..)
data1 <- c(1,2,3,4,5,6)
data2 <- c(60, 18, 12, 13, 14, 19)

# assigning row names
row.names=c("row1","row2","row3")

# assigning column names
column.names=c("col1","col2","col3")

# assigning array names
matrix.names=c('array1','array2','array3')

# pass these vectors as input to the array.
#  3 rows,3 columns and 3 arrays
result <- array(c(data1, data2), dim = c(3,3,3),
                dimnames=list(row.names,column.names,
                              matrix.names))
print(result)


#Dataframe
df <- data.frame(x = 1:5, y = c("a", "b", "c", "d","e"))
str(df)
#subsetting
df[1,2]

