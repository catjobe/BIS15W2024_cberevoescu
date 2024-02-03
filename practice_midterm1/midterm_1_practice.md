---
title: "Midterm 1"
author: "Catrinel Berevoescu"
date: "2024-02-02"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your code should be organized, clean, and run free from errors. Remember, you must remove the `#` for any included code chunks to run. Be sure to add your name to the author header above. You may use any resources to answer these questions, but you may not post questions to Open Stacks or external help sites. There are 15 total questions, each is worth 2 points.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse
If you plan to use any other libraries to complete this assignment then you should load them here.

```r
library(tidyverse)
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
library(janitor)
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Questions  

Wikipedia's definition of [data science](https://en.wikipedia.org/wiki/Data_science): "Data science is an interdisciplinary field that uses scientific methods, processes, algorithms and systems to extract knowledge and insights from noisy, structured and unstructured data, and apply knowledge and actionable insights from data across a broad range of application domains."  

1. (2 points) Consider the definition of data science above. Although we are only part-way through the quarter, what specific elements of data science do you feel we have practiced? Provide at least one specific example.  

I believe that we have practiced using algorithms to extract knowledge and insights from the data. An example if you have a dataset of the number, type and location of fish caught at different times of the year, and you are trying to find out which in which month in a certain location the most fish are caught. In this situation, you could use filter(location) to select all data points at a certain location, group_by(month) function to find certain observations from a certain month, and mean() within the summarize() function to find the average catch values.    

2. (2 points) What is the most helpful or interesting thing you have learned so far in BIS 15L? What is something that you think needs more work or practice?  

I think the most helpful thing I have learned so far in BIS 15L is pipes, and the variety of options with the filter() and select() functions. This is really important for me because I am working with very large datasets, and knowing how to subset them and find the particular data points I need is vital. I think I need more practice with remembering all of the possible functions I can use, and which will or will not work in different situations.    

In the midterm 1 folder there is a second folder called `data`. Inside the `data` folder, there is a .csv file called `ElephantsMF`. These data are from Phyllis Lee, Stirling University, and are related to Lee, P., et al. (2013), "Enduring consequences of early experiences: 40-year effects on survival and success among African elephants (Loxodonta africana)," Biology Letters, 9: 20130011. [kaggle](https://www.kaggle.com/mostafaelseidy/elephantsmf).  

3. (2 points) Please load these data as a new object called `elephants`. Use the function(s) of your choice to get an idea of the structure of the data. Be sure to show the class of each variable.    

Loading the data as the new object `elephants`:    


```r
elephants <- read_csv("data/ElephantsMF.csv")
```

```
## Rows: 288 Columns: 3
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (1): Sex
## dbl (2): Age, Height
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

Structure of the Data and the Class of each Variable:   


```r
glimpse(elephants)
```

```
## Rows: 288
## Columns: 3
## $ Age    <dbl> 1.40, 17.50, 12.75, 11.17, 12.67, 12.67, 12.25, 12.17, 28.17, 1…
## $ Height <dbl> 120.00, 227.00, 235.00, 210.00, 220.00, 189.00, 225.00, 204.00,…
## $ Sex    <chr> "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M", "M"…
```

4. (2 points) Change the names of the variables to lower case and change the class of the variable `sex` to a factor.    

Changing the names of the variables to lower case:   


```r
elephants <- clean_names(elephants)
```


```r
names(elephants)
```

```
## [1] "age"    "height" "sex"
```

Changing the class of the variable `sex` to a factor:    


```r
elephants$sex <- as.factor(elephants$sex)
is.factor(elephants$sex)
```

```
## [1] TRUE
```

5. (2 points) How many male and female elephants are represented in the data?     

Number of Male and Female Elephants in the Data:   


```r
elephants %>% 
        count(sex)
```

```
## # A tibble: 2 × 2
##   sex       n
##   <fct> <int>
## 1 F       150
## 2 M       138
```

6. (2 points) What is the average age all elephants in the data?     


```r
mean(elephants$age)
```

```
## [1] 10.97132
```

7. (2 points) How does the average age and height of elephants compare by sex?    


```r
elephants %>% 
        group_by(sex) %>% 
        summarize(average_age = mean(age),
                  average_height = mean(height))
```

```
## # A tibble: 2 × 3
##   sex   average_age average_height
##   <fct>       <dbl>          <dbl>
## 1 F           12.8            190.
## 2 M            8.95           185.
```

8. (2 points) How does the average height of elephants compare by sex for individuals over 20 years old. Include the min and max height as well as the number of individuals in the sample as part of your analysis.   


```r
elephants %>% 
        filter(age > 20) %>% 
        group_by(sex) %>% 
        summarize(average_height = mean(height),
                  min_height = min(height),
                  max_height = max(height),
                  number_individuals = n())
```

```
## # A tibble: 2 × 5
##   sex   average_height min_height max_height number_individuals
##   <fct>          <dbl>      <dbl>      <dbl>              <int>
## 1 F               232.       193.       278.                 37
## 2 M               270.       229.       304.                 13
```


```r
elephants %>% 
        filter(age > 20) %>% 
        count() #number of individuals in the sample
```

```
## # A tibble: 1 × 1
##       n
##   <int>
## 1    50
```

For the next series of questions, we will use data from a study on vertebrate community composition and impacts from defaunation in [Gabon, Africa](https://en.wikipedia.org/wiki/Gabon). One thing to notice is that the data include 24 separate transects. Each transect represents a path through different forest management areas.  

Reference: Koerner SE, Poulsen JR, Blanchard EJ, Okouyi J, Clark CJ. Vertebrate community composition and diversity declines along a defaunation gradient radiating from rural villages in Gabon. _Journal of Applied Ecology_. 2016. This paper, along with a description of the variables is included inside the midterm 1 folder.  

9. (2 points) Load `IvindoData_DryadVersion.csv` and use the function(s) of your choice to get an idea of the overall structure. Change the variables `HuntCat` and `LandUse` to factors.    

Loading the data:  


```r
gabon <- read_csv("data/IvindoData_DryadVersion.csv")
```

```
## Rows: 24 Columns: 26
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr  (2): HuntCat, LandUse
## dbl (24): TransectID, Distance, NumHouseholds, Veg_Rich, Veg_Stems, Veg_lian...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```


```r
names(gabon)
```

```
##  [1] "TransectID"              "Distance"               
##  [3] "HuntCat"                 "NumHouseholds"          
##  [5] "LandUse"                 "Veg_Rich"               
##  [7] "Veg_Stems"               "Veg_liana"              
##  [9] "Veg_DBH"                 "Veg_Canopy"             
## [11] "Veg_Understory"          "RA_Apes"                
## [13] "RA_Birds"                "RA_Elephant"            
## [15] "RA_Monkeys"              "RA_Rodent"              
## [17] "RA_Ungulate"             "Rich_AllSpecies"        
## [19] "Evenness_AllSpecies"     "Diversity_AllSpecies"   
## [21] "Rich_BirdSpecies"        "Evenness_BirdSpecies"   
## [23] "Diversity_BirdSpecies"   "Rich_MammalSpecies"     
## [25] "Evenness_MammalSpecies"  "Diversity_MammalSpecies"
```


```r
gabon <- clean_names(gabon)
names(gabon)
```

```
##  [1] "transect_id"              "distance"                
##  [3] "hunt_cat"                 "num_households"          
##  [5] "land_use"                 "veg_rich"                
##  [7] "veg_stems"                "veg_liana"               
##  [9] "veg_dbh"                  "veg_canopy"              
## [11] "veg_understory"           "ra_apes"                 
## [13] "ra_birds"                 "ra_elephant"             
## [15] "ra_monkeys"               "ra_rodent"               
## [17] "ra_ungulate"              "rich_all_species"        
## [19] "evenness_all_species"     "diversity_all_species"   
## [21] "rich_bird_species"        "evenness_bird_species"   
## [23] "diversity_bird_species"   "rich_mammal_species"     
## [25] "evenness_mammal_species"  "diversity_mammal_species"
```

Changing the variables `HuntCat` and `LandUse` to factors:   


```r
gabon$hunt_cat <- as.factor(gabon$hunt_cat)
gabon$land_use <- as.factor(gabon$land_use)
is.factor(gabon$hunt_cat)
```

```
## [1] TRUE
```

```r
is.factor(gabon$land_use)
```

```
## [1] TRUE
```

10. (4 points) For the transects with high and moderate hunting intensity, how does the average diversity of birds and mammals compare?   


```r
gabon %>% 
        filter(hunt_cat == "High" | hunt_cat == "Moderate") %>% #selecting for transects with high and moderate hunting intensity
        summarize(average_diversity_birds = mean(diversity_bird_species),
                  average_diversity_mammals = mean(diversity_mammal_species))
```

```
## # A tibble: 1 × 2
##   average_diversity_birds average_diversity_mammals
##                     <dbl>                     <dbl>
## 1                    1.64                      1.71
```

11. (4 points) One of the conclusions in the study is that the relative abundance of animals drops off the closer you get to a village. Let's try to reconstruct this (without the statistics). How does the relative abundance (RA) of apes, birds, elephants, monkeys, rodents, and ungulates compare between sites that are less than 3km from a village to sites that are greater than 25km from a village? The variable `Distance` measures the distance of the transect from the nearest village. Hint: try using the `across` operator.    


```r
gabon %>% 
        filter(distance < 3) %>% 
        summarise(across(contains("ra_"), mean))
```

```
## # A tibble: 1 × 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    0.12     76.6       0.145       17.3      3.90        1.87
```


```r
gabon %>% 
        filter(distance > 25) %>% 
        summarise(across(contains("ra_"), mean))
```

```
## # A tibble: 1 × 6
##   ra_apes ra_birds ra_elephant ra_monkeys ra_rodent ra_ungulate
##     <dbl>    <dbl>       <dbl>      <dbl>     <dbl>       <dbl>
## 1    4.91     31.6           0       54.1      1.29        8.12
```

12. (4 points) Based on your interest, do one exploratory analysis on the `gabon` data of your choice. This analysis needs to include a minimum of two functions in `dplyr.`


```r
gabon %>% 
        filter(land_use == "Logging", hunt_cat == "High") %>% 
        summarize(mean_all_species = mean(diversity_all_species))
```

```
## # A tibble: 1 × 1
##   mean_all_species
##              <dbl>
## 1             2.24
```

