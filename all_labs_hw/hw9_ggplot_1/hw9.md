---
title: "Homework 9"
author: "Catrinel Berevoescu"
date: "2024-02-15"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions    

Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries    


```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```

For this homework, we will take a departure from biological data and use data about California colleges. These data are a subset of the national college scorecard (https://collegescorecard.ed.gov/data/). Load the `ca_college_data.csv` as a new object called `colleges`.    


```r
colleges <- read_csv("data/ca_college_data.csv") %>% clean_names()
```

```
## Rows: 341 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (4): INSTNM, CITY, STABBR, ZIP
## dbl (6): ADM_RATE, SAT_AVG, PCIP26, COSTT4_A, C150_4_POOLED, PFTFTUG1_EF
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```
The variables are a bit hard to decipher, here is a key:  

INSTNM: Institution name  
CITY: California city  
STABBR: Location state  
ZIP: Zip code  
ADM_RATE: Admission rate  
SAT_AVG: SAT average score  
PCIP26: Percentage of degrees awarded in Biological And Biomedical Sciences  
COSTT4_A: Annual cost of attendance  
C150_4_POOLED: 4-year completion rate  
PFTFTUG1_EF: Percentage of undergraduate students who are first-time, full-time degree/certificate-seeking undergraduate students  

### 1. Use your preferred function(s) to have a look at the data and get an idea of its structure. Make sure you summarize NA's and determine whether or not the data are tidy. You may also consider dealing with any naming issues.    

#### Looking at the data to get an idea of its structure:    


```r
glimpse(colleges)
```

```
## Rows: 341
## Columns: 10
## $ instnm        <chr> "Grossmont College", "College of the Sequoias", "College…
## $ city          <chr> "El Cajon", "Visalia", "San Mateo", "Ventura", "Oxnard",…
## $ stabbr        <chr> "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "CA", "C…
## $ zip           <chr> "92020-1799", "93277-2214", "94402-3784", "93003-3872", …
## $ adm_rate      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ sat_avg       <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ pcip26        <dbl> 0.0016, 0.0066, 0.0038, 0.0035, 0.0085, 0.0151, 0.0000, …
## $ costt4_a      <dbl> 7956, 8109, 8278, 8407, 8516, 8577, 8580, 9181, 9281, 93…
## $ c150_4_pooled <dbl> NA, NA, NA, NA, NA, NA, 0.2334, NA, NA, NA, NA, 0.1704, …
## $ pftftug1_ef   <dbl> 0.3546, 0.5413, 0.3567, 0.3824, 0.2753, 0.4286, 0.2307, …
```

#### Summarizing NA's:    


```r
miss_var_summary(colleges)
```

```
## # A tibble: 10 × 3
##    variable      n_miss pct_miss
##    <chr>          <int>    <dbl>
##  1 sat_avg          276     80.9
##  2 adm_rate         240     70.4
##  3 c150_4_pooled    221     64.8
##  4 costt4_a         124     36.4
##  5 pftftug1_ef       53     15.5
##  6 pcip26            35     10.3
##  7 instnm             0      0  
##  8 city               0      0  
##  9 stabbr             0      0  
## 10 zip                0      0
```

#### Determining if the data is tidy:    

#### Since the variables have their own columns, each observation has its own row , and each value has its own cell. the data appears to be tidy.     


```r
colleges
```

```
## # A tibble: 341 × 10
##    instnm      city  stabbr zip   adm_rate sat_avg pcip26 costt4_a c150_4_pooled
##    <chr>       <chr> <chr>  <chr>    <dbl>   <dbl>  <dbl>    <dbl>         <dbl>
##  1 Grossmont … El C… CA     9202…       NA      NA 0.0016     7956        NA    
##  2 College of… Visa… CA     9327…       NA      NA 0.0066     8109        NA    
##  3 College of… San … CA     9440…       NA      NA 0.0038     8278        NA    
##  4 Ventura Co… Vent… CA     9300…       NA      NA 0.0035     8407        NA    
##  5 Oxnard Col… Oxna… CA     9303…       NA      NA 0.0085     8516        NA    
##  6 Moorpark C… Moor… CA     9302…       NA      NA 0.0151     8577        NA    
##  7 Skyline Co… San … CA     9406…       NA      NA 0          8580         0.233
##  8 Glendale C… Glen… CA     9120…       NA      NA 0.002      9181        NA    
##  9 Citrus Col… Glen… CA     9174…       NA      NA 0.0021     9281        NA    
## 10 Fresno Cit… Fres… CA     93741       NA      NA 0.0324     9370        NA    
## # ℹ 331 more rows
## # ℹ 1 more variable: pftftug1_ef <dbl>
```

#### 2. Which cities in California have the highest number of colleges?    


```r
colleges %>% 
  group_by(city) %>% 
  summarise(number_colleges = n()) %>% 
  arrange(desc(number_colleges))
```

```
## # A tibble: 161 × 2
##    city          number_colleges
##    <chr>                   <int>
##  1 Los Angeles                24
##  2 San Diego                  18
##  3 San Francisco              15
##  4 Sacramento                 10
##  5 Berkeley                    9
##  6 Oakland                     9
##  7 Claremont                   7
##  8 Pasadena                    6
##  9 Fresno                      5
## 10 Irvine                      5
## # ℹ 151 more rows
```

#### The cities with the highest numbers of colleges include Los Angeles (24), San Diego (18), and San Francisco (15).       

### 3. Based on your answer to #2, make a plot that shows the number of colleges in the top 10 cities.    


```r
colleges %>% 
  group_by(city) %>% 
  summarise(number_colleges = n()) %>% 
  arrange(desc(number_colleges)) %>% 
  top_n(10, number_colleges) %>% 
  ggplot(aes(x = city, y = number_colleges)) +
  geom_col() +
  coord_flip()
```

![](hw9_files/figure-html/unnamed-chunk-7-1.png)<!-- -->

### 4. The column `COSTT4_A` is the annual cost of each institution. Which city has the highest average cost? Where is it located?   


```r
colleges %>% 
  group_by(city) %>% 
  summarise(average_cost = mean(costt4_a, na.rm = T)) %>% 
  arrange(desc(average_cost))
```

```
## # A tibble: 161 × 2
##    city                average_cost
##    <chr>                      <dbl>
##  1 Claremont                  66498
##  2 Malibu                     66152
##  3 Valencia                   64686
##  4 Orange                     64501
##  5 Redlands                   61542
##  6 Moraga                     61095
##  7 Atherton                   56035
##  8 Thousand Oaks              54373
##  9 Rancho Palos Verdes        50758
## 10 La Verne                   50603
## # ℹ 151 more rows
```


```r
colleges %>% 
  filter(city == "Claremont")
```

```
## # A tibble: 7 × 10
##   instnm      city  stabbr zip   adm_rate sat_avg  pcip26 costt4_a c150_4_pooled
##   <chr>       <chr> <chr>  <chr>    <dbl>   <dbl>   <dbl>    <dbl>         <dbl>
## 1 Pomona Col… Clar… CA     9171…   0.0944    1442  0.171     64870         0.957
## 2 Pitzer Col… Clar… CA     9171…   0.137       NA  0.0888    65880         0.888
## 3 Scripps Co… Clar… CA     9171…   0.299     1353  0.152     66060         0.871
## 4 Claremont … Clar… CA     9171…   0.0944    1413  0.0681    66325         0.924
## 5 Harvey Mud… Clar… CA     91711   0.129     1496  0.0674    69355         0.925
## 6 Claremont … Clar… CA     9171…  NA           NA NA            NA        NA    
## 7 Claremont … Clar… CA     9171…  NA           NA NA            NA        NA    
## # ℹ 1 more variable: pftftug1_ef <dbl>
```

#### Thus, the city with the highest average cost is Claremont with an average annual cost of $66498.00. It is located in California.   

### 5. Based on your answer to #4, make a plot that compares the cost of the individual colleges in the most expensive city. Bonus! Add UC Davis here to see how it compares :>).   


```r
colleges %>% 
  filter(city == "Claremont" | instnm == "University of California-Davis") %>% 
  ggplot(aes(x = instnm, y = costt4_a)) +
  geom_col() +
  coord_flip()
```

```
## Warning: Removed 2 rows containing missing values (`position_stack()`).
```

![](hw9_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

#### It appears, from the available data, that UC Davis has an annual cost that is almost half that of any of the colleges in the most expensive city, Claremont, CA.    

### 6. The column `ADM_RATE` is the admissions rate by college and `C150_4_POOLED` is the four-year completion rate. Use a scatterplot to show the relationship between these two variables. What do you think this means?    


```r
colleges %>% 
  ggplot(aes(y = c150_4_pooled, x = adm_rate)) +
  geom_point() + 
  geom_smooth(method = lm, se = T, na.rm = T)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning: Removed 251 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

#### This plot appears to show that the higher the admission rate, the LOWER the four-year completion rate.

### 7. Is there a relationship between cost and four-year completion rate? (You don't need to do the stats, just produce a plot). What do you think this means?    


```r
colleges %>% 
  ggplot(aes(x = costt4_a, y = c150_4_pooled)) +
  geom_point() +
  geom_smooth(method = lm, se = T, na.rm = T)
```

```
## `geom_smooth()` using formula = 'y ~ x'
```

```
## Warning: Removed 225 rows containing missing values (`geom_point()`).
```

![](hw9_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

#### This appears to show that the more expensive the school (annual cost), the LARGER the four-year completion rate.    

### 8. The column titled `INSTNM` is the institution name. We are only interested in the University of California colleges. Make a new data frame that is restricted to UC institutions. You can remove `Hastings College of Law` and `UC San Francisco` as we are only interested in undergraduate institutions.



```r
#uc_colleges <- colleges %>% 
  #filter(instnm == "University of California - ")
#uc_colleges
```

Remove `Hastings College of Law` and `UC San Francisco` and store the final data frame as a new object `univ_calif_final`.

Use `separate()` to separate institution name into two new columns "UNIV" and "CAMPUS".


### 9. The column `ADM_RATE` is the admissions rate by campus. Which UC has the lowest and highest admissions rates? Produce a numerical summary and an appropriate plot.

### 10. If you wanted to get a degree in biological or biomedical sciences, which campus confers the majority of these degrees? Produce a numerical summary and an appropriate plot.

## Knit Your Output and Post to [GitHub](https://github.com/FRS417-DataScienceBiologists)
