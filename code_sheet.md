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
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
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

```r
library("skimr")
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

## tabyl()   

`tabyl()` produces counts and also percentages.        

# Lab 7     

## skimr package


```r
#skim() #creates summaries of the data
```

## hist()    

Histograms are a quick way to check the output.   

## `summarize()`  

`summarize()` produces summary statistics for a given variable in a data frame.     

Example:    


```r
#msleep %>% 
  #filter(bodywt>200) %>% 
  #summarize(mean_sleep_lg=mean(sleep_total),
            #min_sleep_lg=min(sleep_total),
            #max_sleep_lg=max(sleep_total),
            #sd_sleep_lg=sd(sleep_total),
            #total=n())
```

`n_distinct()` is a very handy way of cleanly presenting the number of distinct observations.   

### Useful Summary Stats:   

`sd()`, `min()`, `max()`, `median()`, `sum()`, `n()` (returns the length of a column), `first()` (returns first value in a column), `last()` (returns last value in a column) and `n_distinct()` (number of distinct values in a column).    

## `group_by()`     

Used for selecting by a certain variable.     

## Counts   

`count()` is way of determining the number of observations there are within a column. It is like a combination of `group_by()` and `n()`.    

## `across()`  

A function in dplyr called `across()` is designed to work across multiple variables.   

Example:   


```r
#penguins %>%
  #summarize(distinct_species = n_distinct(species),
            #distinct_island = n_distinct(island),
            #distinct_sex = n_distinct(sex))
```

versus using across()       


```r
#penguins %>%
  #summarize(across(c(species, island, sex), n_distinct))
```

For continuous variables:    


```r
#penguins %>%
  #summarize(across(contains("mm"), mean, na.rm=T))
```

Summarizing across all variables:    


```r
#penguins %>%
  #summarise_all(n_distinct)
```

Operators also work:    


```r
#penguins %>%
  #summarize(across(!c(species, island, sex, year), 
                   #mean, na.rm=T))
```

All of the other dplyr operators also work:    


```r
#penguins %>%
  #summarise(across(starts_with("bill"), n_distinct))
```


# Lab 8   

##`purrr` package     

This will give you a quick summary of the number of NA's in each variable.    


```r
#life_history %>% 
  #map_df(~ sum(is.na(.)))
```

## `nanair` package    

`miss_var_summary` provides a summary of NA's across the data frame.    

Using `mutate()` and `na_if()` to replace 0's with NA's. This chunk allows us to address problems in a single variable.    


```r
#data.frame <- data.frame %>% 
  #mutate(variable=na_if(variable, 0))
```

Using `miss_var_summary` with `group_by()`. This helps us better evaluate where NA's are in the data.    


```r
#data.frame %>%
  #group_by(variable) %>%
  #miss_var_summary(variable=T)
```

Using `naniar` to replace a specific value (like -999) with NA across the entire data set.   


```r
#data.frame %>% 
  #replace_with_na_all(condition = ~.x == -999)%>% 
#miss_var_summary()
```

`naniar` has some built-in examples of common values or character strings used to represent NA's. The chunk below will use these built-in parameters to replace NA's across the entire data set.    


```r
#common_na_strings
```


```r
#common_na_numbers
```


```r
#data.frame %>% 
  #replace_with_na_all(condition = ~.x %in% c(common_na_strings, common_na_numbers)) %>% 
  #mutate(variable=na_if(variable, "not measured"))
```

## Dealing with NA's in advance- nuclear option   


```r
#read_csv(file = "data/mammal_lifehistories_v3.csv", na = c("NA", " ", ".", "-999", "not measured")) %>% clean_names()
```

# Lab 9    

## Tidy data    

Most "wild" data are organized incorrectly for work in R and, as you might expect, the tools used to transform data are a core part of the tidyverse. I will attempt to summarize the most important points below, but you should read [chapter 12 of the data science text](https://r4ds.had.co.nz/tidy-data.html) for a more thorough explanation.  

`Tidy` data follows three conventions:   
(1) each variable has its own column  
(2) each observation has its own row  
(3) each value has its own cell  

## `pivot_longer()`  

Scientists frequently use spreadsheets that are organized to make data entry efficient - **wide format**. Wide format creates a problem because column names may actually represent values of a variable. The command `pivot_longer()` shifts data from wide to long format.   

Rules:  
+ `pivot_longer`(cols, names_to, values_to)
+ `cols` - Columns to pivot to longer format
+ `names_to` - Name of the new column; contains column names of gathered columns as values
+ `values_to` - Name of the new column; contains the data stored in the values of gathered columns.    

## Potential Examples:    

### 1. column names are data.  

#### Solution:   

Reshape the table to long format while keeping track of column names and values, using `pivot_longer()`.    


```r
#dataframe %>% 
  #pivot_longer(-patient, 
               #names_to = "drug", 
               #values_to="heartrate" 
               #)
```

### 2. some column names are data.  

#### Solution 1: specify a range of columns that you want to pivot.    


```r
#dataframe <- 
  #dataframe %>% 
  #pivot_longer(wk1:wk76, # a range of columns
               #names_to = "week",
               #values_to = "rank", 
               #values_drop_na = TRUE #this will drop the NA's
               #)
```

#### Solution 2: OR, specify columns that you want to stay fixed.    


```r
#dataframe <- 
  #dataframe %>% 
  #pivot_longer(-c(artist, track, date.entered), #specific columns to stay fixed
               #names_to = "week",
               #values_to = "rank",
               #values_drop_na = TRUE
               #)
```

#### Solution 3: identify columns by a prefix, remove the prefix and all NA's.    


```r
#dataframe %>% 
   #pivot_longer(
   #cols = starts_with("wk"), #columns that start with "wk"
   #names_to = "week",
   #names_prefix = "wk",
   #values_to = "rank",
   #values_drop_na = TRUE)
```

### 3. more than one variable in a column name.   

`names_sep` helps pull these apart, but we still have "exp" and "rep" to deal with.   


```r
#dataframe %>% 
  #pivot_longer(
    #exp1_rep1:exp3_rep3,
    #names_to= c("experiment", "replicate"),
    #names_sep="_",
    #values_to="mRNA_expression"
  #)
```

## `unite()`    

`unite()` is the opposite of separate(), give a new column name and then list the columns to combine with a separation character.    

## `pivot_wider()`    

The opposite of `pivot_longer()`. You use `pivot_wider()` when you have an observation scattered across multiple rows.      

Rules:  
+ `pivot_wider`(names_from, values_from)  
+ `names_from` - Values in the `names_from` column will become new column names  
+ `values_from` - Cell values will be taken from the `values_from` column    

# Lab 10    

## Data Types    

+ `discrete` quantitative data that only contains integers
+ `continuous` quantitative data that can take any numerical value
+ `categorical` qualitative data that can take on a limited number of values    

## Basic Syntax.   

**plot= data + geom_ + aesthetics**.  

First call the ggplot function, identify the data, and specify the axes. Then add the `geom` type to describe how we want our data represented. Lastly, add aesthetics.     

# Lab 11    

## Bar Plots

Barplots count the number of observations in a categorical variable.    

### `geom_col`.   


```r
#dataframe %>% 
  #count(variable, sort=T) %>% 
  #ggplot(aes(x=variable, y=variable2))+
  #geom_col()+
  #coord_flip()
```

### `geom_bar`


```r
#dataframe %>% 
  #ggplot(aes(x=variable))+
  #geom_bar()+
  #coord_flip()
```

### NOTE: The following code cancels scientific notation for the session:    


```r
options(scipen=999)
```

Can add `scale_y_log10()` to scale the data.   

Can adjust x-axis labels to make them more readable with `reorder`:    


```r
#life_history %>% 
  #group_by(order) %>% 
  #summarize(mean_mass=mean(mass, na.rm=T)) %>% 
  #ggplot(aes(x=reorder(order, mean_mass), y=mean_mass))+ #reorder the x-axis
  #geom_col()+
  #coord_flip()+
  #scale_y_log10()
```

## Scatterplots    

Scatterplots allow for comparisons of two continuous variables.    
 

```r
#life_history %>% 
  #ggplot(aes(x=gestation, y=wean_mass))+
  #geom_jitter(na.rm=T)+ #geom_jitter instead of geom_point to avoid overplotting
  #scale_y_log10()
```

## Boxplots    

Box plots helps visualize a range of values; the x-axis typically has something categorical and the y-axis is the range.    


```r
#life_history %>% 
  #ggplot(aes(x=order, y=mass))+
  #geom_boxplot(na.rm=T)+
  #coord_flip()
```

## Aesthetics: Labels    

Add a line of best fit with `geom_smooth`:   


```r
#elephants %>% 
  #ggplot(aes(x=age, y=height)) + 
  #geom_point() + 
  #geom_smooth(method=lm, se=F)
```

Adding and Moving/Resizing Labels:   


```r
#elephants %>% 
  #ggplot(aes(x=age, y=height)) + 
  #geom_point() + 
  #geom_smooth(method=lm, se=F)+
  #labs(title="Elephant Age vs. Height",
       #x="Age",
       #y="Height")+
  #theme(plot.title=element_text(size=rel(1.5), hjust=.5))
```

`fill` is a common grouping option that colors in barplots.    


```r
#elephants %>% 
  #ggplot(aes(x=sex, fill=sex))+
  #geom_bar()
```

`size` adjusts the size of points relative to a continuous variable.    


```r
#life_history %>% 
  #ggplot(aes(x=gestation, y=log10(mass), size=mass))+
  #geom_point(na.rm=T)
```

Coloring points by a categorical variable:   


```r
#p+geom_point(aes(color=thermoregulation), size=1.5)
```

Mapping shapes to another categorical variable:   


```r
#p+geom_point(aes(shape=thermoregulation, color=thermoregulation), size=1.5) # we use color here and not fill because we are not filling a shape
```

Building stacked bar plots:   


```r
#homerange %>% 
  #ggplot(aes(x = taxon, fill = trophic.guild)) + 
  #geom_bar() +
  #coord_flip() +
  #labs(title = "Observations by Taxon in Homerange Data",
       #x = "Taxonomic Group",
       #fill = "Trophic Guild") #fill is the legend title
```

Counts shown side-by-side by specifying `position="dodge"`:     


```r
#homerange %>% 
  #ggplot(aes(x = taxon, fill = trophic.guild)) + 
  #geom_bar(position = "dodge") +
  #labs(title = "Observations by Taxon in Homerange Data",
       #x = "Taxonomic Group",
       #fill = "Trophic Guild") +
  #coord_flip()
```

Orienting plots vertically:    


```r
#homerange %>% 
  #ggplot(aes(x = taxon, fill = trophic.guild)) +
  #geom_bar(position = "dodge") +
  #theme(axis.text.x = element_text(angle = 60, hjust = 1)) + #angle is the angle of the text
  #labs(title = "Observations by Taxon in Homerange Data",
       #x = "Taxonomic Group",
       #fill= "Trophic Guild")
```

Scaling all bars to a percentage:    


```r
#homerange %>% 
  #ggplot(aes(x = taxon, fill = trophic.guild))+
  #geom_bar(position = position_fill())+ 
  #scale_y_continuous(labels = scales::percent)+
  #coord_flip()
```

Using `group` to make individual box plots for each taxon:    


```r
#homerange %>% 
  #ggplot(aes(x = class, y = log10.mass, group = taxon)) +
  #geom_boxplot()
```

Using `fill` to associate the different taxa with a color coded key:


```r
#homerange %>% 
  #ggplot(aes(x = class, y = log10.mass, fill = taxon)) +
  #geom_boxplot()
```

# Lab 12    

## Line Plots   

Line plots are great when you need to show changes over time.   


```r
#deserts %>% 
  #filter(species_id=="DM" | species_id=="DS") %>% 
  #mutate(year = as.factor(year)) %>%
  #group_by(year, species_id) %>% 
  #summarise(n=n(), .groups='keep') %>% 
  #ggplot(aes(x=year, y=n, group=species_id, color=species_id))+
  #geom_line()+
  #geom_point(shape=2)+ # you can experiment with shapes
  #theme(axis.text.x = element_text(angle = 60, hjust = 1))+
  #labs(title = "Number of samples for species DM & DS",
       #x = "Year",
       #fill = "n")
```

## Histograms     

Histograms show the distribution of continuous variables.   


```r
#homerange %>% 
  #ggplot(aes(x = log10.mass)) +
  #geom_histogram(color = "black", fill = "turquoise4", bins=10)+
  #labs(title = "Distribution of Body Mass")
```

## Density plots   

Density plots are similar to histograms but they use a smoothing function to make the distribution more even and clean looking. They do not use bins.    

Plotting both the histogram and the density curve.    


```r
#homerange %>% 
  #ggplot(aes(x=log10.mass)) +
  #geom_histogram(aes(y = after_stat(density)), fill = "deepskyblue4", alpha = 0.4, color = "black")+
  #geom_density(color = "red")+
  #labs(title = "Distribution of Body Mass")
```

## Creating Categories with mutate and case_when()    

`case_when()` is a function from `dplyr`. It allows us to calculate a new variable from other variables, using `case_when()` within `mutate()` to do this.`case_when()` allows us to specify multiple conditions.    


```r
#homerange <- homerange %>% 
             #mutate(mass_category = case_when(log10.mass <= 1.75 ~ "small",
                                              #log10.mass > 1.75 & log10.mass <= 2.75 ~ "medium",
                                              #log10.mass > 2.75 ~ "large"))
```

## ggplot themes   

There are many options to change the theme of your plots within ggplot. Have a look: [here]https://ggplot2.tidyverse.org/reference/ggtheme.html).  

Example:   


```r
#p + theme_linedraw()+
  #theme(axis.text.x = element_text(angle = 60, hjust=1))+
  #labs(title = "Observations by Taxon in Homerange Data",
       #x = NULL,
       #y= "n",
       #fill= "Trophic Guild")
```

## Legends    

Options for manipulating legends [here](http://www.sthda.com/english/wiki/ggplot2-legend-easy-steps-to-change-the-position-and-the-appearance-of-a-graph-legend-in-r-software).    

## Using `ggthemes`   

[ggthemes](https://yutannihilation.github.io/allYourFigureAreBelongToUs/). Some of these are nice because they are designed to mimic the look of popular publications.    

## RColorBrewer   

The [R Color Brewer](http://colorbrewer2.org/#type=sequential&scheme=BuGn&n=3) website helps with the color palettes. Two guidelines:    

+`scale_colour_brewer()` is for points  
+`scale_fill_brewer()` is for fills 

## Manually Setting Colors    

Using `paleteer` to build a custom palette for consistency.    

To access the `paleteer` collection, add it to a new object:    


```r
#colors <- paletteer::palettes_d_names
```

Setting and Displaying the palettes. `paleteer` is a collection of popular palettes.   


```r
#my_palette <- paletteer_d("ggsci::nrc_npg")
```


```r
#barplot(rep(1,6), axes=FALSE, col=my_palette)
```

Identify `my_palette` as part of `scale_fill_manual()`:    


```r
#p+scale_fill_manual(values=my_palette)+
  #theme(legend.position = "bottom",
        #axis.text.x = element_text(angle = 60, hjust=1))+
  #labs(title = "Observations by Taxon in Homerange Data",
       #x = NULL,
       #y= "n",
       #fill= "Trophic Guild")
```

## [Faceting](https://ggplot2-book.org/facet.html)    

Allows the creation of multi-panel plots for easy comparison.  

`facet_wrap()` makes a ribbon of panels by a specified categorical variable and allows control over arrangement.      


```r
#homerange %>% 
  #ggplot(aes(x=taxon, y=log10.mass))+
  #geom_boxplot()+
  #facet_wrap(~trophic.guild, ncol=2)+
  #theme(axis.text.x = element_text(angle = 60, hjust=1))
```

`facet_grid()` allows control over the faceted variable; it can be arranged in rows or columns. rows~columns. 


```r
#homerange %>% 
  #ggplot(aes(x=taxon, y=log10.mass))+
  #geom_boxplot()+
  #facet_grid(trophic.guild~.)+
  #theme(axis.text.x = element_text(angle = 60, hjust=1))
```

`facet_grid()` allows comparison of two categorical variables (a~b; a is rows, b is columns).    


```r
#homerange %>% 
  #ggplot(aes(x=taxon, y=log10.mass))+
  #geom_boxplot()+
  #facet_grid(trophic.guild~thermoregulation)+
  #theme(axis.text.x = element_text(angle = 60, hjust=1))
```


