---
title: "Demo venn csv write"
output: 
  html_document: 
    keep_md: yes
---


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.1.0     ✓ dplyr   1.0.4
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
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
library(here)
```

```
## here() starts at /Users/Astrobeecal/Desktop/BIS15L_Project_Group11
```

```r
library(naniar)
library(ggvenn)
```

```
## Loading required package: grid
```

```r
library(VennDiagram)
```

```
## Loading required package: futile.logger
```

```r
library(shiny)
library(shinydashboard)
```

```
## 
## Attaching package: 'shinydashboard'
```

```
## The following object is masked from 'package:graphics':
## 
##     box
```

```r
library(ggplot2)
library(purrr)
library(dplyr)
```

## Note: This data is from a copy of Ally's ASD_meta_abundance_2 file, and I am writing csv files to simplify the process and input into the final project.


```r
ASD_meta_adundance <- read_csv(here("Berlin/Copy_others/Ally/ASD_meta_abundance_2 copy.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   .default = col_double(),
##   Taxonomy = col_character()
## )
## ℹ Use `spec()` for the full column specifications.
```

```r
demographics <- read_csv(here("Berlin/Copy_files_csv/demographics_untidy copy.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   `Sample ID` = col_character(),
##   Stage = col_character(),
##   Gender = col_character(),
##   Age = col_double(),
##   `16S RNA sequencing` = col_character(),
##   `Metagenomic sequencing` = col_character(),
##   `Metabonomic analysis` = col_character(),
##   Constipation = col_character()
## )
```

##Preparation of data for Venn Diagrams that compares genera composition between gender
#Preparing ASD data:

```r
ASD_meta_adundance
```

```
## # A tibble: 5,619 x 61
##    Taxonomy       A3    A5    A6    A9   A31   A51   A52   A53   A54   A59   A67
##    <chr>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 g__Faecali…  4988  5060  2905  5745  4822  3889  4646  6337  5064  6359  3194
##  2 g__Hungate…  5803  5612  4109  1432  2652  4175  3891   894  4903  2970  4029
##  3 g__Clostri…  3793  2795  1355  5558  5383  3505  5541  4429  4121  3258  1901
##  4 g__Butyric…    64  1385   725  1553    40    53    33   175    58  1636  1170
##  5 g__Alistip…    15    20   723   620  3261    43    83    37    43  1114  2531
##  6 g__Unclass…   100    29    11  1320    51    45    52    64    60   896    26
##  7 g__Clostri…  2119  1230  1322  2675  1470  2262  2984  2004  1904  1227   821
##  8 g__Unclass…    12    24     1    44    26     9    25    19    17    17    15
##  9 g__Lachnoc…   453   691  2278   107   342  1304  1400  1207  2034  2051    20
## 10 g__Butyric…  1266  1682    43  1726  1804  1441  2691  1886   919  2215  1063
## # … with 5,609 more rows, and 49 more variables: A68 <dbl>, A69 <dbl>,
## #   A71 <dbl>, A73 <dbl>, A76 <dbl>, A78 <dbl>, A87 <dbl>, A89 <dbl>,
## #   A93 <dbl>, A101 <dbl>, A109 <dbl>, A113 <dbl>, A114 <dbl>, A115 <dbl>,
## #   A142 <dbl>, A144 <dbl>, A149 <dbl>, A164 <dbl>, A165 <dbl>, B1 <dbl>,
## #   B2 <dbl>, B3 <dbl>, B5 <dbl>, B6 <dbl>, B7 <dbl>, B8 <dbl>, B13 <dbl>,
## #   B14 <dbl>, B28 <dbl>, B29 <dbl>, B36 <dbl>, B37 <dbl>, B94 <dbl>,
## #   B99 <dbl>, B103 <dbl>, B106 <dbl>, B111 <dbl>, B114 <dbl>, B115 <dbl>,
## #   B120 <dbl>, B127 <dbl>, B132 <dbl>, B141 <dbl>, B142 <dbl>, B143 <dbl>,
## #   B152 <dbl>, B156 <dbl>, B158 <dbl>, B164 <dbl>
```


```r
asd2 <- ASD_meta_adundance %>%
   pivot_longer(-Taxonomy, 
               names_to = "subject", 
               values_to = "abundance") %>% 
  filter(str_detect(Taxonomy, "Unclassified") == FALSE) %>% 
  separate(Taxonomy, into = c("genus", "species"), sep = ";") %>% 
  separate(genus, into = c("g", "genus"), sep = "__") %>% 
  separate(species, into = c("s", "species"), sep = "__") %>% 
  select( -g, -s, -species) %>% 
  rename(sample_id = "subject") %>% 
  filter(abundance !=0)
asd2
```

```
## # A tibble: 95,208 x 3
##    genus            sample_id abundance
##    <chr>            <chr>         <dbl>
##  1 Faecalibacterium A3             4988
##  2 Faecalibacterium A5             5060
##  3 Faecalibacterium A6             2905
##  4 Faecalibacterium A9             5745
##  5 Faecalibacterium A31            4822
##  6 Faecalibacterium A51            3889
##  7 Faecalibacterium A52            4646
##  8 Faecalibacterium A53            6337
##  9 Faecalibacterium A54            5064
## 10 Faecalibacterium A59            6359
## # … with 95,198 more rows
```
#Preparing Demographics data:

```r
demographics
```

```
## # A tibble: 289 x 8
##    `Sample ID` Stage Gender   Age `16S RNA sequencing` `Metagenomic sequencing`
##    <chr>       <chr> <chr>  <dbl> <chr>                <chr>                   
##  1 A1          TD    Female     5 yes                  No                      
##  2 A10         TD    Female     5 yes                  No                      
##  3 A100        TD    Male       5 yes                  No                      
##  4 A101        TD    Male       3 yes                  Yes                     
##  5 A102        TD    Male       4 yes                  No                      
##  6 A104        TD    Male       6 yes                  No                      
##  7 A105        TD    Male       5 yes                  No                      
##  8 A106        TD    Male       4 yes                  No                      
##  9 A108        TD    Male       3 yes                  No                      
## 10 A109        TD    Male       4 yes                  Yes                     
## # … with 279 more rows, and 2 more variables: Metabonomic analysis <chr>,
## #   Constipation <chr>
```


```r
demographics2 <-
  demographics %>% 
  clean_names() %>% 
  filter(metagenomic_sequencing == "Yes") %>% 
  select(sample_id, gender, age)
demographics2
```

```
## # A tibble: 60 x 3
##    sample_id gender   age
##    <chr>     <chr>  <dbl>
##  1 A101      Male       3
##  2 A109      Male       4
##  3 A113      Male       6
##  4 A114      Male       4
##  5 A115      Male       5
##  6 A142      Male       7
##  7 A144      Male       9
##  8 A149      Male       5
##  9 A164      Male       8
## 10 A165      Male       7
## # … with 50 more rows
```
#Joining the two dataframes:

```r
demo_venn <- full_join(asd2, demographics2, by = "sample_id") %>% 
  select(-c(sample_id, abundance, age))
demo_venn
```

```
## # A tibble: 95,208 x 2
##    genus            gender
##    <chr>            <chr> 
##  1 Faecalibacterium Female
##  2 Faecalibacterium Male  
##  3 Faecalibacterium Female
##  4 Faecalibacterium Male  
##  5 Faecalibacterium Male  
##  6 Faecalibacterium Male  
##  7 Faecalibacterium Male  
##  8 Faecalibacterium Male  
##  9 Faecalibacterium Male  
## 10 Faecalibacterium Male  
## # … with 95,198 more rows
```

```r
#write.csv(demo_venn, file = "demo_venn.csv", row.names = FALSE)
```

##ASD_2 B2 build

```r
ASD_meta_adundance <- janitor::clean_names(ASD_meta_adundance)
```

#Pivoting out longer and taking out unclassififed data:

```r
asd_microbiome_longer <- ASD_meta_adundance %>% 
  pivot_longer(-taxonomy, names_to = "condition", values_to = "abundance")%>% 
  filter(str_detect(taxonomy, "Unclassified") == FALSE) %>% 
  separate(condition, into = c("condition", "patient_id"), sep = 1)
asd_microbiome_longer
```

```
## # A tibble: 279,720 x 4
##    taxonomy                                       condition patient_id abundance
##    <chr>                                          <chr>     <chr>          <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium praus… a         3               4988
##  2 g__Faecalibacterium;s__Faecalibacterium praus… a         5               5060
##  3 g__Faecalibacterium;s__Faecalibacterium praus… a         6               2905
##  4 g__Faecalibacterium;s__Faecalibacterium praus… a         9               5745
##  5 g__Faecalibacterium;s__Faecalibacterium praus… a         31              4822
##  6 g__Faecalibacterium;s__Faecalibacterium praus… a         51              3889
##  7 g__Faecalibacterium;s__Faecalibacterium praus… a         52              4646
##  8 g__Faecalibacterium;s__Faecalibacterium praus… a         53              6337
##  9 g__Faecalibacterium;s__Faecalibacterium praus… a         54              5064
## 10 g__Faecalibacterium;s__Faecalibacterium praus… a         59              6359
## # … with 279,710 more rows
```


```r
asd_B2 <-
  asd_microbiome_longer %>% 
  filter(condition == "b") %>% 
  rename(tax_asd = "taxonomy") %>% 
  filter(abundance != 0)
td_A2 <-
  asd_microbiome_longer %>% 
  filter(condition == "a") %>% 
  rename(tax_td = "taxonomy") %>%
  filter(abundance != 0)
```


```r
#write.csv(asd_B2, file = "asd_B2.csv", row.names = FALSE)
#write.csv(td_A2, file = "td_A2.csv", row.names = FALSE)
```


##Age group csv file write

```r
asd2 <- 
  ASD_meta_adundance %>% 
  pivot_longer(-taxonomy, 
               names_to = "subject", 
               values_to = "abundance") %>% 
  filter(str_detect(taxonomy, "Unclassified") == FALSE) %>% 
  separate(taxonomy, into = c("genus", "species"), sep = ";") %>% 
  separate(genus, into = c("g", "genus"), sep = "__") %>% 
  separate(species, into = c("s", "species"), sep = "__") %>% 
  select( -g, -s, -species) %>% 
  rename(sample_id = "subject") %>% 
  filter(abundance !=0)
asd2
```

```
## # A tibble: 95,208 x 3
##    genus            sample_id abundance
##    <chr>            <chr>         <dbl>
##  1 Faecalibacterium a3             4988
##  2 Faecalibacterium a5             5060
##  3 Faecalibacterium a6             2905
##  4 Faecalibacterium a9             5745
##  5 Faecalibacterium a31            4822
##  6 Faecalibacterium a51            3889
##  7 Faecalibacterium a52            4646
##  8 Faecalibacterium a53            6337
##  9 Faecalibacterium a54            5064
## 10 Faecalibacterium a59            6359
## # … with 95,198 more rows
```


```r
demographics2 <-
  demographics %>% 
  clean_names() %>% 
  filter(metagenomic_sequencing == "Yes") %>% 
  select(sample_id, gender, age)
demographics2
```

```
## # A tibble: 60 x 3
##    sample_id gender   age
##    <chr>     <chr>  <dbl>
##  1 A101      Male       3
##  2 A109      Male       4
##  3 A113      Male       6
##  4 A114      Male       4
##  5 A115      Male       5
##  6 A142      Male       7
##  7 A144      Male       9
##  8 A149      Male       5
##  9 A164      Male       8
## 10 A165      Male       7
## # … with 50 more rows
```

```r
#write.csv(asd2, file = "asd2.csv", row.names = FALSE)
#write.csv(demographics2, file = "demographics2.csv", row.names = FALSE)
```
