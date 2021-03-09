---
title: "Tidy Data"
output: 
  html_document: 
    keep_md: yes
---





```r
getwd()
```

```
## [1] "C:/Users/Claire Chapman/Desktop/BIS15L_Project_Group11/Claire"
```


```r
library(tidyverse)
```

```
## -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
```

```
## v ggplot2 3.3.3     v purrr   0.3.4
## v tibble  3.0.6     v dplyr   1.0.4
## v tidyr   1.1.2     v stringr 1.4.0
## v readr   1.4.0     v forcats 0.5.1
```

```
## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
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
asd_microbiome <- read_csv("data/ASD meta abundance 2.csv")
```

```
## 
## -- Column specification --------------------------------------------------------
## cols(
##   .default = col_double(),
##   Taxonomy = col_character()
## )
## i Use `spec()` for the full column specifications.
```


```r
asd_microbiome <- janitor::clean_names(asd_microbiome)
```



```r
names(asd_microbiome)
```

```
##  [1] "taxonomy" "a3"       "a5"       "a6"       "a9"       "a31"     
##  [7] "a51"      "a52"      "a53"      "a54"      "a59"      "a67"     
## [13] "a68"      "a69"      "a71"      "a73"      "a76"      "a78"     
## [19] "a87"      "a89"      "a93"      "a101"     "a109"     "a113"    
## [25] "a114"     "a115"     "a142"     "a144"     "a149"     "a164"    
## [31] "a165"     "b1"       "b2"       "b3"       "b5"       "b6"      
## [37] "b7"       "b8"       "b13"      "b14"      "b28"      "b29"     
## [43] "b36"      "b37"      "b94"      "b99"      "b103"     "b106"    
## [49] "b111"     "b114"     "b115"     "b120"     "b127"     "b132"    
## [55] "b141"     "b142"     "b143"     "b152"     "b156"     "b158"    
## [61] "b164"
```

```r
asd_microbiome
```

```
## # A tibble: 5,619 x 61
##    taxonomy       a3    a5    a6    a9   a31   a51   a52   a53   a54   a59   a67
##    <chr>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1 g__Faecali~  4988  5060  2905  5745  4822  3889  4646  6337  5064  6359  3194
##  2 g__Hungate~  5803  5612  4109  1432  2652  4175  3891   894  4903  2970  4029
##  3 g__Clostri~  3793  2795  1355  5558  5383  3505  5541  4429  4121  3258  1901
##  4 g__Butyric~    64  1385   725  1553    40    53    33   175    58  1636  1170
##  5 g__Alistip~    15    20   723   620  3261    43    83    37    43  1114  2531
##  6 g__Unclass~   100    29    11  1320    51    45    52    64    60   896    26
##  7 g__Clostri~  2119  1230  1322  2675  1470  2262  2984  2004  1904  1227   821
##  8 g__Unclass~    12    24     1    44    26     9    25    19    17    17    15
##  9 g__Lachnoc~   453   691  2278   107   342  1304  1400  1207  2034  2051    20
## 10 g__Butyric~  1266  1682    43  1726  1804  1441  2691  1886   919  2215  1063
## # ... with 5,609 more rows, and 49 more variables: a68 <dbl>, a69 <dbl>,
## #   a71 <dbl>, a73 <dbl>, a76 <dbl>, a78 <dbl>, a87 <dbl>, a89 <dbl>,
## #   a93 <dbl>, a101 <dbl>, a109 <dbl>, a113 <dbl>, a114 <dbl>, a115 <dbl>,
## #   a142 <dbl>, a144 <dbl>, a149 <dbl>, a164 <dbl>, a165 <dbl>, b1 <dbl>,
## #   b2 <dbl>, b3 <dbl>, b5 <dbl>, b6 <dbl>, b7 <dbl>, b8 <dbl>, b13 <dbl>,
## #   b14 <dbl>, b28 <dbl>, b29 <dbl>, b36 <dbl>, b37 <dbl>, b94 <dbl>,
## #   b99 <dbl>, b103 <dbl>, b106 <dbl>, b111 <dbl>, b114 <dbl>, b115 <dbl>,
## #   b120 <dbl>, b127 <dbl>, b132 <dbl>, b141 <dbl>, b142 <dbl>, b143 <dbl>,
## #   b152 <dbl>, b156 <dbl>, b158 <dbl>, b164 <dbl>
```


#### pivoting longer and taking out unclassified data

```r
asd_microbiome_longer <- asd_microbiome %>% 
  pivot_longer(-taxonomy, names_to = "condition", values_to = "abundance")%>% 
  filter(str_detect(taxonomy, "Unclassified") == FALSE) %>% 
  separate(condition, into = c("condition", "patient_id"), sep = 1)
asd_microbiome_longer
```

```
## # A tibble: 279,720 x 4
##    taxonomy                                       condition patient_id abundance
##    <chr>                                          <chr>     <chr>          <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium praus~ a         3               4988
##  2 g__Faecalibacterium;s__Faecalibacterium praus~ a         5               5060
##  3 g__Faecalibacterium;s__Faecalibacterium praus~ a         6               2905
##  4 g__Faecalibacterium;s__Faecalibacterium praus~ a         9               5745
##  5 g__Faecalibacterium;s__Faecalibacterium praus~ a         31              4822
##  6 g__Faecalibacterium;s__Faecalibacterium praus~ a         51              3889
##  7 g__Faecalibacterium;s__Faecalibacterium praus~ a         52              4646
##  8 g__Faecalibacterium;s__Faecalibacterium praus~ a         53              6337
##  9 g__Faecalibacterium;s__Faecalibacterium praus~ a         54              5064
## 10 g__Faecalibacterium;s__Faecalibacterium praus~ a         59              6359
## # ... with 279,710 more rows
```


#### wrangling the taxonomy column into genus, species, strain, and culture + identifying unknown species

```r
asd_microbiome_tidy <- asd_microbiome_longer %>% 
  separate(taxonomy, into = c("genus", "species"), sep = ";s__") %>% 
  separate(genus, into = c("trash", "genus"), sep = "__") %>% 
  separate(species, into = c("species", "strain"), sep = " sp. ") %>%
  separate(species, into = c("extra_genus", "species"), sep = " ") %>% 
  mutate(cultured = ifelse(extra_genus == "uncultured", FALSE, TRUE)) %>% 
  mutate(species = ifelse(species == genus, NA, species)) %>% 
  select(- extra_genus, - trash)
```

```
## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 182580 rows [1,
## 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...].
```

```
## Warning: Expected 2 pieces. Additional pieces discarded in 11640 rows [121, 122,
## 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138,
## 139, 140, ...].
```

```
## Warning: Expected 2 pieces. Missing pieces filled with `NA` in 95580 rows [301,
## 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317,
## 318, 319, 320, ...].
```

```r
asd_microbiome_tidy
```

```
## # A tibble: 279,720 x 7
##    genus            species     strain condition patient_id abundance cultured
##    <chr>            <chr>       <chr>  <chr>     <chr>          <dbl> <lgl>   
##  1 Faecalibacterium prausnitzii <NA>   a         3               4988 TRUE    
##  2 Faecalibacterium prausnitzii <NA>   a         5               5060 TRUE    
##  3 Faecalibacterium prausnitzii <NA>   a         6               2905 TRUE    
##  4 Faecalibacterium prausnitzii <NA>   a         9               5745 TRUE    
##  5 Faecalibacterium prausnitzii <NA>   a         31              4822 TRUE    
##  6 Faecalibacterium prausnitzii <NA>   a         51              3889 TRUE    
##  7 Faecalibacterium prausnitzii <NA>   a         52              4646 TRUE    
##  8 Faecalibacterium prausnitzii <NA>   a         53              6337 TRUE    
##  9 Faecalibacterium prausnitzii <NA>   a         54              5064 TRUE    
## 10 Faecalibacterium prausnitzii <NA>   a         59              6359 TRUE    
## # ... with 279,710 more rows
```



#### write

```r
#write.csv(asd_microbiome_tidy, file = "tidiermicrobiome.csv", row.names = FALSE)
```

