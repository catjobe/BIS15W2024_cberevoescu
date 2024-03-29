---
title: "Lab 3 Homework"
author: "Catrinel Berevoescu"
date: "2024-01-22"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---

## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse   

Complete. 


```r
library(tidyverse)
```

### Mammals Sleep   

#### 1. For this assignment, we are going to use built-in data on mammal sleep patterns. From which publication are these data taken from? Since the data are built-in you can use the help function in R. The name of the data is `msleep`.   

##### This data set is taken from the publication by V. M. Savage and G. B. West, A quantitative, theoretical framework for understanding mammalian sleep. Proceedings of the National Academy of Sciences, 104 (3):1051-1056, 2007.


```r
?msleep
```

#### 2. Store these data into a new data frame `sleep`.   


```r
sleep <- msleep #msleep is already a dataframe
sleep
```

```
## # A tibble: 83 × 11
##    name   genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr>  <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Cheet… Acin… carni Carn… lc                  12.1      NA        NA      11.9
##  2 Owl m… Aotus omni  Prim… <NA>                17         1.8      NA       7  
##  3 Mount… Aplo… herbi Rode… nt                  14.4       2.4      NA       9.6
##  4 Great… Blar… omni  Sori… lc                  14.9       2.3       0.133   9.1
##  5 Cow    Bos   herbi Arti… domesticated         4         0.7       0.667  20  
##  6 Three… Brad… herbi Pilo… <NA>                14.4       2.2       0.767   9.6
##  7 North… Call… carni Carn… vu                   8.7       1.4       0.383  15.3
##  8 Vespe… Calo… <NA>  Rode… <NA>                 7        NA        NA      17  
##  9 Dog    Canis carni Carn… domesticated        10.1       2.9       0.333  13.9
## 10 Roe d… Capr… herbi Arti… lc                   3        NA        NA      21  
## # ℹ 73 more rows
## # ℹ 2 more variables: brainwt <dbl>, bodywt <dbl>
```

#### 3. What are the dimensions of this data frame (variables and observations)? How do you know? Please show the *code* that you used to determine this below.   

##### The dimensions of this data frame, as shown by the dim() function below (first value states the number of observations, and the second value states the number of variables), are 83 observations (rows) and 11 variables (columns).  


```r
dim(sleep) 
```

```
## [1] 83 11
```

#### 4. Are there any NAs in the data? How did you determine this? Please show your code.   

##### There are NAs in the data, since running the function anyNA() (see below), which checks for NA values, came back with "true".  


```r
anyNA(sleep)
```

```
## [1] TRUE
```

#### 5. Show a list of the column names is this data frame.     


```r
names(sleep)
```

```
##  [1] "name"         "genus"        "vore"         "order"        "conservation"
##  [6] "sleep_total"  "sleep_rem"    "sleep_cycle"  "awake"        "brainwt"     
## [11] "bodywt"
```

#### 6. How many herbivores are represented in the data?     

##### There are 32 herbivores represented in the data:


```r
herbivore_sleep <- filter(sleep, vore == "herbi") #creating new data frame with only herbivores
nrow(herbivore_sleep) #number of rows in herbivore_sleep
```

```
## [1] 32
```

#### 7. We are interested in two groups; small and large mammals. Let's define small as less than or equal to 19kg body weight and large as greater than or equal to 200kg body weight. Make two new dataframes (large and small) based on these parameters.   

Small Mammals Data Frame:  


```r
small_mammals <- filter(sleep, bodywt <= 19)
small_mammals
```

```
## # A tibble: 59 × 11
##    name   genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##    <chr>  <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
##  1 Owl m… Aotus omni  Prim… <NA>                17         1.8      NA       7  
##  2 Mount… Aplo… herbi Rode… nt                  14.4       2.4      NA       9.6
##  3 Great… Blar… omni  Sori… lc                  14.9       2.3       0.133   9.1
##  4 Three… Brad… herbi Pilo… <NA>                14.4       2.2       0.767   9.6
##  5 Vespe… Calo… <NA>  Rode… <NA>                 7        NA        NA      17  
##  6 Dog    Canis carni Carn… domesticated        10.1       2.9       0.333  13.9
##  7 Roe d… Capr… herbi Arti… lc                   3        NA        NA      21  
##  8 Guine… Cavis herbi Rode… domesticated         9.4       0.8       0.217  14.6
##  9 Grivet Cerc… omni  Prim… lc                  10         0.7      NA      14  
## 10 Chinc… Chin… herbi Rode… domesticated        12.5       1.5       0.117  11.5
## # ℹ 49 more rows
## # ℹ 2 more variables: brainwt <dbl>, bodywt <dbl>
```

Large Mammals Data Frame:  


```r
large_mammals <- filter(sleep, bodywt >= 200)
large_mammals
```

```
## # A tibble: 7 × 11
##   name    genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr>   <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Cow     Bos   herbi Arti… domesticated         4         0.7       0.667  20  
## 2 Asian … Elep… herbi Prob… en                   3.9      NA        NA      20.1
## 3 Horse   Equus herbi Peri… domesticated         2.9       0.6       1      21.1
## 4 Giraffe Gira… herbi Arti… cd                   1.9       0.4      NA      22.1
## 5 Pilot … Glob… carni Ceta… cd                   2.7       0.1      NA      21.4
## 6 Africa… Loxo… herbi Prob… vu                   3.3      NA        NA      20.7
## 7 Brazil… Tapi… herbi Peri… vu                   4.4       1         0.9    19.6
## # ℹ 2 more variables: brainwt <dbl>, bodywt <dbl>
```

#### 8. What is the mean weight for both the small and large mammals?   

Mean Weight for Small Mammals:  


```r
mean(small_mammals$bodywt)
```

```
## [1] 1.797847
```

Mean Weight for Large Mammals:  


```r
mean(large_mammals$bodywt)
```

```
## [1] 1747.071
```

##### The mean weight for small mammals is 1.797847 kg, and the mean weight for large mammals is 1747.071 kg.

#### 9. Using a similar approach as above, do large or small animals sleep longer on average?   

Mean Sleep Time for Small Mammals:  


```r
mean_sleep_small_mammals <- mean(small_mammals$sleep_total) #finding mean of sleep_total column for small_mammal data frame
mean_sleep_small_mammals
```

```
## [1] 11.78644
```

Mean Sleep Time for Large Mammals:  


```r
mean_sleep_large_mammals <- mean(large_mammals$sleep_total) #finding mean of sleep_total column for large_mammal data frame
mean_sleep_large_mammals
```

```
## [1] 3.3
```


```r
mean_sleep_large_mammals <= mean_sleep_small_mammals #showing that mean sleep time for small mammals is larger than the sleep time for large mammals
```

```
## [1] TRUE
```

##### Since the mean sleep time for small mammals is 11.78644 hours and the mean sleep time for large mammals is 3.3 hours, this means that small animals sleep longer on average.  

#### 10. Which animal is the sleepiest among the entire dataframe?

To find the sleepiest animal, I am looking for the animal who has the largest sleep_total value:  


```r
summary(sleep$sleep_total)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    1.90    7.85   10.10   10.43   13.75   19.90
```

The sleepiest animal slept for 19.90 hours (the max value).  


```r
sleepiest <- filter(sleep, sleep_total == 19.90)
sleepiest
```

```
## # A tibble: 1 × 11
##   name    genus vore  order conservation sleep_total sleep_rem sleep_cycle awake
##   <chr>   <chr> <chr> <chr> <chr>              <dbl>     <dbl>       <dbl> <dbl>
## 1 Little… Myot… inse… Chir… <NA>                19.9         2         0.2   4.1
## # ℹ 2 more variables: brainwt <dbl>, bodywt <dbl>
```

```r
sleepiest$name
```

```
## [1] "Little brown bat"
```

##### Therefore, the sleepiest animal, which has a sleep_total of 19.9 hours, is the little brown bat.  

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
