---
title: "HW: dplyr Superhero"
author: "Catrinel Berevoescu"
date: "2024-02-01"
output:
  html_document: 
    theme: spacelab
    toc: true
    toc_float: true
    keep_md: true
---

## Learning Goals  

*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions   

For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries    


```r
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

## Load the superhero data   

These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.   


```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Data tidy.   

#### 1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    


```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```


```r
superhero_info <- clean_names(superhero_info)
superhero_powers <- clean_names(superhero_powers)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  


```r
tabyl(superhero_info, alignment)
```

```
##  alignment   n     percent valid_percent
##        bad 207 0.282016349    0.28473177
##       good 496 0.675749319    0.68225585
##    neutral  24 0.032697548    0.03301238
##       <NA>   7 0.009536785            NA
```

#### 1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

Publishers of the Superheroes:   


```r
table(superhero_info$publisher)
```

```
## 
##       ABC Studios Dark Horse Comics         DC Comics      George Lucas 
##                 4                18               215                14 
##     Hanna-Barbera     HarperCollins       Icon Comics    IDW Publishing 
##                 1                 6                 4                 4 
##      Image Comics     J. K. Rowling  J. R. R. Tolkien     Marvel Comics 
##                14                 1                 1               388 
##         Microsoft      NBC - Heroes         Rebellion          Shueisha 
##                 1                19                 1                 4 
##     Sony Pictures        South Park         Star Trek              SyFy 
##                 2                 1                 6                 5 
##      Team Epic TV       Titan Books Universal Studios         Wildstorm 
##                 5                 1                 1                 3
```

Proportions of Superheroes from each Publisher:   


```r
superhero_info %>% 
        tabyl(publisher) %>% 
        arrange(desc(n))
```

```
##          publisher   n     percent valid_percent
##      Marvel Comics 388 0.528610354   0.539638387
##          DC Comics 215 0.292915531   0.299026426
##       NBC - Heroes  19 0.025885559   0.026425591
##  Dark Horse Comics  18 0.024523161   0.025034771
##               <NA>  15 0.020435967            NA
##       George Lucas  14 0.019073569   0.019471488
##       Image Comics  14 0.019073569   0.019471488
##      HarperCollins   6 0.008174387   0.008344924
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        ABC Studios   4 0.005449591   0.005563282
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##           Shueisha   4 0.005449591   0.005563282
##          Wildstorm   3 0.004087193   0.004172462
##      Sony Pictures   2 0.002724796   0.002781641
##      Hanna-Barbera   1 0.001362398   0.001390821
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##          Microsoft   1 0.001362398   0.001390821
##          Rebellion   1 0.001362398   0.001390821
##         South Park   1 0.001362398   0.001390821
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
```

##### The publishers of the superheroes are shown above (24 total). The publisher with the highest number of superheroes appears to be Marvel comics with 388 superheroes.    

#### 2. Notice that we have some neutral superheros! Who are they? List their names below.  


```r
neutral_superheroes <- superhero_info %>% 
  select(name, alignment) %>% 
  filter(alignment == "neutral") #filtering for neutral superheroes
neutral_superheroes
```

```
## # A tibble: 24 × 2
##    name         alignment
##    <chr>        <chr>    
##  1 Bizarro      neutral  
##  2 Black Flash  neutral  
##  3 Captain Cold neutral  
##  4 Copycat      neutral  
##  5 Deadpool     neutral  
##  6 Deathstroke  neutral  
##  7 Etrigan      neutral  
##  8 Galactus     neutral  
##  9 Gladiator    neutral  
## 10 Indigo       neutral  
## # ℹ 14 more rows
```

List of Neutral Superheroes:   


```r
tabyl(neutral_superheroes, name) 
```

```
##             name n    percent
##          Bizarro 1 0.04166667
##      Black Flash 1 0.04166667
##     Captain Cold 1 0.04166667
##          Copycat 1 0.04166667
##         Deadpool 1 0.04166667
##      Deathstroke 1 0.04166667
##          Etrigan 1 0.04166667
##         Galactus 1 0.04166667
##        Gladiator 1 0.04166667
##           Indigo 1 0.04166667
##       Juggernaut 1 0.04166667
##  Living Tribunal 1 0.04166667
##             Lobo 1 0.04166667
##          Man-Bat 1 0.04166667
##    One-Above-All 1 0.04166667
##            Raven 1 0.04166667
##         Red Hood 1 0.04166667
##         Red Hulk 1 0.04166667
##         Robin VI 1 0.04166667
##          Sandman 1 0.04166667
##           Sentry 1 0.04166667
##         Sinestro 1 0.04166667
##     The Comedian 1 0.04166667
##             Toad 1 0.04166667
```

##### There are 24 neutral superheroes represented in the superhero_info data frame.    

## `superhero_info`   

#### 3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?    

I selected the three desired variables name, alignment, and "race" with the select() function.


```r
superhero_info %>% 
  select(name, alignment, race) #isolating desired variables with the select() function
```

```
## # A tibble: 734 × 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ℹ 724 more rows
```

## Not Human    

#### 4. List all of the superheros that are not human.    


```r
nonhuman_superheroes <- superhero_info %>% 
        filter(race != "Human") #defining superheroes as human only if their "race" is described exclusively as "human"
nonhuman_superheroes
```

```
## # A tibble: 222 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  2 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  3 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  4 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  7 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  8 Angel Male   <NA>      Vamp… <NA>           NA Dark Hor… <NA>       good     
##  9 Ange… Female yellow    Muta… Black         165 Marvel C… <NA>       good     
## 10 Anti… Male   yellow    God … No Hair        61 DC Comics <NA>       bad      
## # ℹ 212 more rows
## # ℹ 1 more variable: weight <dbl>
```

For ease of viewing:    


```r
nonhuman_superheroes <- superhero_info %>% 
        select(name, race) %>% 
        filter(race != "Human") #defining superheroes as human only if their "race" is described exclusively as "human"
nonhuman_superheroes
```

```
## # A tibble: 222 × 2
##    name         race             
##    <chr>        <chr>            
##  1 Abe Sapien   Icthyo Sapien    
##  2 Abin Sur     Ungaran          
##  3 Abomination  Human / Radiation
##  4 Abraxas      Cosmic Entity    
##  5 Ajax         Cyborg           
##  6 Alien        Xenomorph XX121  
##  7 Amazo        Android          
##  8 Angel        Vampire          
##  9 Angel Dust   Mutant           
## 10 Anti-Monitor God / Eternal    
## # ℹ 212 more rows
```

Listing the Superheroes that are Not Human:    


```r
tabyl(nonhuman_superheroes, name)
```

```
##                       name n     percent
##                 Abe Sapien 1 0.004504505
##                   Abin Sur 1 0.004504505
##                Abomination 1 0.004504505
##                    Abraxas 1 0.004504505
##                       Ajax 1 0.004504505
##                      Alien 1 0.004504505
##                      Amazo 1 0.004504505
##                      Angel 1 0.004504505
##                 Angel Dust 1 0.004504505
##               Anti-Monitor 1 0.004504505
##                 Anti-Venom 1 0.004504505
##                 Apocalypse 1 0.004504505
##                    Aqualad 1 0.004504505
##                    Aquaman 1 0.004504505
##                  Archangel 1 0.004504505
##                     Ardina 1 0.004504505
##                      Atlas 2 0.009009009
##                     Aurora 1 0.004504505
##                     Azazel 1 0.004504505
##                      Beast 1 0.004504505
##                   Beyonder 1 0.004504505
##                  Big Barda 1 0.004504505
##                Bill Harken 1 0.004504505
##               Bionic Woman 1 0.004504505
##                    Birdman 1 0.004504505
##                     Bishop 1 0.004504505
##                    Bizarro 1 0.004504505
##                 Black Bolt 1 0.004504505
##               Black Canary 1 0.004504505
##                Black Flash 1 0.004504505
##                   Blackout 1 0.004504505
##                  Blackwulf 1 0.004504505
##                      Blade 1 0.004504505
##                      Blink 1 0.004504505
##                  Bloodhawk 1 0.004504505
##                  Boba Fett 1 0.004504505
##                  Boom-Boom 1 0.004504505
##                   Brainiac 1 0.004504505
##                 Brundlefly 1 0.004504505
##                      Cable 1 0.004504505
##              Cameron Hicks 1 0.004504505
##               Captain Atom 1 0.004504505
##             Captain Marvel 1 0.004504505
##             Captain Planet 1 0.004504505
##           Captain Universe 1 0.004504505
##                    Carnage 1 0.004504505
##                    Century 1 0.004504505
##                    Cerebra 1 0.004504505
##                    Chamber 1 0.004504505
##                   Colossus 1 0.004504505
##                    Copycat 1 0.004504505
##                    Crystal 1 0.004504505
##                     Cyborg 1 0.004504505
##            Cyborg Superman 1 0.004504505
##                    Cyclops 1 0.004504505
##                   Darkseid 1 0.004504505
##                   Darkstar 1 0.004504505
##                 Darth Maul 1 0.004504505
##                Darth Vader 1 0.004504505
##                       Data 1 0.004504505
##                    Dazzler 1 0.004504505
##                   Deadpool 1 0.004504505
##                   Deathlok 1 0.004504505
##                 Demogoblin 1 0.004504505
##                 Doc Samson 1 0.004504505
##                  Donatello 1 0.004504505
##                 Donna Troy 1 0.004504505
##                   Doomsday 1 0.004504505
##               Dr Manhattan 1 0.004504505
##         Drax the Destroyer 1 0.004504505
##                    Etrigan 1 0.004504505
##              Evil Deadpool 1 0.004504505
##                   Evilhawk 1 0.004504505
##                     Exodus 1 0.004504505
##                      Faora 1 0.004504505
##              Fin Fang Foom 1 0.004504505
##                   Firestar 1 0.004504505
##          Franklin Richards 1 0.004504505
##                   Galactus 1 0.004504505
##                     Gambit 1 0.004504505
##                     Gamora 1 0.004504505
##                Garbage Man 1 0.004504505
##                  Gary Bell 1 0.004504505
##                General Zod 1 0.004504505
##                Ghost Rider 1 0.004504505
##                  Gladiator 1 0.004504505
##                   Godzilla 1 0.004504505
##                       Goku 1 0.004504505
##              Gorilla Grodd 1 0.004504505
##                     Greedo 1 0.004504505
##                      Groot 1 0.004504505
##                Guy Gardner 1 0.004504505
##                      Havok 1 0.004504505
##                       Hela 1 0.004504505
##                    Hellboy 1 0.004504505
##                   Hercules 1 0.004504505
##                       Hulk 1 0.004504505
##                Human Torch 1 0.004504505
##                       Husk 1 0.004504505
##                     Hybrid 1 0.004504505
##                   Hyperion 1 0.004504505
##                     Iceman 1 0.004504505
##                     Indigo 1 0.004504505
##                        Ink 1 0.004504505
##            Invisible Woman 1 0.004504505
##              Jar Jar Binks 1 0.004504505
##                  Jean Grey 1 0.004504505
##                    Jubilee 1 0.004504505
##                   Junkpile 1 0.004504505
##                      K-2SO 1 0.004504505
##                Killer Croc 1 0.004504505
##                    Kilowog 1 0.004504505
##                  King Kong 1 0.004504505
##                 King Shark 1 0.004504505
##                     Krypto 1 0.004504505
##           Lady Deathstrike 1 0.004504505
##                     Legion 1 0.004504505
##                   Leonardo 1 0.004504505
##            Living Tribunal 1 0.004504505
##                       Lobo 1 0.004504505
##                       Loki 1 0.004504505
##                      MODOK 1 0.004504505
##                    Magneto 1 0.004504505
##            Man of Miracles 1 0.004504505
##                     Mantis 1 0.004504505
##          Martian Manhunter 1 0.004504505
##               Master Chief 1 0.004504505
##                     Medusa 1 0.004504505
##                       Mera 1 0.004504505
##                    Metallo 1 0.004504505
##               Michelangelo 1 0.004504505
##           Mister Fantastic 1 0.004504505
##               Mister Knife 1 0.004504505
##            Mister Mxyzptlk 1 0.004504505
##            Mister Sinister 1 0.004504505
##                       Mogo 1 0.004504505
##                Mr Immortal 1 0.004504505
##                   Mystique 1 0.004504505
##                      Namor 1 0.004504505
##                     Nebula 1 0.004504505
##  Negasonic Teenage Warhead 1 0.004504505
##               Nina Theroux 1 0.004504505
##                       Nova 1 0.004504505
##                       Odin 1 0.004504505
##              One-Above-All 1 0.004504505
##                  Onslaught 1 0.004504505
##                  Parademon 1 0.004504505
##                    Phoenix 1 0.004504505
##                   Plantman 1 0.004504505
##                    Polaris 1 0.004504505
##                 Power Girl 1 0.004504505
##                  Power Man 1 0.004504505
##                   Predator 1 0.004504505
##                Professor X 1 0.004504505
##                   Psylocke 1 0.004504505
##                          Q 1 0.004504505
##                Quicksilver 1 0.004504505
##              Rachel Pirzad 1 0.004504505
##                    Raphael 1 0.004504505
##                   Red Hulk 1 0.004504505
##                Red Tornado 1 0.004504505
##                      Rhino 1 0.004504505
##             Rocket Raccoon 1 0.004504505
##                 Sabretooth 1 0.004504505
##                     Sauron 1 0.004504505
##          Scarlet Spider II 1 0.004504505
##              Scarlet Witch 1 0.004504505
##             Sebastian Shaw 1 0.004504505
##                     Sentry 1 0.004504505
##                Shadow Lass 1 0.004504505
##                  Shadowcat 1 0.004504505
##                  She-Thing 1 0.004504505
##                        Sif 1 0.004504505
##              Silver Surfer 1 0.004504505
##                   Sinestro 1 0.004504505
##                      Siren 1 0.004504505
##                 Snake-Eyes 1 0.004504505
##             Solomon Grundy 1 0.004504505
##                      Spawn 1 0.004504505
##                    Spectre 1 0.004504505
##             Spider-Carnage 1 0.004504505
##                      Spock 1 0.004504505
##                      Spyke 1 0.004504505
##                  Star-Lord 1 0.004504505
##                   Starfire 1 0.004504505
##                     Static 1 0.004504505
##                Steppenwolf 1 0.004504505
##                      Storm 1 0.004504505
##                    Sunspot 1 0.004504505
##             Superboy-Prime 1 0.004504505
##                  Supergirl 1 0.004504505
##                   Superman 1 0.004504505
##                Swamp Thing 1 0.004504505
##                      Swarm 1 0.004504505
##                     T-1000 1 0.004504505
##                      T-800 1 0.004504505
##                      T-850 1 0.004504505
##                        T-X 1 0.004504505
##                     Thanos 1 0.004504505
##                      Thing 1 0.004504505
##                       Thor 1 0.004504505
##                  Thor Girl 1 0.004504505
##                       Toad 1 0.004504505
##                      Toxin 2 0.009009009
##                     Trigon 1 0.004504505
##                     Triton 1 0.004504505
##                     Ultron 1 0.004504505
##                Utgard-Loki 1 0.004504505
##                     Vegeta 1 0.004504505
##                      Venom 1 0.004504505
##                  Venom III 1 0.004504505
##                  Venompool 1 0.004504505
##                     Vision 1 0.004504505
##                    Warpath 1 0.004504505
##                  Wolverine 1 0.004504505
##                Wonder Girl 1 0.004504505
##               Wonder Woman 1 0.004504505
##                       X-23 1 0.004504505
##                       Ymir 1 0.004504505
##                       Yoda 1 0.004504505
```

## Good and Evil   

#### 5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".    

Good Guys Data Frame:   


```r
good_guys <- filter(superhero_info, alignment == "good")
good_guys
```

```
## # A tibble: 496 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  5 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  6 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
##  7 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
##  8 Agen… Male   <NA>      <NA>  <NA>          191 Marvel C… <NA>       good     
##  9 Alan… Male   blue      <NA>  Blond         180 DC Comics <NA>       good     
## 10 Alex… Male   <NA>      <NA>  <NA>           NA NBC - He… <NA>       good     
## # ℹ 486 more rows
## # ℹ 1 more variable: weight <dbl>
```

Bad Guys Data Frame:   


```r
bad_guys <- filter(superhero_info, alignment == "bad")
bad_guys
```

```
## # A tibble: 207 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  2 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  3 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  4 Air-… Male   blue      <NA>  White         188 Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alex… Male   <NA>      Human <NA>           NA Wildstorm <NA>       bad      
##  7 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  8 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  9 Ammo  Male   brown     Human Black         188 Marvel C… <NA>       bad      
## 10 Ange… Female <NA>      <NA>  <NA>           NA Image Co… <NA>       bad      
## # ℹ 197 more rows
## # ℹ 1 more variable: weight <dbl>
```

#### 6. For the good guys, use the `tabyl` function to summarize their "race".    


```r
tabyl(good_guys, race) #summarizing the good guys data frame by "race"
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```


#### 7. Among the good guys, Who are the Vampires?    


```r
filter(good_guys, race == "Vampire")
```

```
## # A tibble: 2 × 10
##   name  gender eye_color race   hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr>  <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Angel Male   <NA>      Vampi… <NA>           NA Dark Hor… <NA>       good     
## 2 Blade Male   brown     Vampi… Black         188 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

##### The Vampires among the good guys are Angel and Blade.    

#### 8. Among the bad guys, who are the male humans over 200 inches in height?    


```r
bad_guys %>% 
  filter(race == "Human", gender == "Male", height > 200) #selecting male humans over 200 inches in height
```

```
## # A tibble: 5 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Bane   Male   <NA>      Human <NA>          203 DC Comics <NA>       bad      
## 2 Docto… Male   brown     Human Brown         201 Marvel C… <NA>       bad      
## 3 Kingp… Male   blue      Human No Hair       201 Marvel C… <NA>       bad      
## 4 Lizard Male   red       Human No Hair       203 Marvel C… <NA>       bad      
## 5 Scorp… Male   brown     Human Brown         211 Marvel C… <NA>       bad      
## # ℹ 1 more variable: weight <dbl>
```

##### Among the bad guys, the male humans over 200 inches in height are Bane, Doctor Doom, Kingpin, Lizard, and Scorpion.    

#### 9. Are there more good guys or bad guys with green hair?    

Good Guys with Green Hair:   


```r
good_guys %>% 
  filter(hair_color == "Green")
```

```
## # A tibble: 7 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Beast… Male   green     Human Green         173 DC Comics green      good     
## 2 Capta… Male   red       God … Green          NA Marvel C… <NA>       good     
## 3 Doc S… Male   blue      Huma… Green         198 Marvel C… <NA>       good     
## 4 Hulk   Male   green     Huma… Green         244 Marvel C… green      good     
## 5 Lyja   Female green     <NA>  Green          NA Marvel C… <NA>       good     
## 6 Polar… Female green     Muta… Green         170 Marvel C… <NA>       good     
## 7 She-H… Female green     Human Green         201 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```


```r
good_guys %>% 
        filter(hair_color == "Green") %>% 
        dim()
```

```
## [1]  7 10
```

Bad Guys with Green Hair:    


```r
bad_guys %>% 
  filter(hair_color == "Green")
```

```
## # A tibble: 1 × 10
##   name  gender eye_color race  hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Joker Male   green     Human Green         196 DC Comics white      bad      
## # ℹ 1 more variable: weight <dbl>
```


```r
bad_guys %>% 
        filter(hair_color == "Green") %>% 
        dim()
```

```
## [1]  1 10
```

##### Since there are 7 good guys with green hair, and only 1 bad guy with green hair, there are more good guys with green hair.    

#### 10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  


```r
superhero_info %>% #searching within the superhero_info data frame
  filter(weight < 50) %>% #filtering for superheroes that weigh less than 50
  arrange(weight) #arranging the results from lowest to highest weight
```

```
## # A tibble: 19 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Iron… Male   blue      <NA>  No Hair        NA Marvel C… <NA>       bad      
##  2 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  3 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  4 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  5 Yoda  Male   brown     Yoda… White          66 George L… green      good     
##  6 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  7 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  8 Kryp… Male   blue      Kryp… White          64 DC Comics <NA>       good     
##  9 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
## 10 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
## 11 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
## 12 Robi… Male   blue      Human Black         137 DC Comics <NA>       good     
## 13 Wiz … <NA>   brown     <NA>  Black         140 Marvel C… <NA>       good     
## 14 Viol… Female violet    Human Black         137 Dark Hor… <NA>       good     
## 15 Fran… Male   blue      Muta… Blond         142 Marvel C… <NA>       good     
## 16 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 17 Hope… Female green     <NA>  Red           168 Marvel C… <NA>       good     
## 18 Jolt  Female blue      <NA>  Black         165 Marvel C… <NA>       good     
## 19 Snow… Female white     <NA>  Blond         178 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

For ease of viewing, I have selected only the `name` and `weight` variables below:    


```r
superhero_info %>% #searching within the superhero_info data frame
        filter(weight < 50) %>% #filtering for superheroes that weigh less than 50 
        select(name, weight) %>% #selecting only the variables name and weight
        arrange(weight) #arranging the results from lowest to highest weight
```

```
## # A tibble: 19 × 2
##    name              weight
##    <chr>              <dbl>
##  1 Iron Monger            2
##  2 Groot                  4
##  3 Jack-Jack             14
##  4 Galactus              16
##  5 Yoda                  17
##  6 Fin Fang Foom         18
##  7 Howard the Duck       18
##  8 Krypto                18
##  9 Rocket Raccoon        25
## 10 Dash                  27
## 11 Longshot              36
## 12 Robin V               38
## 13 Wiz Kid               39
## 14 Violet Parr           41
## 15 Franklin Richards     45
## 16 Swarm                 47
## 17 Hope Summers          48
## 18 Jolt                  49
## 19 Snowbird              49
```

#### 11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.     


```r
superhero_info %>% 
        mutate(height_weight_ratio = height / weight) #adding a new column with the height to weight ratio
```

```
## # A tibble: 734 × 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  5 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  6 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  7 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  8 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  9 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
## 10 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
## # ℹ 724 more rows
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```

For a more clear visual of the `height_weight_ratio` variable:    


```r
superhero_info %>% 
        mutate(height_weight_ratio = height / weight) %>% 
        select(name, height_weight_ratio)
```

```
## # A tibble: 734 × 2
##    name          height_weight_ratio
##    <chr>                       <dbl>
##  1 A-Bomb                      0.460
##  2 Abe Sapien                  2.94 
##  3 Abin Sur                    2.06 
##  4 Abomination                 0.460
##  5 Abraxas                    NA    
##  6 Absorbing Man               1.58 
##  7 Adam Monroe                NA    
##  8 Adam Strange                2.10 
##  9 Agent 13                    2.84 
## 10 Agent Bob                   2.20 
## # ℹ 724 more rows
```

#### 12. Who has the highest height to weight ratio?  


```r
superhero_info %>% 
        mutate(height_weight_ratio = height / weight) %>% 
        arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  2 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  3 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  4 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
##  5 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  6 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
##  7 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
##  8 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  9 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 10 Yoda  Male   brown     Yoda… White          66 George L… green      good     
## # ℹ 724 more rows
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```

For ease of viewing, I have selected only the `name` and `height_weight_ratio` variables below:   


```r
superhero_info %>% 
        mutate(height_weight_ratio = height / weight) %>% 
        select(name, height_weight_ratio) %>% 
        arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 2
##    name            height_weight_ratio
##    <chr>                         <dbl>
##  1 Groot                        175.  
##  2 Galactus                      54.8 
##  3 Fin Fang Foom                 54.2 
##  4 Longshot                       5.22
##  5 Jack-Jack                      5.07
##  6 Rocket Raccoon                 4.88
##  7 Dash                           4.52
##  8 Howard the Duck                4.39
##  9 Swarm                          4.17
## 10 Yoda                           3.88
## # ℹ 724 more rows
```

##### Thus, the superhero with the highest height to weight ratio is Groot (175.25000000).   

## `superhero_powers`    

Have a quick look at the `superhero_powers` data frame.  


```r
superhero_powers <- clean_names(superhero_powers) #tidying up the superhero_powers data frame
```


```r
glimpse(superhero_powers) #looking at the superhero_powers data frame
```

```
## Rows: 667
## Columns: 168
## $ hero_names                   <chr> "3-D Man", "A-Bomb", "Abe Sapien", "Abin …
## $ agility                      <lgl> TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, F…
## $ accelerated_healing          <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, FA…
## $ lantern_power_ring           <lgl> FALSE, FALSE, FALSE, TRUE, FALSE, FALSE, …
## $ dimensional_awareness        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ cold_resistance              <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ durability                   <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, T…
## $ stealth                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_absorption            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ flight                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ danger_sense                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ underwater_breathing         <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ marksmanship                 <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ weapons_master               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ power_augmentation           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_attributes            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ longevity                    <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, F…
## $ intelligence                 <lgl> FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, FA…
## $ super_strength               <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE…
## $ cryokinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telepathy                    <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ energy_armor                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_blasts                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ duplication                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ size_changing                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ density_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ stamina                      <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, FAL…
## $ astral_travel                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ audio_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ dexterity                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnitrix                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ super_speed                  <lgl> TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FA…
## $ possession                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_oriented_powers       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ weapon_based_powers          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ electrokinesis               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ darkforce_manipulation       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ death_touch                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ teleportation                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ enhanced_senses              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telekinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_beams                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magic                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ hyperkinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ jump                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ clairvoyance                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ dimensional_travel           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ power_sense                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ shapeshifting                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ peak_human_condition         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ immortality                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, TRUE, F…
## $ camouflage                   <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, …
## $ element_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ phasing                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ astral_projection            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ electrical_transport         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ fire_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ projection                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ summoning                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_memory              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ reflexes                     <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ invulnerability              <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, T…
## $ energy_constructs            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ force_fields                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ self_sustenance              <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, …
## $ anti_gravity                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ empathy                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_nullifier              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radiation_control            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ psionic_powers               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ elasticity                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ substance_secretion          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ elemental_transmogrification <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ technopath_cyberpath         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ photographic_reflexes        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ seismic_power                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animation                    <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, …
## $ precognition                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ fire_resistance              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_absorption             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_hearing             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ nova_force                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ insanity                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ hypnokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ animal_control               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ natural_armor                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ intangibility                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_sight               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ molecular_manipulation       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ heat_generation              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ adaptation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ gliding                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_suit                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_blast                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ probability_manipulation     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ gravity_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ regeneration                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ light_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ echolocation                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ levitation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ toxin_and_disease_control    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ banish                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_manipulation          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ heat_resistance              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ natural_weapons              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ time_travel                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_smell               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ illusions                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ thirstokinesis               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ hair_manipulation            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ illumination                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnipotent                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ cloaking                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ changing_armor               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ power_cosmic                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, …
## $ biokinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ water_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radiation_immunity           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_telescopic            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ toxin_and_disease_resistance <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ spatial_awareness            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ energy_resistance            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ telepathy_resistance         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ molecular_combustion         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnilingualism               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ portal_creation              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magnetism                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ mind_control_resistance      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ plant_control                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sonar                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sonic_scream                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ time_manipulation            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ enhanced_touch               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ magic_resistance             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ invisibility                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ sub_mariner                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, …
## $ radiation_absorption         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ intuitive_aptitude           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_microscopic           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ melting                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ wind_control                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ super_breath                 <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, …
## $ wallcrawling                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_night                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_infrared              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ grim_reaping                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ matter_absorption            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ the_force                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ resurrection                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ terrakinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_heat                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vitakinesis                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ radar_sense                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ qwardian_power_ring          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ weather_control              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_x_ray                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_thermal               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ web_creation                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ reality_warping              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ odin_force                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ symbiote_costume             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ speed_force                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ phoenix_force                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ molecular_dissipation        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ vision_cryo                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omnipresent                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
## $ omniscient                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE,…
```

#### 13. How many superheros have a combination of agility, stealth, super_strength, stamina?    


```r
specific_superheroes <- superhero_powers %>% 
        filter(agility == "TRUE", stealth == "TRUE", super_strength == "TRUE", stamina == "TRUE") %>%  #filtering for superheroes that have this combination of powers (as in, all of powers are "TRUE" for each superhero)
        select(hero_names, agility, stealth, super_strength, stamina) #selecting only the specific combination of powers for ease of viewing
specific_superheroes
```

```
## # A tibble: 40 × 5
##    hero_names  agility stealth super_strength stamina
##    <chr>       <lgl>   <lgl>   <lgl>          <lgl>  
##  1 Alex Mercer TRUE    TRUE    TRUE           TRUE   
##  2 Angel       TRUE    TRUE    TRUE           TRUE   
##  3 Ant-Man II  TRUE    TRUE    TRUE           TRUE   
##  4 Aquaman     TRUE    TRUE    TRUE           TRUE   
##  5 Batman      TRUE    TRUE    TRUE           TRUE   
##  6 Black Flash TRUE    TRUE    TRUE           TRUE   
##  7 Black Manta TRUE    TRUE    TRUE           TRUE   
##  8 Brundlefly  TRUE    TRUE    TRUE           TRUE   
##  9 Buffy       TRUE    TRUE    TRUE           TRUE   
## 10 Cable       TRUE    TRUE    TRUE           TRUE   
## # ℹ 30 more rows
```


```r
dim(specific_superheroes)
```

```
## [1] 40  5
```

##### Thus, there are 40 superheroes that have the combination of agility, stealth, super_strength, stamina powers.    

## Your Favorite   

#### 14. Pick your favorite superhero and let's see their powers!  

My favorite superhero is Catwoman:


```r
catwoman_powers <- superhero_powers %>% 
        filter(hero_names == "Catwoman") %>% 
        select_if(.==TRUE) 
catwoman_powers
```

```
## # A tibble: 1 × 8
##   agility stealth marksmanship animal_attributes stamina dexterity
##   <lgl>   <lgl>   <lgl>        <lgl>             <lgl>   <lgl>    
## 1 TRUE    TRUE    TRUE         TRUE              TRUE    TRUE     
## # ℹ 2 more variables: peak_human_condition <lgl>, empathy <lgl>
```


```r
names(catwoman_powers)
```

```
## [1] "agility"              "stealth"              "marksmanship"        
## [4] "animal_attributes"    "stamina"              "dexterity"           
## [7] "peak_human_condition" "empathy"
```

##### Thus, Catwoman's powers include agility, stealth, marksmanship, animal attributes, stamina, dexterity, peak human condition, and empathy.    

#### 15. Can you find your hero in the superhero_info data? Show their info!  

I could find my hero, Catwoman, in the superhero_info data:    


```r
superhero_info %>% 
        filter(name == "Catwoman") #filtering by the name Catwoman to show only her info
```

```
## # A tibble: 1 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Catwo… Female green     Human Black         175 DC Comics <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  