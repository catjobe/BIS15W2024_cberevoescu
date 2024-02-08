---
title: "Lab 4 Homework"
author: "Catrinel Berevoescu"
date: "2024-01-30"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions   

Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse  

Complete  


```r
library(tidyverse)
```

## Data  

For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  

Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

#### 1. Load the data into a new object called `homerange`.   


```r
homerange <- read.csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```


```r
#install.packages("janitor") #I don't want to reinstall this package so I added a "#"
```


```r
library(janitor)
```

```
## 
## Attaching package: 'janitor'
```

```
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```


```r
homerange <- clean_names(homerange) #tidying up data frame
```

#### 2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.  

Dimensions:

569 rows (observations), 24 columns (variables)


```r
dim(homerange)
```

```
## [1] 569  24
```

Column Names:


```r
names(homerange)
```

```
##  [1] "taxon"                      "common_name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "n"                          "mean_mass_g"               
## [11] "log10_mass"                 "alternative_mass_reference"
## [13] "mean_hra_m2"                "log10_hra"                 
## [15] "hra_reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic_guild"              "dimension"                 
## [21] "preymass"                   "log10_preymass"            
## [23] "ppmr"                       "prey_size_reference"
```

Classes for Each Variable:  


```r
glimpse(homerange) #see classes in "<>"
```

```
## Rows: 569
## Columns: 24
## $ taxon                      <chr> "lake fishes", "river fishes", "river fishe…
## $ common_name                <chr> "american eel", "blacktail redhorse", "cent…
## $ class                      <chr> "actinopterygii", "actinopterygii", "actino…
## $ order                      <chr> "anguilliformes", "cypriniformes", "cyprini…
## $ family                     <chr> "anguillidae", "catostomidae", "cyprinidae"…
## $ genus                      <chr> "anguilla", "moxostoma", "campostoma", "cli…
## $ species                    <chr> "rostrata", "poecilura", "anomalum", "fundu…
## $ primarymethod              <chr> "telemetry", "mark-recapture", "mark-recapt…
## $ n                          <chr> "16", NA, "20", "26", "17", "5", "2", "2", …
## $ mean_mass_g                <dbl> 887.00, 562.00, 34.00, 4.00, 4.00, 3525.00,…
## $ log10_mass                 <dbl> 2.9479236, 2.7497363, 1.5314789, 0.6020600,…
## $ alternative_mass_reference <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,…
## $ mean_hra_m2                <dbl> 282750.00, 282.10, 116.11, 125.50, 87.10, 3…
## $ log10_hra                  <dbl> 5.4514026, 2.4504031, 2.0648696, 2.0986437,…
## $ hra_reference              <chr> "Minns, C. K. 1995. Allometry of home range…
## $ realm                      <chr> "aquatic", "aquatic", "aquatic", "aquatic",…
## $ thermoregulation           <chr> "ectotherm", "ectotherm", "ectotherm", "ect…
## $ locomotion                 <chr> "swimming", "swimming", "swimming", "swimmi…
## $ trophic_guild              <chr> "carnivore", "carnivore", "carnivore", "car…
## $ dimension                  <chr> "3D", "2D", "2D", "2D", "2D", "2D", "2D", "…
## $ preymass                   <dbl> NA, NA, NA, NA, NA, NA, 1.39, NA, NA, NA, N…
## $ log10_preymass             <dbl> NA, NA, NA, NA, NA, NA, 0.1430148, NA, NA, …
## $ ppmr                       <dbl> NA, NA, NA, NA, NA, NA, 530, NA, NA, NA, NA…
## $ prey_size_reference        <chr> NA, NA, NA, NA, NA, NA, "Brose U, et al. 20…
```


```r
sapply(homerange, class) #a simplified summary of the data classes for each variable; the full data class name is provided in quotes for each variable
```

```
##                      taxon                common_name 
##                "character"                "character" 
##                      class                      order 
##                "character"                "character" 
##                     family                      genus 
##                "character"                "character" 
##                    species              primarymethod 
##                "character"                "character" 
##                          n                mean_mass_g 
##                "character"                  "numeric" 
##                 log10_mass alternative_mass_reference 
##                  "numeric"                "character" 
##                mean_hra_m2                  log10_hra 
##                  "numeric"                  "numeric" 
##              hra_reference                      realm 
##                "character"                "character" 
##           thermoregulation                 locomotion 
##                "character"                "character" 
##              trophic_guild                  dimension 
##                "character"                "character" 
##                   preymass             log10_preymass 
##                  "numeric"                  "numeric" 
##                       ppmr        prey_size_reference 
##                  "numeric"                "character"
```

Statistical Summary (provided for numerical variables):   


```r
summary(homerange)
```

```
##     taxon           common_name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       n              mean_mass_g        log10_mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative_mass_reference  mean_hra_m2          log10_hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra_reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic_guild       dimension            preymass         log10_preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       ppmr         prey_size_reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

#### 3. Change the class of the variables `taxon` and `order` to factors and display their levels.  

Taxon:


```r
taxon <- as.factor(homerange$taxon) #changing the class of the variables 'taxon' to factors
levels(taxon) #displaying levels of 'taxon'
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```

Order:


```r
order <- as.factor(homerange$order) #changing the class of the variables 'order' to factors
levels(order) #displaying levels of 'order'
```

```
##  [1] "accipitriformes"       "afrosoricida"          "anguilliformes"       
##  [4] "anseriformes"          "apterygiformes"        "artiodactyla"         
##  [7] "caprimulgiformes"      "carnivora"             "charadriiformes"      
## [10] "columbidormes"         "columbiformes"         "coraciiformes"        
## [13] "cuculiformes"          "cypriniformes"         "dasyuromorpha"        
## [16] "dasyuromorpia"         "didelphimorphia"       "diprodontia"          
## [19] "diprotodontia"         "erinaceomorpha"        "esociformes"          
## [22] "falconiformes"         "gadiformes"            "galliformes"          
## [25] "gruiformes"            "lagomorpha"            "macroscelidea"        
## [28] "monotrematae"          "passeriformes"         "pelecaniformes"       
## [31] "peramelemorphia"       "perciformes"           "perissodactyla"       
## [34] "piciformes"            "pilosa"                "proboscidea"          
## [37] "psittaciformes"        "rheiformes"            "roden"                
## [40] "rodentia"              "salmoniformes"         "scorpaeniformes"      
## [43] "siluriformes"          "soricomorpha"          "squamata"             
## [46] "strigiformes"          "struthioniformes"      "syngnathiformes"      
## [49] "testudines"            "tetraodontiformes\xa0" "tinamiformes"
```

#### 4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.  

The following taxa, where taxa are generic names for taxonomic groupings such as species, genus, and family, are represented in the homerange data frame.

Data frame 'taxa':


```r
taxa <- select(homerange, "taxon", "common_name", "class", "order", "family", "genus", "species")
taxa
```

```
##             taxon                      common_name          class
## 1     lake fishes                     american eel actinopterygii
## 2    river fishes               blacktail redhorse actinopterygii
## 3    river fishes              central stoneroller actinopterygii
## 4    river fishes                    rosyside dace actinopterygii
## 5    river fishes                    longnose dace actinopterygii
## 6    river fishes                     muskellunge  actinopterygii
## 7   marine fishes                          pollack actinopterygii
## 8   marine fishes                           saithe actinopterygii
## 9   marine fishes                lined surgeonfish actinopterygii
## 10  marine fishes          orangespine unicornfish actinopterygii
## 11  marine fishes            bluespine unicornfish actinopterygii
## 12  marine fishes                    redlip blenny actinopterygii
## 13  marine fishes                   giant trevally actinopterygii
## 14    lake fishes                        rock bass actinopterygii
## 15    lake fishes                     pumpkinseed  actinopterygii
## 16    lake fishes                        bluegill  actinopterygii
## 17   river fishes                  longear sunfish actinopterygii
## 18   river fishes                  smallmouth bass actinopterygii
## 19    lake fishes                  largemouth bass actinopterygii
## 20    lake fishes                    white crappie actinopterygii
## 21  marine fishes eastern triangular butterflyfish actinopterygii
## 22  marine fishes          Tahititan butterflyfish actinopterygii
## 23  marine fishes            chevron butterflyfish actinopterygii
## 24  marine fishes              melon butterflyfish actinopterygii
## 25  marine fishes           teardrop butterflyfish actinopterygii
## 26  marine fishes                         red moki actinopterygii
## 27  marine fishes              redspotted hawkfish actinopterygii
## 28  marine fishes                   dwarf hawkfish actinopterygii
## 29  marine fishes                          cabezon actinopterygii
## 30  marine fishes              japanese shrimpgoby actinopterygii
## 31  marine fishes                  bluebanded goby actinopterygii
## 32  marine fishes                       rusty goby actinopterygii
## 33  marine fishes                    blackeye goby actinopterygii
## 34  marine fishes                  longfinned goby actinopterygii
## 35  marine fishes                     bermuda chub actinopterygii
## 36  marine fishes                  spanish hogfish actinopterygii
## 37  marine fishes                  humphead wrasse actinopterygii
## 38  marine fishes     mediterranean rainbow wrasse actinopterygii
## 39  marine fishes                    slippery dick actinopterygii
## 40  marine fishes                yellowhead wrasse actinopterygii
## 41  marine fishes                     clown wrasse actinopterygii
## 42  marine fishes                  blackear wrasse actinopterygii
## 43  marine fishes        bluestreak cleaner wrasse actinopterygii
## 44  marine fishes                    ballan wrasse actinopterygii
## 45  marine fishes                     maori wrasse actinopterygii
## 46  marine fishes            california sheepshead actinopterygii
## 47  marine fishes                           cunner actinopterygii
## 48  marine fishes                  bluehead wrasse actinopterygii
## 49  marine fishes                      moon wrasse actinopterygii
## 50  marine fishes               thumbprint emperor actinopterygii
## 51  marine fishes                   mutton snapper actinopterygii
## 52  marine fishes             schoolmaster snapper actinopterygii
## 53  marine fishes                checkered snapper actinopterygii
## 54  marine fishes                     gray snapper actinopterygii
## 55  marine fishes               yellowtail snapper actinopterygii
## 56  marine fishes                  ocean whitefish actinopterygii
## 57  marine fishes                 european seabass actinopterygii
## 58  marine fishes                   white goatfish actinopterygii
## 59  marine fishes             whitesaddle goatfish actinopterygii
## 60    lake fishes                     yellow perch actinopterygii
## 61  marine fishes                    canary damsel actinopterygii
## 62  marine fishes                       cherubfish actinopterygii
## 63  marine fishes                       damselfish actinopterygii
## 64  marine fishes              twinspot damselfish actinopterygii
## 65  marine fishes              whitetail dascyllus actinopterygii
## 66  marine fishes                     wards damsel actinopterygii
## 67  marine fishes               australian gregory actinopterygii
## 68  marine fishes               bicolor damselfish actinopterygii
## 69  marine fishes                 cocoa damselfish actinopterygii
## 70  marine fishes             steephead parrotfish actinopterygii
## 71  marine fishes               striped parrotfish actinopterygii
## 72  marine fishes             rivulated parrotfish actinopterygii
## 73  marine fishes               redband parrotfish actinopterygii
## 74  marine fishes               redtail parrotfish actinopterygii
## 75  marine fishes                redfin parrotfish actinopterygii
## 76  marine fishes             stoplight parrotfish actinopterygii
## 77  marine fishes                     peacock hind actinopterygii
## 78  marine fishes                          graysby actinopterygii
## 79  marine fishes                   yellowfin hind actinopterygii
## 80  marine fishes                       coral hind actinopterygii
## 81  marine fishes                         red hind actinopterygii
## 82  marine fishes                    dusky grouper actinopterygii
## 83  marine fishes                      red grouper actinopterygii
## 84  marine fishes                   nassau grouper actinopterygii
## 85  marine fishes                   greasy grouper actinopterygii
## 86  marine fishes                  redbanded perch actinopterygii
## 87  marine fishes             half-banded seaperch actinopterygii
## 88  marine fishes                    black grouper actinopterygii
## 89  marine fishes                        kelp bass actinopterygii
## 90  marine fishes                 barred sand bass actinopterygii
## 91  marine fishes                    coral grouper actinopterygii
## 92  marine fishes                      coral trout actinopterygii
## 93  marine fishes                           comber actinopterygii
## 94  marine fishes                   painted comber actinopterygii
## 95  marine fishes                           salema actinopterygii
## 96  marine fishes                gilthead seabream actinopterygii
## 97   river fishes                  cutthroat trout actinopterygii
## 98   river fishes                       gila trout actinopterygii
## 99   river fishes                    rainbow trout actinopterygii
## 100  river fishes                  atlantic salmon actinopterygii
## 101   lake fishes                      brown trout actinopterygii
## 102  river fishes                  mottled sculpin actinopterygii
## 103  river fishes                   banded sculpin actinopterygii
## 104  river fishes                         sculpin  actinopterygii
## 105 marine fishes                  copper rockfish actinopterygii
## 106 marine fishes          japanese black rockfish actinopterygii
## 107 marine fishes               quillback rockfish actinopterygii
## 108 marine fishes                   black rockfish actinopterygii
## 109 marine fishes                    blue rockfish actinopterygii
## 110   lake fishes                  yellow bullhead actinopterygii
## 111 marine fishes            long-snouted seahorse actinopterygii
## 112 marine fishes                    worm pipefish actinopterygii
## 113 marine fishes        atlantic sharpnose puffer actinopterygii
## 114         birds                     golden eagle           aves
## 115         birds                   common buzzard           aves
## 116         birds           short-toed snake eagle           aves
## 117         birds                  Bonelli's eagle           aves
## 118         birds                     booted eagle           aves
## 119         birds                 Egyptian vulture           aves
## 120         birds                          gadwall           aves
## 121         birds              northern brown kiwi           aves
## 122         birds                European nightjar           aves
## 123         birds                    oystercatcher           aves
## 124         birds                        inca dove           aves
## 125         birds               common wood pigeon           aves
## 126         birds             European turtle dove           aves
## 127         birds                  European roller           aves
## 128         birds                           hoopoe           aves
## 129         birds             great spotted cuckoo           aves
## 130         birds                    common cuckoo           aves
## 131         birds               greater roadrunner           aves
## 132         birds             banded ground-cuckoo           aves
## 133         birds                    Cooper's hawk           aves
## 134         birds                 Northern goshawk           aves
## 135         birds             Eurasian sparrowhawk           aves
## 136         birds               sharp-shinned hawk           aves
## 137         birds                  red-tailed hawk           aves
## 138         birds              red-shouldered hawk           aves
## 139         birds                  Swainson's hawk           aves
## 140         birds                      hen harrier           aves
## 141         birds                Montagu's harrier           aves
## 142         birds                         red kite           aves
## 143         birds                         caracara           aves
## 144         birds            red-throated caracara           aves
## 145         birds                    lanner falcon           aves
## 146         birds                   prairie falcon           aves
## 147         birds                 peregrine falcon           aves
## 148         birds                 American kestrel           aves
## 149         birds                 European kestrel           aves
## 150         birds                     hazel grouse           aves
## 151         birds                      sage grouse           aves
## 152         birds                     dusky grouse           aves
## 153         birds                 willow ptarmigan           aves
## 154         birds                   grey partridge           aves
## 155         birds                     black grouse           aves
## 156         birds             western capercaillie           aves
## 157         birds          greater prairie-chicken           aves
## 158         birds                  brown wood rail           aves
## 159         birds                        corncrake           aves
## 160         birds                        king rail           aves
## 161         birds                melodious warbler           aves
## 162         birds                  long-tailed tit           aves
## 163         birds                         woodlark           aves
## 164         birds         red-throated ant tanager           aves
## 165         birds          red-crowned ant tanager           aves
## 166         birds             Eurasian treecreeper           aves
## 167         birds         streaked fantail warbler           aves
## 168         birds                     common raven           aves
## 169         birds               spotted nutcracker           aves
## 170         birds             Peruvian plantcutter           aves
## 171         birds              grasshopper sparrow           aves
## 172         birds                   indigo bunting           aves
## 173         birds                   Abert's towhee           aves
## 174         birds                    canyon towhee           aves
## 175         birds            American tree sparrow           aves
## 176         birds                 chipping sparrow           aves
## 177         birds                    common linnet           aves
## 178         birds                 common chaffinch           aves
## 179         birds                   European serin           aves
## 180         birds               eastern meadowlark           aves
## 181         birds               western meadowlard           aves
## 182         birds             yellow-breasted chat           aves
## 183         birds                red-backed shrike           aves
## 184         birds                loggerhead shrike           aves
## 185         birds               lesser grey shrike           aves
## 186         birds                  woodchat shrike           aves
## 187         birds             northern mockingbird           aves
## 188         birds                    white wagtail           aves
## 189         birds           western yellow wagtail           aves
## 190         birds               spotted flycatcher           aves
## 191         birds                northern wheatear           aves
## 192         birds                  common redstart           aves
## 193         birds                         whinchat           aves
## 194         birds           black-capped chickadee           aves
## 195         birds               Carolina chickadee           aves
## 196         birds                     Oak titmouse           aves
## 197         birds                        marsh tit           aves
## 198         birds                 mourning warbler           aves
## 199         birds              common yellowthroat           aves
## 200         birds             prothonotary warbler           aves
## 201         birds                         ovenbird           aves
## 202         birds             Blackburnian warbler           aves
## 203         birds               Kirtland's warbler           aves
## 204         birds                 magnolia warbler           aves
## 205         birds           chestnut-sided warbler           aves
## 206         birds          American yellow warbler           aves
## 207         birds                American redstart           aves
## 208         birds     black-throated green warbler           aves
## 209         birds                   Canada warbler           aves
## 210         birds        Western Bonelli's warbler           aves
## 211         birds           tooth-billed bowerbird           aves
## 212         birds                 common firecrest           aves
## 213         birds                        goldcrest           aves
## 214         birds                European nuthatch           aves
## 215         birds                          wrentit           aves
## 216         birds                Marmora's warbler           aves
## 217         birds                 Dartford warbler           aves
## 218         birds                   Berwick's wren           aves
## 219         birds                    Carolina wren           aves
## 220         birds                       house wren           aves
## 221         birds                    Eurasian wren           aves
## 222         birds                 eastern bluebird           aves
## 223         birds               eastern wood pewee           aves
## 224         birds                 least flycatcher           aves
## 225         birds         American gray flycatcher           aves
## 226         birds                 eastern kingbird           aves
## 227         birds               black-capped vireo           aves
## 228         birds                     Bell's vireo           aves
## 229         birds                 white-eyed vireo           aves
## 230         birds                   red-eyed vireo           aves
## 231         birds                    great bittern           aves
## 232         birds                    least bittern           aves
## 233         birds                 black woodpecker           aves
## 234         birds                 Eurasian wryneck           aves
## 235         birds          white-backed woodpecker           aves
## 236         birds       middle spotted woodpeckers           aves
## 237         birds   Eurasian three-toed woodpecker           aves
## 238         birds           grey-headed woodpecker           aves
## 239         birds        European green woodpecker           aves
## 240         birds                           kakapo           aves
## 241         birds                     greater rhea           aves
## 242         birds                      lesser rhea           aves
## 243         birds                       boreal owl           aves
## 244         birds                   long-eared owl           aves
## 245         birds                       little owl           aves
## 246         birds               Eurasian eagle-owl           aves
## 247         birds                 great horned owl           aves
## 248         birds               Eurasian pygmy owl           aves
## 249         birds                        snowy owl           aves
## 250         birds                        tawny owl           aves
## 251         birds                         barn owl           aves
## 252         birds                          ostrich           aves
## 253         birds                   ornate tinamou           aves
## 254       mammals                giant golden mole       mammalia
## 255       mammals              Grant's golden mole       mammalia
## 256       mammals                        pronghorn       mammalia
## 257       mammals                           impala       mammalia
## 258       mammals                       hartebeest       mammalia
## 259       mammals                    barbary sheep       mammalia
## 260       mammals                   American bison       mammalia
## 261       mammals                   European bison       mammalia
## 262       mammals                             goat       mammalia
## 263       mammals                     Spanish ibex       mammalia
## 264       mammals                   Peter's dukier       mammalia
## 265       mammals                       bay dikier       mammalia
## 266       mammals                 mountain gazelle       mammalia
## 267       mammals             G\xfcnther's dik-dik       mammalia
## 268       mammals                    mountain goat       mammalia
## 269       mammals                           argali       mammalia
## 270       mammals                    bighorn sheep       mammalia
## 271       mammals                         steenbok       mammalia
## 272       mammals                          chamois       mammalia
## 273       mammals                     common eland       mammalia
## 274       mammals                         bushbuck       mammalia
## 275       mammals                     greater kudu       mammalia
## 276       mammals                            moose       mammalia
## 277       mammals                           chital       mammalia
## 278       mammals                         roe deer       mammalia
## 279       mammals                         red deer       mammalia
## 280       mammals                        sika deer       mammalia
## 281       mammals                      fallow deer       mammalia
## 282       mammals                 Reeves's muntjac       mammalia
## 283       mammals                        mule deer       mammalia
## 284       mammals                white-tailed deer       mammalia
## 285       mammals                      pampas deer       mammalia
## 286       mammals                             pudu       mammalia
## 287       mammals                         reindeer       mammalia
## 288       mammals                          giraffe       mammalia
## 289       mammals                            okapi       mammalia
## 290       mammals                   desert warthog       mammalia
## 291       mammals                  Chacoan peccary       mammalia
## 292       mammals                 collared peccary       mammalia
## 293       mammals             white-lipped peccary       mammalia
## 294       mammals                 water chevrotain       mammalia
## 295       mammals                        red panda       mammalia
## 296       mammals                       arctic fox       mammalia
## 297       mammals                   Ethiopian wolf       mammalia
## 298       mammals                           culpeo       mammalia
## 299       mammals          South American gray fox       mammalia
## 300       mammals                          kit fox       mammalia
## 301       mammals                     Ruppel's fox       mammalia
## 302       mammals                        swift fox       mammalia
## 303       mammals   thick-tailed three-toed jerboa       mammalia
## 304       mammals                            fossa       mammalia
## 305       mammals                          cheetah       mammalia
## 306       mammals                          caracal       mammalia
## 307       mammals                              cat       mammalia
## 308       mammals                          wildcat       mammalia
## 309       mammals                       jaguarundi       mammalia
## 310       mammals                           ocelot       mammalia
## 311       mammals                           margay       mammalia
## 312       mammals                           serval       mammalia
## 313       mammals                      Canada lynx       mammalia
## 314       mammals                    Eurasian lynx       mammalia
## 315       mammals                     Iberian lynx       mammalia
## 316       mammals                           bobcat       mammalia
## 317       mammals                   Geoffroy's cat       mammalia
## 318       mammals                           jaguar       mammalia
## 319       mammals                          leopard       mammalia
## 320       mammals                            tiger       mammalia
## 321       mammals                      leopard cat       mammalia
## 322       mammals                           cougar       mammalia
## 323       mammals                     snow leopard       mammalia
## 324       mammals                   marsh mongoose       mammalia
## 325       mammals                  yellow mongoose       mammalia
## 326       mammals            common dwarf mongoose       mammalia
## 327       mammals                Egyptian mongoose       mammalia
## 328       mammals            white-tailed mongoose       mammalia
## 329       mammals                         aardwolf       mammalia
## 330       mammals                            tayra       mammalia
## 331       mammals                   greater grison       mammalia
## 332       mammals                        wolverine       mammalia
## 333       mammals                  American marten       mammalia
## 334       mammals                     beech marten       mammalia
## 335       mammals             European pine marten       mammalia
## 336       mammals                           fisher       mammalia
## 337       mammals                            stoat       mammalia
## 338       mammals               long-tailed weasel       mammalia
## 339       mammals                           ferret       mammalia
## 340       mammals                    European mink       mammalia
## 341       mammals              black-footed ferret       mammalia
## 342       mammals                     least weasel       mammalia
## 343       mammals                  Siberian weasel       mammalia
## 344       mammals                  American badger       mammalia
## 345       mammals                         kinkajou       mammalia
## 346       mammals                      giant panda       mammalia
## 347       mammals                       sloth bear       mammalia
## 348       mammals                     common genet       mammalia
## 349       mammals                       cape genet       mammalia
## 350       mammals               large indian civet       mammalia
## 351       mammals                    Western quoll       mammalia
## 352       mammals                      tiger quoll       mammalia
## 353       mammals             white-footed dunnart       mammalia
## 354       mammals                 brown antechinus       mammalia
## 355       mammals   Northern three-striped opossum       mammalia
## 356       mammals       elegant fat-tailed opossum       mammalia
## 357       mammals         Lumholtz's tree-kangaroo       mammalia
## 358       mammals              antilopine kangaroo       mammalia
## 359       mammals            black-striped wallaby       mammalia
## 360       mammals            Western grey kangaroo       mammalia
## 361       mammals            Eastern grey kangaroo       mammalia
## 362       mammals                  common wallaroo       mammalia
## 363       mammals               red-necked wallaby       mammalia
## 364       mammals                     red kangaroo       mammalia
## 365       mammals              allied rock-wallaby       mammalia
## 366       mammals                  eastern bettong       mammalia
## 367       mammals              long-footed potoroo       mammalia
## 368       mammals                   greater glider       mammalia
## 369       mammals        bridled nail-tail wallaby       mammalia
## 370       mammals             red-legged pademelon       mammalia
## 371       mammals             red-necked pademelon       mammalia
## 372       mammals                    swamp wallaby       mammalia
## 373       mammals          common brushtail possum       mammalia
## 374       mammals      northern hairy-nosed wombat       mammalia
## 375       mammals                    common wombat       mammalia
## 376       mammals                European hedgehog       mammalia
## 377       mammals              long-eared hedgehog       mammalia
## 378       mammals                     pygmy rabbit       mammalia
## 379       mammals                    snowshoe hare       mammalia
## 380       mammals                      Arctic hare       mammalia
## 381       mammals          black-tailed jackrabbit       mammalia
## 382       mammals                        cape hare       mammalia
## 383       mammals                    European hare       mammalia
## 384       mammals                      Indian hare       mammalia
## 385       mammals                    mountain hare       mammalia
## 386       mammals                  European rabbit       mammalia
## 387       mammals                     swamp rabbit       mammalia
## 388       mammals               eastern cottontail       mammalia
## 389       mammals                     marsh rabbit       mammalia
## 390       mammals                     plateau pika       mammalia
## 391       mammals                    American pika       mammalia
## 392       mammals            rufous elephant shrew       mammalia
## 393       mammals         four-toed elephant shrew       mammalia
## 394       mammals     golden-rumped elephant shrew       mammalia
## 395       mammals            east African mole rat       mammalia
## 396       mammals                 golden bandicoot       mammalia
## 397       mammals         Southern brown bandicoot       mammalia
## 398       mammals                            horse       mammalia
## 399       mammals                 white rhinoceros       mammalia
## 400       mammals                 black rhinoceros       mammalia
## 401       mammals                      maned sloth       mammalia
## 402       mammals                   Asian elephant       mammalia
## 403       mammals            African bush elephant       mammalia
## 404       mammals       southern grasshopper mouse       mammalia
## 405       mammals                  mountain beaver       mammalia
## 406       mammals               cape dune mole rat       mammalia
## 407       mammals              Damaraland mole rat       mammalia
## 408       mammals                  common mole rat       mammalia
## 409       mammals                    cape mole rat       mammalia
## 410       mammals                 silvery mole rat       mammalia
## 411       mammals                   naked mole rat       mammalia
## 412       mammals                  Patagonian mara       mammalia
## 413       mammals                  plains viscacha       mammalia
## 414       mammals          western red-backed vole       mammalia
## 415       mammals            large-headed rice rat       mammalia
## 416       mammals           Siberian brown lemming       mammalia
## 417       mammals                       field vole       mammalia
## 418       mammals                  California vole       mammalia
## 419       mammals                     montane vole       mammalia
## 420       mammals                     prairie vole       mammalia
## 421       mammals                      meadow vole       mammalia
## 422       mammals                    woodland vole       mammalia
## 423       mammals                       water vole       mammalia
## 424       mammals                     wood lemming       mammalia
## 425       mammals             bushy-tailed woodrat       mammalia
## 426       mammals             dusky-footed woodrat       mammalia
## 427       mammals                   desert woodrat       mammalia
## 428       mammals          Southern plains woodrat       mammalia
## 429       mammals                          muskrat       mammalia
## 430       mammals                     cotton mouse       mammalia
## 431       mammals         salt marsh harvest mouse       mammalia
## 432       mammals             southern bog lemming       mammalia
## 433       mammals          dwarf fat-tailed jerboa       mammalia
## 434       mammals               Cuvier's spiny rat       mammalia
## 435       mammals                 Tome's spiny rat       mammalia
## 436       mammals              Brazilian porcupine       mammalia
## 437       mammals         North American porcupine       mammalia
## 438       mammals            Botta's pocket gopher       mammalia
## 439       mammals              spectacled dormouse       mammalia
## 440       mammals                   hazel dormouse       mammalia
## 441       mammals               giant kangaroo rat       mammalia
## 442       mammals           Merriam's kangaroo rat       mammalia
## 443       mammals               Ord's kangaroo rat       mammalia
## 444       mammals       banner-tailed kangaroo rat       mammalia
## 445       mammals           Stephen's kangaroo rat       mammalia
## 446       mammals                   cape porcupine       mammalia
## 447       mammals         Indian crested porcupine       mammalia
## 448       mammals   African brush-tailed porcupine       mammalia
## 449       mammals              yellow-necked mouse       mammalia
## 450       mammals                       wood mouse       mammalia
## 451       mammals               Indian desert jird       mammalia
## 452       mammals              broad-toothed mouse       mammalia
## 453       mammals               Malagasy giant rat       mammalia
## 454       mammals         White-bellied\xa0nesomys       mammalia
## 455       mammals                     island mouse       mammalia
## 456       mammals                           coruro       mammalia
## 457       mammals                Siberian chipmunk       mammalia
## 458       mammals           Northern parl squirrel       mammalia
## 459       mammals         Northern flying squirrel       mammalia
## 460       mammals         Southern flying squirrel       mammalia
## 461       mammals            yellow-bellied marmot       mammalia
## 462       mammals                        groundhog       mammalia
## 463       mammals                red bush squirrel       mammalia
## 464       mammals                 Abert's squirrel       mammalia
## 465       mammals            eastern gray squirrel       mammalia
## 466       mammals                Japanese squirrel       mammalia
## 467       mammals                     fox squirrel       mammalia
## 468       mammals                     red squirrel       mammalia
## 469       mammals       California ground squirrel       mammalia
## 470       mammals        Columbian ground squirrel       mammalia
## 471       mammals       Franklin's ground squirrel       mammalia
## 472       mammals           arctic ground squirrel       mammalia
## 473       mammals          spotted ground squirrel       mammalia
## 474       mammals   thirteen-lined ground squirrel       mammalia
## 475       mammals                    rock squirrel       mammalia
## 476       mammals             yellow-pine chipmunk       mammalia
## 477       mammals                   least chipmunk       mammalia
## 478       mammals                Colorado chipmunk       mammalia
## 479       mammals                   Uinta chipmunk       mammalia
## 480       mammals            American red squirrel       mammalia
## 481       mammals          striped ground squirrel       mammalia
## 482       mammals       greater white-footed shrew       mammalia
## 483       mammals                     arctic shrew       mammalia
## 484       mammals                   cinereus shrew       mammalia
## 485       mammals                    crowned shrew       mammalia
## 486       mammals                    slender shrew       mammalia
## 487       mammals                long-clawed shrew       mammalia
## 488       mammals                  star-nosed mole       mammalia
## 489       mammals                     eastern mole       mammalia
## 490       mammals                    European mole       mammalia
## 491       mammals                       Roman mole       mammalia
## 492       lizards                spiny tail lizard       reptilia
## 493        snakes               western worm snake       reptilia
## 494        snakes               eastern worm snake       reptilia
## 495        snakes                            racer       reptilia
## 496        snakes             yellow bellied racer       reptilia
## 497        snakes                   ringneck snake       reptilia
## 498        snakes             eastern indigo snake       reptilia
## 499        snakes            great plains ratsnake       reptilia
## 500        snakes                 western ratsnake       reptilia
## 501        snakes                    hognose snake       reptilia
## 502        snakes               European whipsnake       reptilia
## 503        snakes                Eastern kingsnake       reptilia
## 504        snakes                        milksnake       reptilia
## 505        snakes                        coachwhip       reptilia
## 506        snakes                      grass snake       reptilia
## 507        snakes           copperbelly watersnake       reptilia
## 508        snakes              Northern watersnake       reptilia
## 509        snakes               redbacked ratsnake       reptilia
## 510        snakes                     gopher snake       reptilia
## 511        snakes                       pine snake       reptilia
## 512        snakes             butlers garter snake       reptilia
## 513        snakes              giant garter snakes       reptilia
## 514        snakes                Aesculapian snake       reptilia
## 515        snakes                broadheaded snake       reptilia
## 516        snakes                      tiger snake       reptilia
## 517        snakes                       blacksnake       reptilia
## 518       lizards            Galapagos land iguana       reptilia
## 519       lizards           Bahamian Andros iguana       reptilia
## 520       lizards                      blue iguana       reptilia
## 521       lizards            Anegada ground iguana       reptilia
## 522       lizards          Angel island chuckwalla       reptilia
## 523       lizards                common chuckwalla       reptilia
## 524       lizards                    desert iguana       reptilia
## 525       lizards                  Tenerife lizard       reptilia
## 526       lizards             High Mountain Lizard       reptilia
## 527        snakes       southwestern carpet python       reptilia
## 528       lizards                      land mullet       reptilia
## 529        snakes                       copperhead       reptilia
## 530        snakes                      cottonmouth       reptilia
## 531        snakes              namaqua dwarf adder       reptilia
## 532        snakes                     fer-de-lance       reptilia
## 533        snakes              western diamondback       reptilia
## 534        snakes                       sidewinder       reptilia
## 535        snakes               timber rattlesnake       reptilia
## 536        snakes          blacktailed rattlesnake       reptilia
## 537        snakes         midget faded rattlesnake       reptilia
## 538        snakes         twin-spotted rattlesnake       reptilia
## 539        snakes               Mojave rattlesnake       reptilia
## 540        snakes                tiger rattlesnake       reptilia
## 541        snakes                chinese pit viper       reptilia
## 542        snakes                   Armenian viper       reptilia
## 543        snakes                  snubnosed viper       reptilia
## 544       turtles       Eastern long-necked turtle       reptilia
## 545       turtles      Dalh's toad-headed tortoise       reptilia
## 546       turtles           common snapping turtle       reptilia
## 547       turtles           midland painted turtle       reptilia
## 548       turtles                   chicken turtle       reptilia
## 549       turtles                Blanding's turtle       reptilia
## 550       turtles             European pond turtle       reptilia
## 551       turtles       yellow-blotched map turtle       reptilia
## 552       turtles                ornate box turtle       reptilia
## 553       turtles              Spanish pond turtle       reptilia
## 554       turtles               Eastern mud turtle       reptilia
## 555       turtles        stripe-necked musk turtle       reptilia
## 556       turtles                  stinkpot turtle       reptilia
## 557     tortoises              red-footed tortoise       reptilia
## 558     tortoises                  desert tortoise       reptilia
## 559     tortoises                  gopher tortoise       reptilia
## 560     tortoises              travancore tortoise       reptilia
## 561     tortoises    Speke's hinge-backed tortoise       reptilia
## 562     tortoises               impressed tortoise       reptilia
## 563     tortoises        bushmanland tent tortoise       reptilia
## 564     tortoises                 leopard tortoise       reptilia
## 565     tortoises            spur-thighed tortoise       reptilia
## 566     tortoises           mediterranean tortoise       reptilia
## 567     tortoises          Russian steppe tortoise       reptilia
## 568     tortoises                Egyptian tortoise       reptilia
## 569       turtles   Eastern spiny softshell turtle       reptilia
##                     order            family           genus
## 1          anguilliformes       anguillidae        anguilla
## 2           cypriniformes      catostomidae       moxostoma
## 3           cypriniformes        cyprinidae      campostoma
## 4           cypriniformes        cyprinidae     clinostomus
## 5           cypriniformes        cyprinidae     rhinichthys
## 6             esociformes          esocidae            esox
## 7              gadiformes           gadidae      pollachius
## 8              gadiformes           gadidae      pollachius
## 9             perciformes      acanthuridae      acanthurus
## 10            perciformes      acanthuridae            naso
## 11            perciformes      acanthuridae            naso
## 12            perciformes         blennidae   ophioblennius
## 13            perciformes        carangidae          caranx
## 14            perciformes     centrarchidae     ambloplites
## 15            perciformes     centrarchidae         lepomis
## 16            perciformes     centrarchidae         lepomis
## 17            perciformes     centrarchidae         lepomis
## 18            perciformes     centrarchidae     micropterus
## 19            perciformes     centrarchidae     micropterus
## 20            perciformes     centrarchidae         pomoxis
## 21            perciformes    chaetodontidae       chaetodon
## 22            perciformes    chaetodontidae       chaetodon
## 23            perciformes    chaetodontidae       chaetodon
## 24            perciformes    chaetodontidae       chaetodon
## 25            perciformes    chaetodontidae       chaetodon
## 26            perciformes  cheilodactylidae  cheilodactylus
## 27            perciformes       cirrhitidae  amblycirrhitus
## 28            perciformes       cirrhitidae  cirrhitichthys
## 29            perciformes          cottidae scorpaenichthys
## 30            perciformes          gobiidae   amblyeleotris
## 31            perciformes          gobiidae      lythrypnus
## 32            perciformes          gobiidae       priolepis
## 33            perciformes          gobiidae    rhinogobiops
## 34            perciformes          gobiidae    valenciennea
## 35            perciformes        kyphosidae        kyphosus
## 36            perciformes          labridae        bodianus
## 37            perciformes          labridae        chelinus
## 38            perciformes          labridae           coris
## 39            perciformes          labridae     halichoeres
## 40            perciformes          labridae     halichoeres
## 41            perciformes          labridae     halichoeres
## 42            perciformes          labridae     halichoeres
## 43            perciformes          labridae       labroides
## 44            perciformes          labridae          labrus
## 45            perciformes          labridae   opthalmolepis
## 46            perciformes          labridae   semicossyphus
## 47            perciformes          labridae   tautogolabrus
## 48            perciformes          labridae      thalassoma
## 49            perciformes          labridae      thalassoma
## 50            perciformes       lethrinidae       lethrinus
## 51            perciformes        lutjanidae        lutjanus
## 52            perciformes        lutjanidae        lutjanus
## 53            perciformes        lutjanidae        lutjanus
## 54            perciformes        lutjanidae        lutjanus
## 55            perciformes        lutjanidae         ocyurus
## 56            perciformes     malacanthidae    caulolatilus
## 57            perciformes         moronidae   dicentrarchus
## 58            perciformes          mullidae  mulloidichthys
## 59            perciformes          mullidae      parupeneus
## 60            perciformes          percidae           perca
## 61            perciformes     pomacanthidae       abudefduf
## 62            perciformes     pomacanthidae      centropyge
## 63            perciformes     pomacentridae         chromis
## 64            perciformes     pomacentridae     chrysiptera
## 65            perciformes     pomacentridae       dascyllus
## 66            perciformes     pomacentridae     pomacentrus
## 67            perciformes     pomacentridae       stegastes
## 68            perciformes     pomacentridae       stegastes
## 69            perciformes     pomacentridae       stegastes
## 70            perciformes          scaridae       chlorurus
## 71            perciformes          scaridae          scarus
## 72            perciformes          scaridae          scarus
## 73            perciformes          scaridae       sparisoma
## 74            perciformes          scaridae       sparisoma
## 75            perciformes          scaridae       sparisoma
## 76            perciformes          scaridae       sparisoma
## 77            perciformes        serranidae   cephalopholis
## 78            perciformes        serranidae   cephalopholis
## 79            perciformes        serranidae   cephalopholis
## 80            perciformes        serranidae   cephalopholis
## 81            perciformes        serranidae     epinephelus
## 82            perciformes        serranidae     epinephelus
## 83            perciformes        serranidae     epinephelus
## 84            perciformes        serranidae     epinephelus
## 85            perciformes        serranidae     epinephelus
## 86            perciformes        serranidae  hypoplectrodes
## 87            perciformes        serranidae  hypoplectrodes
## 88            perciformes        serranidae    mycteroperca
## 89            perciformes        serranidae      paralabrax
## 90            perciformes        serranidae      paralabrax
## 91            perciformes        serranidae    plectropomus
## 92            perciformes        serranidae    plectropomus
## 93            perciformes        serranidae        serranus
## 94            perciformes        serranidae        serranus
## 95            perciformes          sparidae           sarpa
## 96            perciformes          sparidae          sparus
## 97          salmoniformes        salmonidae    oncorhynchus
## 98          salmoniformes        salmonidae    oncorhynchus
## 99          salmoniformes        salmonidae    oncorhynchus
## 100         salmoniformes        salmonidae           salmo
## 101         salmoniformes        salmonidae           salmo
## 102       scorpaeniformes          cottidae          cottus
## 103       scorpaeniformes          cottidae          cottus
## 104       scorpaeniformes          cottidae          cottus
## 105       scorpaeniformes        sebastidae        sebastes
## 106       scorpaeniformes        sebastidae        sebastes
## 107       scorpaeniformes        sebastidae        sebastes
## 108       scorpaeniformes        sebastidae        sebastes
## 109       scorpaeniformes        sebastidae        sebastes
## 110          siluriformes       ictaluridae       ictalurus
## 111       syngnathiformes      syngnathidae     hippocampus
## 112       syngnathiformes      syngnathidae        nerophis
## 113 tetraodontiformes\xa0    tetraodontidae    canthigaster
## 114       accipitriformes      accipitridae          aquila
## 115       accipitriformes      accipitridae           buteo
## 116       accipitriformes      accipitridae       circaetus
## 117       accipitriformes      accipitridae      hieraaetus
## 118       accipitriformes      accipitridae      hieraaetus
## 119       accipitriformes      accipitridae        neophron
## 120          anseriformes          anatidae            anas
## 121        apterygiformes       apterygidae         apteryx
## 122      caprimulgiformes     caprimulgidae     caprimulgus
## 123       charadriiformes    haematopodidae      haematopus
## 124         columbidormes        columbidae     scardafella
## 125         columbiformes        columbidae         columba
## 126         columbiformes        columbidae    streptopelia
## 127         coraciiformes        coraciidae        coracias
## 128         coraciiformes          upupidae           upupa
## 129          cuculiformes         cuculidae        clamator
## 130          cuculiformes         cuculidae         cuculus
## 131          cuculiformes         cuculidae       geococcyx
## 132          cuculiformes         cuculidae     neopmorphus
## 133         falconiformes      accipitridae       accipiter
## 134         falconiformes      accipitridae       accipiter
## 135         falconiformes      accipitridae       accipiter
## 136         falconiformes      accipitridae       accipiter
## 137         falconiformes      accipitridae           buteo
## 138         falconiformes      accipitridae           buteo
## 139         falconiformes      accipitridae           buteo
## 140         falconiformes      accipitridae          circus
## 141         falconiformes      accipitridae          circus
## 142         falconiformes      accipitridae          milvus
## 143         falconiformes        falconidae        caracara
## 144         falconiformes        falconidae        daptrius
## 145         falconiformes        falconidae           falco
## 146         falconiformes        falconidae           falco
## 147         falconiformes        falconidae           falco
## 148         falconiformes        falconidae           falco
## 149         falconiformes        falconidae           falco
## 150           galliformes       phasianidae          bonasa
## 151           galliformes       phasianidae    centrocercus
## 152           galliformes       phasianidae     dendragapus
## 153           galliformes       phasianidae         lagopus
## 154           galliformes       phasianidae          perdix
## 155           galliformes       phasianidae          tetrao
## 156           galliformes       phasianidae          tetrao
## 157           galliformes       phasianidae     typmanuchus
## 158            gruiformes          rallidae        aramides
## 159            gruiformes          rallidae            crex
## 160            gruiformes          rallidae          rallus
## 161         passeriformes    acrocephalisae       hippolais
## 162         passeriformes      aegithalidae      aegithalos
## 163         passeriformes         alaudidae         lululla
## 164         passeriformes      cardinalidae           habia
## 165         passeriformes      cardinalidae           habia
## 166         passeriformes         certhidae         certhia
## 167         passeriformes      cisticolidae       cisticola
## 168         passeriformes          corvidae          corvus
## 169         passeriformes          corvidae       nucifraga
## 170         passeriformes        cotingidae       phytotoma
## 171         passeriformes       emberizidae      ammodramus
## 172         passeriformes       emberizidae       passerina
## 173         passeriformes       emberizidae          pipilo
## 174         passeriformes       emberizidae          pipilo
## 175         passeriformes       emberizidae        spizella
## 176         passeriformes       emberizidae        spizella
## 177         passeriformes      fringillidae       carduelis
## 178         passeriformes      fringillidae       fringilla
## 179         passeriformes      fringillidae         serinus
## 180         passeriformes         icteridae       sturnella
## 181         passeriformes         icteridae       sturnella
## 182         passeriformes          incertae         icteria
## 183         passeriformes          laniidae         laniuis
## 184         passeriformes          laniidae         laniuis
## 185         passeriformes          laniidae          lanius
## 186         passeriformes          laniidae          lanius
## 187         passeriformes           mimidae           mimus
## 188         passeriformes      motacillidae       motacilla
## 189         passeriformes      motacillidae       motacilla
## 190         passeriformes      muscicapidae       muscicapa
## 191         passeriformes      muscicapidae        oenanthe
## 192         passeriformes      muscicapidae     phoenicurus
## 193         passeriformes      muscicapidae        saxicola
## 194         passeriformes           paridae           parus
## 195         passeriformes           paridae           parus
## 196         passeriformes           paridae           parus
## 197         passeriformes           paridae           parus
## 198         passeriformes         parulidae  geothlypis\xa0
## 199         passeriformes         parulidae      geothylpis
## 200         passeriformes         parulidae    protonotaria
## 201         passeriformes         parulidae         seiurus
## 202         passeriformes         parulidae       setophaga
## 203         passeriformes         parulidae       setophaga
## 204         passeriformes         parulidae       setophaga
## 205         passeriformes         parulidae       setophaga
## 206         passeriformes         parulidae       setophaga
## 207         passeriformes         parulidae       setophaga
## 208         passeriformes         parulidae       setophaga
## 209         passeriformes         parulidae        wilsonia
## 210         passeriformes    phylloscopidae    phylloscopus
## 211         passeriformes ptilonorhynchidae    scenopoeetes
## 212         passeriformes         regulidae         regulus
## 213         passeriformes         regulidae         regulus
## 214         passeriformes         stittidae           sitta
## 215         passeriformes          sylvidae         chamaea
## 216         passeriformes         sylviidae          sylvia
## 217         passeriformes         sylviidae          sylvia
## 218         passeriformes     troglodytidae      thryomanes
## 219         passeriformes     troglodytidae     thryothorus
## 220         passeriformes     troglodytidae     troglodytes
## 221         passeriformes     troglodytidae     troglodytes
## 222         passeriformes          turdidae          sialia
## 223         passeriformes        tyrannidae        contopus
## 224         passeriformes        tyrannidae       empidonax
## 225         passeriformes        tyrannidae       empidonax
## 226         passeriformes        tyrannidae        tyrannus
## 227         passeriformes        vireonidae           vireo
## 228         passeriformes        vireonidae           vireo
## 229         passeriformes        vireonidae           vireo
## 230         passeriformes        vireonidae           vireo
## 231        pelecaniformes          ardeidae        botaurus
## 232        pelecaniformes          ardeidae      ixobrychus
## 233            piciformes           picidae       dryocopus
## 234            piciformes           picidae            jynx
## 235            piciformes           picidae        picoides
## 236            piciformes           picidae        picoides
## 237            piciformes           picidae        picoides
## 238            piciformes           picidae           picus
## 239            piciformes           picidae           picus
## 240        psittaciformes       strigopidae        strigops
## 241            rheiformes           rheidae            rhea
## 242            rheiformes           rheidae            rhea
## 243          strigiformes         strigidae        aegolius
## 244          strigiformes         strigidae            asio
## 245          strigiformes         strigidae          athene
## 246          strigiformes         strigidae            bubo
## 247          strigiformes         strigidae            bubo
## 248          strigiformes         strigidae      glaucidium
## 249          strigiformes         strigidae          nyctea
## 250          strigiformes         strigidae           strix
## 251          strigiformes         tytonidae            tyto
## 252      struthioniformes     struthionidae        struthio
## 253          tinamiformes         tinamidae     nothoprocta
## 254          afrosoricida   chrysochloridae    chrysospalax
## 255          afrosoricida   chrysochloridae      eremitalpa
## 256          artiodactyla    antilocapridae     antilocapra
## 257          artiodactyla           bovidae       aepyceros
## 258          artiodactyla           bovidae      alcelaphus
## 259          artiodactyla           bovidae      ammotragus
## 260          artiodactyla           bovidae           bison
## 261          artiodactyla           bovidae           bison
## 262          artiodactyla           bovidae           capra
## 263          artiodactyla           bovidae           capra
## 264          artiodactyla           bovidae     cephalophus
## 265          artiodactyla           bovidae     cephalophus
## 266          artiodactyla           bovidae         gazella
## 267          artiodactyla           bovidae         madoqua
## 268          artiodactyla           bovidae        oreamnos
## 269          artiodactyla           bovidae            ovis
## 270          artiodactyla           bovidae            ovis
## 271          artiodactyla           bovidae      raphicerus
## 272          artiodactyla           bovidae       rupicapra
## 273          artiodactyla           bovidae     taurotragus
## 274          artiodactyla           bovidae     tragelaphus
## 275          artiodactyla           bovidae     tragelaphus
## 276          artiodactyla          cervidae           alces
## 277          artiodactyla          cervidae            axis
## 278          artiodactyla          cervidae       capreolus
## 279          artiodactyla          cervidae          cervus
## 280          artiodactyla          cervidae          cervus
## 281          artiodactyla          cervidae            dama
## 282          artiodactyla          cervidae       muntiacus
## 283          artiodactyla          cervidae      odocoileus
## 284          artiodactyla          cervidae      odocoileus
## 285          artiodactyla          cervidae      ozotoceros
## 286          artiodactyla          cervidae            pudu
## 287          artiodactyla          cervidae        rangifer
## 288          artiodactyla        giraffidae         giraffa
## 289          artiodactyla        giraffidae          okapia
## 290          artiodactyla            suidae    phacochoerus
## 291          artiodactyla       tayassuidae       catagonus
## 292          artiodactyla       tayassuidae          pecari
## 293          artiodactyla       tayassuidae         tayassu
## 294          artiodactyla        tragulidae      hyemoschus
## 295             carnivora         ailuridae         ailurus
## 296             carnivora           canidae          alopex
## 297             carnivora           canidae           canis
## 298             carnivora           canidae     pseudalopex
## 299             carnivora           canidae     pseudalopex
## 300             carnivora           canidae          vulpes
## 301             carnivora           canidae          vulpes
## 302             carnivora           canidae          vulpes
## 303             carnivora         dipodidae      stylodipus
## 304             carnivora        eupleridae    cryptoprocta
## 305             carnivora           felidae        acinonyx
## 306             carnivora           felidae         caracal
## 307             carnivora           felidae           felis
## 308             carnivora           felidae           felis
## 309             carnivora           felidae     herpailurus
## 310             carnivora           felidae       leopardus
## 311             carnivora           felidae       leopardus
## 312             carnivora           felidae     leptailurus
## 313             carnivora           felidae            lynx
## 314             carnivora           felidae            lynx
## 315             carnivora           felidae            lynx
## 316             carnivora           felidae            lynx
## 317             carnivora           felidae       oncifelis
## 318             carnivora           felidae        panthera
## 319             carnivora           felidae        panthera
## 320             carnivora           felidae        panthera
## 321             carnivora           felidae    prionailurus
## 322             carnivora           felidae            puma
## 323             carnivora           felidae           uncia
## 324             carnivora       herpestidae          atilax
## 325             carnivora       herpestidae        cynictis
## 326             carnivora       herpestidae        helogale
## 327             carnivora       herpestidae       herpestes
## 328             carnivora       herpestidae       ichneumia
## 329             carnivora          hyanidae        proteles
## 330             carnivora        mustelidae            eira
## 331             carnivora        mustelidae        galictis
## 332             carnivora        mustelidae            gulo
## 333             carnivora        mustelidae          martes
## 334             carnivora        mustelidae          martes
## 335             carnivora        mustelidae          martes
## 336             carnivora        mustelidae          martes
## 337             carnivora        mustelidae         mustela
## 338             carnivora        mustelidae         mustela
## 339             carnivora        mustelidae         mustela
## 340             carnivora        mustelidae         mustela
## 341             carnivora        mustelidae         mustela
## 342             carnivora        mustelidae         mustela
## 343             carnivora        mustelidae         mustela
## 344             carnivora        mustelidae         taxidea
## 345             carnivora       procyonidae           potos
## 346             carnivora           ursidae      ailuropoda
## 347             carnivora           ursidae        melursus
## 348             carnivora        viverridae         genetta
## 349             carnivora        viverridae         genetta
## 350             carnivora        viverridae         viverra
## 351         dasyuromorpha        dasyuridae        dasyurus
## 352         dasyuromorpha        dasyuridae        dasyurus
## 353         dasyuromorpha        dasyuridae     sminthopsis
## 354         dasyuromorpia        dasyuridae      antechinus
## 355       didelphimorphia       didelphidae     monodelphis
## 356       didelphimorphia       didelphidae        thylamys
## 357           diprodontia      macropodidae     dendrolagus
## 358           diprodontia      macropodidae        macropus
## 359           diprodontia      macropodidae        macropus
## 360           diprodontia      macropodidae        macropus
## 361           diprodontia      macropodidae        macropus
## 362           diprodontia      macropodidae        macropus
## 363           diprodontia      macropodidae        macropus
## 364           diprodontia      macropodidae        macropus
## 365           diprodontia      macropodidae       petrogale
## 366           diprodontia        potoroidae       bettongia
## 367           diprodontia        potoroidae        potorous
## 368           diprodontia   pseudocheiridae     petauroides
## 369         diprotodontia      macropodidae     onychogalea
## 370         diprotodontia      macropodidae       thylogale
## 371         diprotodontia      macropodidae       thylogale
## 372         diprotodontia      macropodidae        wallabia
## 373         diprotodontia     phalangeridae     trichosurus
## 374         diprotodontia        vombatidae     lasiorhinus
## 375         diprotodontia        vombatidae        vombatus
## 376        erinaceomorpha       erinaceidae       erinaceus
## 377        erinaceomorpha       erinaceidae     hemiechinus
## 378            lagomorpha         leporidae     brachylagus
## 379            lagomorpha         leporidae           lepus
## 380            lagomorpha         leporidae           lepus
## 381            lagomorpha         leporidae           lepus
## 382            lagomorpha         leporidae           lepus
## 383            lagomorpha         leporidae           lepus
## 384            lagomorpha         leporidae           lepus
## 385            lagomorpha         leporidae           lepus
## 386            lagomorpha         leporidae     oryctolagus
## 387            lagomorpha         leporidae      sylvilagus
## 388            lagomorpha         leporidae      sylvilagus
## 389            lagomorpha         leporidae      sylvilagus
## 390            lagomorpha       ochotonidae        ochotona
## 391            lagomorpha       ochotonidae        ochotona
## 392         macroscelidea   macroscelididae    elephantulus
## 393         macroscelidea   macroscelididae     petrodromus
## 394         macroscelidea   macroscelididae     rhynchocyon
## 395          monotrematae    tachyglossidae    tachyoryctes
## 396       peramelemorphia       peramelidae         isoodon
## 397       peramelemorphia       peramelidae         isoodon
## 398        perissodactyla           equidae           equus
## 399        perissodactyla    rhinocerotidae   ceratotherium
## 400        perissodactyla    rhinocerotidae         diceros
## 401                pilosa      bradypodidae        bradypus
## 402           proboscidea      elephantidae         elephas
## 403           proboscidea      elephantidae       loxodonta
## 404                 roden        cricetidae       onychomys
## 405              rodentia     aplodontiidae      aplodontia
## 406              rodentia      bathyergidae      bathyergus
## 407              rodentia      bathyergidae       cryptomys
## 408              rodentia      bathyergidae       cryptomys
## 409              rodentia      bathyergidae       georychus
## 410              rodentia      bathyergidae    heliophobius
## 411              rodentia      bathyergidae  heterocephalus
## 412              rodentia          caviidae      dolichotus
## 413              rodentia     chinchillidae      lagostomus
## 414              rodentia        cricetidae   clethrionomys
## 415              rodentia        cricetidae       hylaeamys
## 416              rodentia        cricetidae          lemmus
## 417              rodentia        cricetidae        microtus
## 418              rodentia        cricetidae        microtus
## 419              rodentia        cricetidae        microtus
## 420              rodentia        cricetidae        microtus
## 421              rodentia        cricetidae        microtus
## 422              rodentia        cricetidae        microtus
## 423              rodentia        cricetidae        microtus
## 424              rodentia        cricetidae          myopus
## 425              rodentia        cricetidae         neotoma
## 426              rodentia        cricetidae         neotoma
## 427              rodentia        cricetidae         neotoma
## 428              rodentia        cricetidae         neotoma
## 429              rodentia        cricetidae         ondatra
## 430              rodentia        cricetidae      peromyscus
## 431              rodentia        cricetidae reithrodontomys
## 432              rodentia        cricetidae      synaptomys
## 433              rodentia         dipodidae      pygeretmus
## 434              rodentia        echimyidae      proechimys
## 435              rodentia        echimyidae      proechimys
## 436              rodentia    erethizontidae         coendou
## 437              rodentia    erethizontidae       erethizon
## 438              rodentia         geomyidae        thomomys
## 439              rodentia          gliridae      graphiurus
## 440              rodentia          gliridae     muscardinus
## 441              rodentia      heteromyidae       dipodomys
## 442              rodentia      heteromyidae       dipodomys
## 443              rodentia      heteromyidae       dipodomys
## 444              rodentia      heteromyidae       dipodomys
## 445              rodentia      heteromyidae       dipodomys
## 446              rodentia       hystricidae         hystrix
## 447              rodentia       hystricidae         hystrix
## 448              rodentia       hystridicae       atherurus
## 449              rodentia           muridae        apodemus
## 450              rodentia           muridae        apodemus
## 451              rodentia           muridae        meriones
## 452              rodentia           muridae       pseudomys
## 453              rodentia        nesomyidae      hypogeomys
## 454              rodentia        nesomyidae         nesomys
## 455              rodentia        nesomyidae         nesomys
## 456              rodentia      octodontidae      spalacopus
## 457              rodentia         sciuridae        eutamias
## 458              rodentia         sciuridae      funambulus
## 459              rodentia         sciuridae       glaucomys
## 460              rodentia         sciuridae       glaucomys
## 461              rodentia         sciuridae         marmota
## 462              rodentia         sciuridae         marmota
## 463              rodentia         sciuridae       paraxerus
## 464              rodentia         sciuridae         sciurus
## 465              rodentia         sciuridae         sciurus
## 466              rodentia         sciuridae         sciurus
## 467              rodentia         sciuridae         sciurus
## 468              rodentia         sciuridae         sciurus
## 469              rodentia         sciuridae    spermophilus
## 470              rodentia         sciuridae    spermophilus
## 471              rodentia         sciuridae    spermophilus
## 472              rodentia         sciuridae    spermophilus
## 473              rodentia         sciuridae    spermophilus
## 474              rodentia         sciuridae    spermophilus
## 475              rodentia         sciuridae    spermophilus
## 476              rodentia         sciuridae          tamias
## 477              rodentia         sciuridae          tamias
## 478              rodentia         sciuridae          tamias
## 479              rodentia         sciuridae          tamias
## 480              rodentia         sciuridae    tamiasciurus
## 481              rodentia         sciuridae           xerus
## 482          soricomorpha         soricidae       crocidura
## 483          soricomorpha         soricidae           sorex
## 484          soricomorpha         soricidae           sorex
## 485          soricomorpha         soricidae           sorex
## 486          soricomorpha         soricidae           sorex
## 487          soricomorpha         soricidae           sorex
## 488          soricomorpha          talpidae       condylura
## 489          soricomorpha          talpidae        scalopus
## 490          soricomorpha          talpidae           talpa
## 491          soricomorpha          talpidae           talpa
## 492              squamata          agamidae       uromastyx
## 493              squamata        colubridae       carphopis
## 494              squamata        colubridae       carphopis
## 495              squamata        colubridae         coluber
## 496              squamata        colubridae         coluber
## 497              squamata        colubridae       diadophis
## 498              squamata        colubridae      drymarchon
## 499              squamata        colubridae          elaphe
## 500              squamata        colubridae          elaphe
## 501              squamata        colubridae       heterodon
## 502              squamata        colubridae       hierophis
## 503              squamata        colubridae    lampropeltis
## 504              squamata        colubridae    lampropeltis
## 505              squamata        colubridae     masticophis
## 506              squamata        colubridae          natrix
## 507              squamata        colubridae         nerodia
## 508              squamata        colubridae         nerodia
## 509              squamata        colubridae      oocatochus
## 510              squamata        colubridae       pituophis
## 511              squamata        colubridae       pituophis
## 512              squamata        colubridae      thamnophis
## 513              squamata        colubridae      thamnophis
## 514              squamata        colubridae         zamenis
## 515              squamata          elapidae   hoplocephalus
## 516              squamata          elapidae        notechis
## 517              squamata          elapidae      pseudechis
## 518              squamata         iguanidae      conolophus
## 519              squamata         iguanidae         cyclura
## 520              squamata         iguanidae         cyclura
## 521              squamata         iguanidae         cyclura
## 522              squamata         iguanidae      sauromalus
## 523              squamata         iguanidae      sauromalus
## 524              squamata        lacertilia     dipsosaurus
## 525              squamata        lacertilia        gallotia
## 526              squamata       liolaemidae      phymaturus
## 527              squamata        pythonidae         morelia
## 528              squamata         scincidae         egernia
## 529              squamata         viperidae     agkistrodon
## 530              squamata         viperidae     agkistrodon
## 531              squamata         viperidae           bitis
## 532              squamata         viperidae        bothrops
## 533              squamata         viperidae        crotalus
## 534              squamata         viperidae        crotalus
## 535              squamata         viperidae        crotalus
## 536              squamata         viperidae        crotalus
## 537              squamata         viperidae        crotalus
## 538              squamata         viperidae        crotalus
## 539              squamata         viperidae        crotalus
## 540              squamata         viperidae        crotalus
## 541              squamata         viperidae        gloydius
## 542              squamata         viperidae     montivipera
## 543              squamata         viperidae          vipera
## 544            testudines          chelidae       chelodina
## 545            testudines          chelidae     mesoclemmys
## 546            testudines       chelydridae        chelydra
## 547            testudines          emydidae       chrysemys
## 548            testudines          emydidae     deirochelys
## 549            testudines          emydidae       emydoidea
## 550            testudines          emydidae            emys
## 551            testudines          emydidae       graptemys
## 552            testudines          emydidae       terrapene
## 553            testudines       geoemydidae        mauremys
## 554            testudines     kinosternidae     kinosternon
## 555            testudines     kinosternidae    sternotherus
## 556            testudines     kinosternidae    sternotherus
## 557            testudines      testudinidae      geochelone
## 558            testudines      testudinidae        gopherus
## 559            testudines      testudinidae        gopherus
## 560            testudines      testudinidae     indotestudo
## 561            testudines      testudinidae         kinixys
## 562            testudines      testudinidae        manouria
## 563            testudines      testudinidae     psammobates
## 564            testudines      testudinidae    stigmochelys
## 565            testudines      testudinidae         testudo
## 566            testudines      testudinidae         testudo
## 567            testudines      testudinidae         testudo
## 568            testudines      testudinidae         testudo
## 569            testudines      trionychidae         apalone
##                      species
## 1                   rostrata
## 2                  poecilura
## 3                   anomalum
## 4                funduloides
## 5                 cataractae
## 6                masquinongy
## 7                 pollachius
## 8                     virens
## 9                   lineatus
## 10                 lituratus
## 11                 unicornis
## 12                atlanticus
## 13                 ignobilis
## 14                 rupestris
## 15                  gibbosus
## 16               macrochirus
## 17                 megalotis
## 18                  dolomieu
## 19                 salmoides
## 20                 annularis
## 21                 baronessa
## 22                 trichrous
## 23              trifascialis
## 24              trifasciatus
## 25              unimaculatus
## 26              spectrabilis
## 27                     pinos
## 28                     falco
## 29                marmoratus
## 30                  japonica
## 31                     dalli
## 32                  hipoliti
## 33                 nicholsii
## 34               longipinnis
## 35                 sectatrix
## 36                     rufus
## 37                 undulatus
## 38                     julis
## 39                bivittatus
## 40                   garnoti
## 41               maculipinna
## 42                     poeyi
## 43                dimidiatus
## 44                  bergylta
## 45                lineolatus
## 46                   pulcher
## 47                 adspersus
## 48               bifasciatum
## 49                    lunare
## 50                     harak
## 51                    analis
## 52                    apodus
## 53                decussatus
## 54                   griseus
## 55                 chrysurus
## 56                  princeps
## 57                    labrax
## 58             flavolineatus
## 59                porphyreus
## 60                flavescens
## 61                   luridus
## 62                      argi
## 63                   chromis
## 64                biocellata
## 65                   aruanus
## 66                     wardi
## 67                  apicalis
## 68                  partitus
## 69                variabilis
## 70               microrhinos
## 71                     iseri
## 72                 rivulatus
## 73              aurofrenatum
## 74              chrysopterum
## 75                rubripinne
## 76                    viride
## 77                     argus
## 78                 cruentata
## 79               hemistiktos
## 80                   miniata
## 81                  guttatus
## 82                marginatus
## 83                     morio
## 84                  striatus
## 85                   tauvina
## 86                    huntii
## 87               maccullochi
## 88                    bonaci
## 89                clathratus
## 90                 nebulifer
## 91                 areolatus
## 92                 leopardus
## 93                  cabrilla
## 94                    scriba
## 95                     salpa
## 96                   auratus
## 97                    clarki
## 98                     gilae
## 99                    mykiss
## 100                    salar
## 101                   trutta
## 102                   bairdi
## 103                carolinae
## 104                    gobio
## 105                 caurinus
## 106                  inermis
## 107                  maliger
## 108                 melanops
## 109                 mustinus
## 110                  natalis
## 111               guttulatus
## 112           lumbriciformis
## 113                 rostrata
## 114               chrysaetos
## 115                    buteo
## 116                 gallicus
## 117                fasciatus
## 118                 pennatus
## 119             percnopterus
## 120                 strepera
## 121                australis
## 122                europaeus
## 123               ostralegus
## 124                     inca
## 125                 palumbus
## 126                   turtur
## 127                 garrulus
## 128                    epops
## 129               glandarius
## 130                  canorus
## 131            californianus
## 132               radiolosus
## 133                 cooperii
## 134                 gentilis
## 135                    nisus
## 136                 striatus
## 137              jamaicensis
## 138                 lineatus
## 139                swainsoni
## 140                  cyaneus
## 141                 pygargus
## 142                   milvus
## 143                 cheriway
## 144               americanus
## 145                biarmicus
## 146                mexicanus
## 147               peregrinus
## 148               sparverius
## 149              tinnunculus
## 150                  bonasia
## 151             urophasianus
## 152                 obscurus
## 153                  lagopus
## 154                   perdix
## 155                   tetrix
## 156                urogallus
## 157          cupido pinnatus
## 158                    wolfi
## 159                     crex
## 160                  elegans
## 161               polyglotta
## 162                 caudatus
## 163                  arborea
## 164               fuscicauda
## 165                   rubica
## 166               familiaris
## 167                 juncidis
## 168                    corax
## 169            caryocatactes
## 170                raimondii
## 171               savannarum
## 172                   cyanea
## 173                   aberti
## 174                   fuscus
## 175                  arborea
## 176                passerina
## 177                cannabina
## 178                  coelebs
## 179                  serinus
## 180                    magna
## 181                 neglecta
## 182                   virens
## 183                 collurio
## 184             ludovicianus
## 185                    minor
## 186                  senator
## 187              polyglottos
## 188                     alba
## 189                    flava
## 190                  striata
## 191                 oenanthe
## 192              phoenicurus
## 193                  rubetra
## 194             atricapillus
## 195             carolinensis
## 196                inornatus
## 197                palustris
## 198             philadelphia
## 199                  trichas
## 200                   citrea
## 201             aurocapillus
## 202                    fusca
## 203                kirtlandi
## 204                 magnolia
## 205             pensylvanica
## 206                 petechia
## 207                ruticilla
## 208                   virens
## 209               canadensis
## 210                  bonelli
## 211             dentirostris
## 212             ignicapillus
## 213                  regulus
## 214                 europaea
## 215                 fasciata
## 216                    sarda
## 217                   undata
## 218                 bewickiI
## 219             ludovicianus
## 220                    aedon
## 221              troglodytes
## 222                   sialis
## 223                   virens
## 224                  minimus
## 225                 wrightii
## 226                 tyrannus
## 227             atricapillus
## 228                    belli
## 229                  griseus
## 230                olivaceus
## 231                stellaris
## 232                   exilis
## 233                  martius
## 234                torquilla
## 235                 leucotos
## 236                   medius
## 237              tridactylus
## 238                    canus
## 239                  viridis
## 240              habroptilus
## 241                americana
## 242                  pennata
## 243                 funereus
## 244                     otus
## 245                   noctua
## 246                     bubo
## 247              virginianus
## 248               passerinum
## 249                scandiaca
## 250                    aluco
## 251                     alba
## 252                  camelus
## 253                   ornata
## 254               trevelyani
## 255                   granti
## 256                americana
## 257                 melampus
## 258               buselaphus
## 259                   lervia
## 260                    bison
## 261                  bonasus
## 262                   hircus
## 263                pyrenaica
## 264               callipygus
## 265                 dorsalis
## 266                  gazella
## 267                guentheri
## 268               americanus
## 269                    ammon
## 270               canadensis
## 271               campestris
## 272                rupicapra
## 273                     oryx
## 274                 scriptus
## 275             strepsiceros
## 276                    alces
## 277                     axis
## 278                capreolus
## 279                  elaphus
## 280                   nippon
## 281                     dama
## 282                  reevesi
## 283                 hemionus
## 284              virginianus
## 285              bezoarticus
## 286                     puda
## 287                 tarandus
## 288           camelopardalis
## 289                johnstoni
## 290              aethiopicus
## 291                  wagneri
## 292                   tajacu
## 293                   pecari
## 294                aquaticus
## 295                  fulgens
## 296                  lagopus
## 297                 simensis
## 298                 culpaeus
## 299                  griseus
## 300                  macroti
## 301                 ruppelli
## 302                    velox
## 303                    telum
## 304                    ferox
## 305                  jubatus
## 306                  caracal
## 307                    catus
## 308               sylvestris
## 309             yagouaroundi
## 310                 pardalis
## 311                   wiedii
## 312                   serval
## 313               canadensis
## 314                     lynx
## 315                 pardinus
## 316                    rufus
## 317                geoffroyi
## 318                     onca
## 319                   pardus
## 320                   tigris
## 321              bengalensis
## 322                 concolor
## 323                    uncia
## 324              paludinosus
## 325              penicillata
## 326                  parvula
## 327               inchneumon
## 328                albicauda
## 329                cristatus
## 330                  barbata
## 331                  vittata
## 332                     gulo
## 333                americana
## 334                    foina
## 335                   martes
## 336                 pennanti
## 337                  erminea
## 338                  frenata
## 339                     furo
## 340                 lutreola
## 341                 nigripes
## 342                  nivalis
## 343                 sibirica
## 344                    taxus
## 345                   flavus
## 346              melanoleuca
## 347                  ursinus
## 348                  genetta
## 349                  tigrina
## 350                  zibetha
## 351                geoffroii
## 352                maculatus
## 353                 leucopus
## 354                 stuartii
## 355                americana
## 356                  elegans
## 357                lumholtzi
## 358              antilopinus
## 359                 dorsalis
## 360              fuliginosus
## 361                giganteus
## 362                 robustus
## 363              rufogriseus
## 364                    rufus
## 365                assimilis
## 366                 gaimardi
## 367                 longipes
## 368                   volans
## 369                 fraenata
## 370               stigmatica
## 371                   thetis
## 372                  bicolor
## 373                vulpecula
## 374                 krefftii
## 375                  ursinus
## 376                europaeus
## 377                  auritus
## 378               idahoensis
## 379               americanus
## 380                 arcticus
## 381             californicus
## 382                 capensis
## 383                europaeus
## 384              nigricollis
## 385                  timidus
## 386                cuniculus
## 387                aquaticus
## 388               floridanus
## 389                palustris
## 390                curzoniae
## 391                 princeps
## 392                rufescens
## 393            tetradactylus
## 394              chrysopygus
## 395                splendens
## 396                  auratus
## 397                 obesulus
## 398                 caballus
## 399                    simum
## 400                 bicornis
## 401                torquatus
## 402                  maximus
## 403                 africana
## 404                 torridus
## 405                     rufa
## 406                  suillus
## 407               damarensis
## 408              hottentotus
## 409                 capensis
## 410         argenteocinereus
## 411                   glaber
## 412                patagonus
## 413                  maximus
## 414             californicus
## 415             megacephalus
## 416                sibiricus
## 417                 agrestis
## 418             californicus
## 419                 montanus
## 420              ochrogaster
## 421           pennsylvanicus
## 422                pinetorum
## 423              richardsoni
## 424             schisticolor
## 425                  cinerea
## 426                 fuscipes
## 427                   lepida
## 428                 micropus
## 429                zibethica
## 430               gossypinus
## 431              raviventris
## 432                  cooperi
## 433                  pumilio
## 434                  cuvieri
## 435             semispinosus
## 436              prehensilis
## 437                 dorsatum
## 438                   bottae
## 439                 ocularis
## 440             avellanarius
## 441                   ingens
## 442                 merriami
## 443                    ordii
## 444              spectabilis
## 445                stephensi
## 446         africaeaustralis
## 447                   indica
## 448                africanus
## 449              flavicollis
## 450               sylvaticus
## 451                hurrianae
## 452                   fuscus
## 453                 antimena
## 454                audeberti
## 455                    rufus
## 456                   cyanus
## 457                sibiricus
## 458                 pennanti
## 459                 sabrinus
## 460                   volans
## 461             flaviventris
## 462                    monax
## 463                palliatus
## 464                   aberti
## 465             carolinensis
## 466                      lis
## 467                    niger
## 468                 vulgaris
## 469                 beecheyi
## 470              columbianus
## 471               franklinii
## 472                  parryii
## 473                spilosoma
## 474         tridecemlineatus
## 475               variegatus
## 476                  amoenus
## 477                  minimus
## 478           quadrivittatus
## 479                 umbrinus
## 480               hudsonicus
## 481               erythropus
## 482                  russula
## 483                 arcticus
## 484                 cinereus
## 485                coronatus
## 486              gracillimus
## 487             unguiculatus
## 488                 cristata
## 489                aquaticus
## 490                 europaea
## 491                   romana
## 492                aegyptius
## 493                   vermis
## 494                  viridis
## 495              constrictor
## 496 constrictor flaviventris
## 497                punctatus
## 498                  couperi
## 499           guttata emoryi
## 500                 obsoleta
## 501              platirhinos
## 502             viridiflavus
## 503            getula getula
## 504               triangulum
## 505                flagellum
## 506                   natrix
## 507            erythrogaster
## 508                 sipeodon
## 509             rufodorsatus
## 510                catenifer
## 511             melanoleucus
## 512                  butleri
## 513                    gigal
## 514              longissimus
## 515              bungaroides
## 516                 scutatus
## 517             porphyriacus
## 518                 pallidus
## 519                  cyclura
## 520                   lewisi
## 521                  pinguis
## 522                 hispidua
## 523                   obesus
## 524                 dorsalis
## 525                  galloti
## 526              flagellifer
## 527        spilota imbricata
## 528                    major
## 529               contortrix
## 530              piscivorous
## 531               schneideri
## 532                    asper
## 533                    atrox
## 534                 cerastes
## 535                 horridus
## 536                 molossus
## 537        oreganus concolor
## 538                   pricei
## 539               scutulatus
## 540                   tigris
## 541              shedaoensis
## 542                   raddei
## 543                 latastei
## 544              longicollis
## 545                    dahli
## 546               serpentina
## 547          picta marginata
## 548              reticularia
## 549               blandingii
## 550              orbicularis
## 551            flavimaculata
## 552                   ornata
## 553                  leprosa
## 554                rubrubrum
## 555           minor peltifer
## 556                 odoratus
## 557               carbonaria
## 558                agassizii
## 559               polyphemus
## 560             travancorica
## 561                   spekii
## 562                 impressa
## 563                tentorius
## 564                 pardalis
## 565                   graeca
## 566                 hermanii
## 567               horsfieldi
## 568               kleinmanni
## 569                spinifera
```

##### There are 9 taxon represented in the data frame 'homerange': birds, lake fishes, lizards, mammals, marine fishes, river fishes, snakes, tortoises, and turtles.


```r
levels(taxon) #the taxon represented in the data frame homerange
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


#### 5. The variable `taxon` identifies the common name groups of the species represented in `homerange`. Make a table the shows the counts for each of these `taxon`.  

Counts for each of the 'taxon':


```r
table(homerange$taxon) #counts
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```

Table for 'taxon' counts:


```r
taxon_table <- data.frame(table(taxon))
taxon_table <- rename(taxon_table, counts=Freq)
taxon_table #table
```

```
##           taxon counts
## 1         birds    140
## 2   lake fishes      9
## 3       lizards     11
## 4       mammals    238
## 5 marine fishes     90
## 6  river fishes     14
## 7        snakes     41
## 8     tortoises     12
## 9       turtles     14
```

#### 6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.  

##### There are two trophic guilds in the 'homerange' data frame, there are 342 species represented in the carnivore category, and 227 species represented in the herbivore category.


```r
table(homerange$trophic_guild)
```

```
## 
## carnivore herbivore 
##       342       227
```

#### 7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.   

Note: completed in lab day 6 and as homework.  

Carnivores Data Frame:   


```r
carnivores <- filter(homerange, trophic_guild == "carnivore")
```

Herbivores Data Frame:   


```r
herbivores <- filter(homerange, trophic_guild == "herbivore")
```

#### 8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.   

Note: completed in lab day 6 and as homework.   


```r
carnivores_mean_hra_m2 <- mean(carnivores$mean_hra_m2, rm.NA = T)
carnivores_mean_hra_m2
```

```
## [1] 13039918
```


```r
herbivores_mean_hra_m2 <- mean(herbivores$mean_hra_m2, rm.NA = T)
herbivores_mean_hra_m2
```

```
## [1] 34137012
```


```r
herbivores_mean_hra_m2 > carnivores_mean_hra_m2
```

```
## [1] TRUE
```

##### Herbivores have, on average, a larger `mean_hra_m2` than carnivores.

#### 9. Make a new dataframe `owls` that is limited to the mean mass, log10 mass, family, genus, and species of owls in the database. Which is the smallest owl? What is its common name? Do a little bit of searching online to see what you can learn about this species and provide a link below   

Note: completed in lab day 6 and as homework.   

Owls Data Frame:


```r
owls_selected <- filter(homerange, order == "strigiformes")
owls <- select(owls_selected, "family", "genus", "species", "mean_mass_g", "log10_mass")
owls
```

```
##      family      genus     species mean_mass_g log10_mass
## 1 strigidae   aegolius    funereus      119.00   2.075547
## 2 strigidae       asio        otus      252.00   2.401401
## 3 strigidae     athene      noctua      156.50   2.194514
## 4 strigidae       bubo        bubo     2191.00   3.340642
## 5 strigidae       bubo virginianus     1510.00   3.178977
## 6 strigidae glaucidium  passerinum       61.32   1.787602
## 7 strigidae     nyctea   scandiaca     1920.00   3.283301
## 8 strigidae      strix       aluco      519.00   2.715167
## 9 tytonidae       tyto        alba      285.00   2.454845
```


```r
summary(owls$mean_mass_g)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   61.32  156.50  285.00  779.31 1510.00 2191.00
```

The smallest owl weighs 61.32 grams, the minimum mean_mass_g value.

Identifying the Smallest Owl:   


```r
filter(homerange, mean_mass_g == 61.32)
```

```
##   taxon        common_name class        order    family      genus    species
## 1 birds Eurasian pygmy owl  aves strigiformes strigidae glaucidium passerinum
##   primarymethod    n mean_mass_g log10_mass alternative_mass_reference
## 1    telemetry* <NA>       61.32   1.787602                       <NA>
##   mean_hra_m2 log10_hra
## 1     1250000   6.09691
##                                                                                                                                                                            hra_reference
## 1 Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
##         realm thermoregulation locomotion trophic_guild dimension preymass
## 1 terrestrial        endotherm     flying     carnivore        3D    16.99
##   log10_preymass ppmr
## 1       1.230193 3.61
##                                                                                                                                                 prey_size_reference
## 1 Slagsvold T, Sonerud GA. 2007. Prey size and ingestion rate in raptors: importance for sex roles and reversed sexual size dimorphism. J. Avian Biol. 38: 650 661.
```

##### The smallest owl is Glaucidium passerinum. Its common name is the Eurasian pygmy owl.

##### The Eurasian pygmy owl is the smallest owl of Europe. It is native to the central area of the Palearctic region, and lives in coniferous forests. Due to their large feet and legs, they can catch prey, which are typically small mammals and birds, up to their own size. Their typical lifespan is 6 years.    

##### More about the [Eurasian pygmy owl](https://animaldiversity.org/accounts/Glaucidium_passerinum/)

#### 10. As measured by the data, which bird species has the largest homerange? Show all of your work, please. Look this species up online and tell me about it!.    

Note: completed in lab day 6 and as homework.   


```r
homerange %>% #searching within the homerange data frame
  filter(taxon == "birds") %>% #filtering for bird species
  select(species, mean_hra_m2) %>% #selecting the desired columns
  arrange(desc(mean_hra_m2)) #arranging the data to have the largest homerange value shown first
```

```
##             species  mean_hra_m2
## 1          cheriway 241000000.00
## 2          pygargus 200980000.00
## 3        peregrinus 153860000.00
## 4          pennatus 117300000.00
## 5           camelus  84300000.00
## 6          gallicus  78500000.00
## 7            turtur  63585000.00
## 8      percnopterus  63570000.00
## 9             buteo  50240000.00
## 10        biarmicus  50000000.00
## 11         strepera  45912000.00
## 12         gentilis  40000000.00
## 13          canorus  38460000.00
## 14            corax  28000000.00
## 15       chrysaetos  27550000.00
## 16        mexicanus  25778434.50
## 17          pennata  23880000.00
## 18           milvus  19625000.00
## 19        fasciatus  19620000.00
## 20             otus  19620000.00
## 21     urophasianus  18158215.95
## 22             bubo  16000000.00
## 23            epops  12560000.00
## 24       glandarius  12560000.00
## 25  cupido pinnatus  12030000.00
## 26            nisus   7100000.00
## 27        urogallus   5500000.00
## 28         leucotos   5306600.00
## 29        scandiaca   4937157.00
## 30            canus   4521600.00
## 31      jamaicensis   4249192.50
## 32          martius   3500000.00
## 33        cannabina   3140000.00
## 34         funereus   3140000.00
## 35      tinnunculus   3000000.00
## 36         palumbus   2540000.00
## 37          cyaneus   2521187.55
## 38        swainsoni   2464531.65
## 39       ostralegus   2460000.00
## 40        americana   2450000.00
## 41         cooperii   2254095.45
## 42      virginianus   2124596.25
## 43           tetrix   1975000.00
## 44          viridis   1850000.00
## 45             alba   1500000.00
## 46       sparverius   1416397.50
## 47       passerinum   1250000.00
## 48        torquilla   1038100.00
## 49         garrulus   1000000.00
## 50         striatus    995525.10
## 51        europaeus    785000.00
## 52             alba    785000.00
## 53       americanus    666000.00
## 54         lineatus    639402.30
## 55            minor    635800.00
## 56    californianus    550000.00
## 57           noctua    500000.00
## 58       radiolosus    499000.00
## 59        australis    463900.00
## 60            aluco    356932.17
## 61      tridactylus    350000.00
## 62      habroptilus    195000.00
## 63        stellaris    193000.00
## 64           medius    141500.00
## 65    caryocatactes    132332.00
## 66          bonasia    103000.00
## 67           exilis     97000.00
## 68     dentirostris     95000.00
## 69            wolfi     90000.00
## 70         tyrannus     83769.80
## 71          arborea     82960.43
## 72          senator     80000.00
## 73     ludovicianus     75676.10
## 74           perdix     62000.00
## 75       fuscicauda     60702.75
## 76           rubica     48562.20
## 77       familiaris     47000.00
## 78           virens     44029.73
## 79          elegans     44000.00
## 80             crex     43000.00
## 81         caudatus     42000.00
## 82          coelebs     42000.00
## 83          bonelli     35000.00
## 84        kirtlandi     33993.54
## 85        raimondii     30900.00
## 86        passerina     30756.06
## 87            magna     30351.38
## 88         neglecta     30351.38
## 89       polyglotta     30000.00
## 90          lagopus     25899.84
## 91           fuscus     25899.84
## 92        inornatus     24281.10
## 93           ornata     24281.10
## 94        palustris     22662.36
## 95         europaea     21000.00
## 96          regulus     19900.00
## 97         obscurus     16996.77
## 98          arborea     16996.77
## 99     ignicapillus     16500.00
## 100          aberti     16187.40
## 101        collurio     15782.72
## 102        wrightii     15782.72
## 103        oenanthe     15378.03
## 104    carolinensis     14973.35
## 105          citrea     14973.35
## 106    atricapillus     14973.35
## 107    atricapillus     14568.66
## 108        juncidis     14400.00
## 109           belli     11735.87
## 110      savannarum     10926.50
## 111           flava     10117.13
## 112    aurocapillus     10117.13
## 113      canadensis     10117.13
## 114     troglodytes     10117.13
## 115          sialis     10117.13
## 116         serinus     10000.00
## 117         striata     10000.00
## 118    philadelphia      7689.02
## 119         rubetra      7300.00
## 120        magnolia      7284.33
## 121       olivaceus      7284.33
## 122          virens      6474.96
## 123    pensylvanica      6070.28
## 124         trichas      5260.91
## 125           fusca      5260.91
## 126        bewickiI      4856.22
## 127     phoenicurus      4500.00
## 128     polyglottos      4046.85
## 129           aedon      4046.85
## 130           sarda      3300.00
## 131        fasciata      3237.48
## 132          undata      2800.00
## 133            inca      2589.98
## 134       ruticilla      1942.49
## 135         minimus      1780.61
## 136        petechia      1699.68
## 137          virens      1335.46
## 138         griseus      1335.46
## 139    ludovicianus      1214.06
## 140          cyanea      1052.18
```

The bird species with the largest homerange as found above is the cheriway, with a homerange of 241000000.00 square meters.  


```r
filter(homerange, species == "cheriway") #filtering for the species with the largest homerange
```

```
##   taxon common_name class         order     family    genus  species
## 1 birds    caracara  aves falconiformes falconidae caracara cheriway
##   primarymethod  n mean_mass_g log10_mass alternative_mass_reference
## 1     telemetry 26        1125   3.051153                       <NA>
##   mean_hra_m2 log10_hra
## 1    2.41e+08  8.382017
##                                                                                                                                                    hra_reference
## 1 Dwyer JF, Fraser JD, Morrison JL. 2013. Range sizes and habitat use of non-breeding Crested Caracaras in Florida. Journal of Field Ornithology 84(3), 223-233.
##         realm thermoregulation locomotion trophic_guild dimension preymass
## 1 terrestrial        endotherm    walking     carnivore        2D       NA
##   log10_preymass ppmr prey_size_reference
## 1             NA   NA                <NA>
```


##### Thus, the bird species with the largest homerange is the Caracara cheriway, common name caracara.

##### The Caracara cheriway is found along the Mexican-American Border. They are opportunistic feeders that eat small animals and live in open countrysides. They are also quite aggressive birds, and will chase other birds and scavengers, like vultures, away from prey and road kills. The name "caracara" comes from from the sound of their call. Appearance-wise they have colorful faces with black crests and bellies.

##### More about the [Caracara cheriway](https://animaldiversity.org/accounts/Caracara_cheriway/).   [Caracara cheriway - The Crested Caracara](https://www.audubon.org/field-guide/bird/crested-caracara).  

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   