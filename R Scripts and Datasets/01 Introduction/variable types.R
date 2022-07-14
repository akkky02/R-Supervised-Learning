#basic R version information
#get version 
version

#list packages installed
library()
library(Matrix)  

#list libraries in use
search()

#scalar variables hold one value at a time of a particular data type
#R is dynamically typed
#create a numeric variable
my_scalar <- 12
my_Scalar <- 14
typeof(my_scalar)
class(my_scalar)
str(my_scalar)

#also numeric
my_scalar <- 12.0
class(my_scalar)

#integer
my_scalar <- as.integer(12)
class(my_scalar)
typeof(my_scalar)
str(my_scalar)

#character
my_scalar <- "abc"
class(my_scalar)


#also character
my_scalar <- "12"
class(my_scalar)

#logical
my_scalar <- FALSE
class(my_scalar)

#vectors, matrices, lists, dataframes, and factors
#vectors store a sequence of items of the same data type
#c() function Combine Values into a Vector or List is used to create vectors
my_vector <- c(10, 20, 30)
class(my_vector)
str(my_vector)
typeof(my_vector)
my_vector
print(my_vector)
my_vector[2]

my_vector <- c(1:1000)
class(my_vector)
str(my_vector)
my_vector

my_vector <- c("abc", 1, "geh")
class(my_vector)
str(my_vector)
my_vector

my_vector <- c("abc", TRUE, "geh")
class(my_vector)
str(my_vector)
my_vector


#matrices are vectors of width 2 x 2 dimensions
#2 x 2 numeric matrix
my_matrix <- matrix(1:10, nrow = 5, ncol = 2, byrow = TRUE)

matrix()
matrix()

class(my_matrix)
str(my_matrix)
View(my_matrix)

col_names <- c("X", "Y")
row_names <- c(1:5)
my_matrix <- matrix(1:10, nrow = 5, ncol = 2, byrow = FALSE, dimnames = list(row_names, col_names))
matrix()



second_column <- my_matrix[,2]
str(second_column)
View(second_column)

first_row <- my_matrix[1,]
str(first_row)
View(first_row)

big_vector <- c(1:100)
View(big_vector)

element3.2 <- my_matrix[3,2]
str(element3.2)
View(element3.2)
element3.2  

#lists may contain multiple values and different data types in one or more dimensions
my_list <- list("abc", 1, FALSE)
str(my_list)

my_list <- list("abc", 1:10, FALSE)
str(my_list)

#get first 
first_item <- my_list[1]
str(first_item)
class(first_item)
first_item


#get first item value
first_item_value <- my_list[[1]]
str(first_item_value)
class(first_item_value)

#get second
second_item <- my_list[2]
str(second_item)
class(second_item)


#get second item value
second_item_value <- my_list[[2]]
str(second_item_value)
class(second_item_value)

#get value 4 from 2nd item in list my_list[[2]][4] returns the same thing
fourth_value <- my_list[[2]][[4]]
str(fourth_value)
class(fourth_value)

#coerce an integer vector to a numeric vector
second_item_value <- my_list[[2]]
str(second_item_value)
class(second_item_value)
second_item_value_numeric <- as.numeric(second_item_value)
str(second_item_value_numeric)


#dataframes are a special type of 2 dimensional list
#data frames are what we will work with most often
my_dataframe <- data.frame(my_matrix)
class(my_dataframe)
str(my_dataframe)
View(my_dataframe)

#get all rows of the second column using the column number
df <- my_dataframe[,2]
class(df)
str(df)
df

#get all rows of the second column using the column name
df <- my_dataframe$X2

my_dataframe$X1
class(df)
str(df)

names(my_dataframe) <- c("Variable1", "Variable2")
View(my_dataframe)

row.names(my_dataframe) <- c("Row1", "Row2", "Row3", "Row4", "Row5")
View(my_dataframe)

#categorical i.e. nominal variables are called factors
#Gender factor is unordered
#

gender_factor <- factor(c("Male", "Female"), ordered = FALSE)
class(gender_factor)
str(gender_factor)
levels(gender_factor)

#create an ordered factor for size
size_factor <- factor(c("Small", "Medium", "Large"), ordered = TRUE, levels = c("Medium", "small", "Large"))
class(size_factor)
str(size_factor)

#will talk more about functions and objects later


df_mtcars <-mtcars
View(df_mtcars)
df20 <- df_mtcars[mtcars$mpg > 20, ]




df20 <- mtcars[mtcars$mpg > 20, ]
View(df20)

