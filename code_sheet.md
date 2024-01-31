---
title: "Code Sheet"
output: 
  html_document: 
    keep_md: true
date: "2024-01-31"
---



# Shortcuts   

Creating a new Code Chunk: option + command + i    
"Gets" <-: option + -    
Pipe " %>% : shift + command + m    
Automatically run code chunk: command + return    

# Lab 1    

## Installing and Loading Packages     


```r
#install.packages("tidyverse")
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Working Directory     

Checking current working directory:    


```r
getwd()
```

```
## [1] "/Users/catrinelberevoescu/Desktop/BIS15W2024_cberevoescu"
```

## Arithmetic and Basic Statistics    


```r
4+2 #Addition
```

```
## [1] 6
```

```r
4-2 #Subtraction
```

```
## [1] 2
```

```r
4*12 #Multiplication
```

```
## [1] 48
```

```r
12/4 #Division
```

```
## [1] 3
```

```r
(4*12)/2 #Order of Operations
```

```
## [1] 24
```


```r
x <- c(4, 6, 8, 5, 6, 7, 7, 7) #Creating an object
mean(x)
```

```
## [1] 6.25
```

```r
median(x)
```

```
## [1] 6.5
```

```r
sd(x)
```

```
## [1] 1.28174
```

# Lab 2   

## Objects   


```r
x <- 42 #creating a new object
```

## Types of Data    


```r
my_numeric <- 42
my_integer <- 2L #adding an L automatically denotes an integer
my_character <- "universe"
my_logical <- FALSE
my_complex <- 2+4i
```

Finding Type of Data:   

`class()`   

Clarifying and Specifying Type of Data with is() and as() functions:   


```r
#is.integer(my_numeric) #is my_numeric an integer?
#my_integer <- as.integer(my_numeric) #create a new object specified as an integer
```

## Missing Data     

Finding NAs in your data:    

`is.na()`   
`anyNA()`   

## Vectors   

Create vectors using the c command (c stands for concatenate)   


```r
#my_vector <- c()
```

Generating Sequences of Numbers:    


```r
my_vector_sequence <- c(1:100)
```

Identifying Vector Elements:    


```r
#my_vector[3]
```

## Data Matrices     

Data Matrices as Stacked Vectors:   


```r
#multiple_vectors <- c(vector_1, vector_2, vector_3)
#my_matrix <- matrix(multiple_vectors, nrow = 8, byrow = T) #using nrow and byrow commands
```

Naming Columns and Rows:   


```r
#colnames() <- column_name_vector
#rownames() <- row_name_vector
```

Adding Row Values:   

`rowSums()`  

Adding New Columns and Rows:    


```r
#new_matrix <- cbind(matrix_name, column_data)
#new_matrix <- rbind(matrix_name, row_data)
```

Selecting Specific Data:    


```r
#the_matrix[row_number,column_number]
#the_matrix[element1:element4]
#the_matrix[,column_number] #selecting value in entire column
#the_matrix[row_number,column_number] #selecting value in entire row
```

# Lab 3   

## Data Frames    


```r
#new_dataframe <- data.frame(vector_1, vector_2, vector_3) #will NOT be using this in class
```

Finding Dimensions:

`dim()`   
`str()`   

Accessing Specific Columns or Rows:    


```r
#my_dataframe[row_number,]
#my_dataframe[,column_number]
```

Adding Rows:   


```r
#my_dataframe <- rbind(my_dataframe, rowname)
```

Adding Columns:   


```r
#my_dataframe$columnname <- c(data1, data2, data3)
```

Writing Data to a File:   


```r
#write.csv(my_dataframe, "my_dataframe.csv", row.names = FALSE)
```

Loading Data:    


```r
#read_csv("filename")
```

Use 'str()' to get an idea of the data structure   
 
Summary Functions:    

Summarize data frame with `summary()` function.      
`glimpse()` is another useful summary function.    
`nrow()` gives numbers of rows.     
`ncol` gives number of columns.     
`dim()` gives dimensions.     
`names` gives column names.    
`head()` prints first n rows of data frame.   
`tail()` prints last n rows of  data frame.    
`table()` produces fast counts of the number of observations in a variable.     
Visualize data with `view()` function

# Lab 4    

## dyplr   

### select()    

Allows you to pull out columns of interest from a dataframe.    

Finding column names:     

`names()`   


```r
#select(my_dataframe, "columnname")
#select(my_dataframe, start_col:end_col)
```

The - operator allows to select everything except the specified variables: d   


```r
#select(my_dataframe, -not_this_column)
```

Options for Selecting specific Columns:    
1. ends_with() = columns ending with a character string   
2. contains() = columns containing a character string   
3. matches() = columns matching a regular expression  
4. one_of() = columns names from a group of names   

Selecting Columns Based on Data Class:     


```r
#select_if(my_dataframe, is.numeric)
#select_if(fish, ~!is.numeric(.)) #selecting all columns not a class of data
```

## Renaming Variables    


```r
#my_dataframe <- rename(vector_1, vector_2_new_name=vector2, vector_3_new_name="vector3")
```

## filter()     

Allows to extract data meeting specific criteria within a variable.     

filter() allows all of the expected operators:    
>, >=, <, <=, != (not equal), and == (equal).

Use ! operator to exclude specific observations.     

Use the `%in%` operator to filter multiple values within the same variable.     

Use you can use `between()` to look for a range of specific values.    

Extracting observations “near” a certain value:   


```r
#filter(my_dataframe, near(columnname, value, tol = 0.2))
```

# Lab 5    

## Rules for Using filter()    

+ `filter(condition1, condition2)` returns rows where BOTH conditions are met.   
+ `filter(condition1, !condition2)` returns rows where condition one IS true BUT condition 2 is NOT.   
+ `filter(condition1 | condition2)` returns rows where condition 1 OR condition 2 is met.   
+ `filter(xor(condition1, condition2)` returns rows where ONLY ONE of the conditions is met, and not when both.   

## Pipes %>%    

Example:    


```r
#my_dataframe %>%
  #select(column_1, column_2) %>%
  #filter(column_1 == "datapoint")
```

## arrange()   

For sorting data:   


```r
#my_dataframe %>% 
  #select(column_1, column_2) %>%
  #filter(column_1 == "datapoint") %>% 
  #arrange(column_1) #default is ascending
#arrange(desc(column_2)) #for descending order
```

## mutate()    

Creating a new column from existing columns.    

Example:    


```r
#my_datframe %>% 
  #mutate(new_column_name = column_1*10) #creates new column at end of dataframe
```

## mutate_all()   

For cleaning data:    


```r
#my_dataframe %>%
  #mutate_all(tolower)
```

Use across function to specify individual columns:    


```r
#my_dataframe %>% 
  #mutate(across(c("column1", "column4"), tolower))
```

## ifelse()   

Example:    


```r
#my_dataframe %>% 
  #select(column1, column2, column3) %>%
  #mutate(column1_new = ifelse(column1 == -999.00, NA, column1))
```

# Lab 6   

...
