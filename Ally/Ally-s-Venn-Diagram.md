---
title: "Venn Diagram"
author: "Allison Andre"
date: "2/24/2021"
output: 
  html_document: 
    keep_md: yes
---



## Load the libraries

```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
library(ggvenn)
library(VennDiagram)
```

## Load the Data

```r
tidier_microbiome <- readr::read_csv("data/tidiermicrobiome.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   strain = col_character(),
##   condition = col_character(),
##   patient_id = col_double(),
##   abundance = col_double(),
##   cultured = col_logical()
## )
```

```r
tidier_microbiome
```

```
## # A tibble: 279,720 x 7
##    genus            species     strain condition patient_id abundance cultured
##    <chr>            <chr>       <chr>  <chr>          <dbl>     <dbl> <lgl>   
##  1 Faecalibacterium prausnitzii <NA>   a                  3      4988 TRUE    
##  2 Faecalibacterium prausnitzii <NA>   a                  5      5060 TRUE    
##  3 Faecalibacterium prausnitzii <NA>   a                  6      2905 TRUE    
##  4 Faecalibacterium prausnitzii <NA>   a                  9      5745 TRUE    
##  5 Faecalibacterium prausnitzii <NA>   a                 31      4822 TRUE    
##  6 Faecalibacterium prausnitzii <NA>   a                 51      3889 TRUE    
##  7 Faecalibacterium prausnitzii <NA>   a                 52      4646 TRUE    
##  8 Faecalibacterium prausnitzii <NA>   a                 53      6337 TRUE    
##  9 Faecalibacterium prausnitzii <NA>   a                 54      5064 TRUE    
## 10 Faecalibacterium prausnitzii <NA>   a                 59      6359 TRUE    
## # … with 279,710 more rows
```

```r
asd_tidier <- readr::read_csv("data/asd_group_tidier.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   strain = col_character(),
##   condition = col_character(),
##   patient_id = col_double(),
##   abundance = col_double(),
##   cultured = col_logical()
## )
```

```r
asd_tidier
```

```
## # A tibble: 139,860 x 7
##    genus            species     strain condition patient_id abundance cultured
##    <chr>            <chr>       <chr>  <chr>          <dbl>     <dbl> <lgl>   
##  1 Faecalibacterium prausnitzii <NA>   b                  1      4269 TRUE    
##  2 Faecalibacterium prausnitzii <NA>   b                  2      4397 TRUE    
##  3 Faecalibacterium prausnitzii <NA>   b                  3      4499 TRUE    
##  4 Faecalibacterium prausnitzii <NA>   b                  5      6126 TRUE    
##  5 Faecalibacterium prausnitzii <NA>   b                  6      7020 TRUE    
##  6 Faecalibacterium prausnitzii <NA>   b                  7      5404 TRUE    
##  7 Faecalibacterium prausnitzii <NA>   b                  8      4404 TRUE    
##  8 Faecalibacterium prausnitzii <NA>   b                 13      5811 TRUE    
##  9 Faecalibacterium prausnitzii <NA>   b                 14      3360 TRUE    
## 10 Faecalibacterium prausnitzii <NA>   b                 28      4141 TRUE    
## # … with 139,850 more rows
```


```r
td_tidier <- readr::read_csv("data/td_group_tidier.csv")
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   strain = col_character(),
##   condition = col_character(),
##   patient_id = col_double(),
##   abundance = col_double(),
##   cultured = col_logical()
## )
```

```r
td_tidier
```

```
## # A tibble: 139,860 x 7
##    genus            species     strain condition patient_id abundance cultured
##    <chr>            <chr>       <chr>  <chr>          <dbl>     <dbl> <lgl>   
##  1 Faecalibacterium prausnitzii <NA>   a                  3      4988 TRUE    
##  2 Faecalibacterium prausnitzii <NA>   a                  5      5060 TRUE    
##  3 Faecalibacterium prausnitzii <NA>   a                  6      2905 TRUE    
##  4 Faecalibacterium prausnitzii <NA>   a                  9      5745 TRUE    
##  5 Faecalibacterium prausnitzii <NA>   a                 31      4822 TRUE    
##  6 Faecalibacterium prausnitzii <NA>   a                 51      3889 TRUE    
##  7 Faecalibacterium prausnitzii <NA>   a                 52      4646 TRUE    
##  8 Faecalibacterium prausnitzii <NA>   a                 53      6337 TRUE    
##  9 Faecalibacterium prausnitzii <NA>   a                 54      5064 TRUE    
## 10 Faecalibacterium prausnitzii <NA>   a                 59      6359 TRUE    
## # … with 139,850 more rows
```

## Prepare data for Venn diagram

```r
td_venn <-
  td_tidier %>% 
  rename(genus_td = "genus") %>% 
  filter(abundance != 0) %>% 
  select(genus_td, patient_id)
```


```r
asd_venn <-
  asd_tidier %>% 
  rename(genus_asd = "genus") %>% 
  filter(abundance != 0)
```


```r
both_venn <- full_join(td_venn, asd_venn, by = "patient_id")
both_venn
```

```
## # A tibble: 19,470,923 x 8
##    genus_td   patient_id genus_asd  species  strain condition abundance cultured
##    <chr>           <dbl> <chr>      <chr>    <chr>  <chr>         <dbl> <lgl>   
##  1 Faecaliba…          3 Faecaliba… prausni… <NA>   b              4499 TRUE    
##  2 Faecaliba…          3 Hungatella hathewa… <NA>   b              2325 TRUE    
##  3 Faecaliba…          3 Clostridi… <NA>     <NA>   b              3842 FALSE   
##  4 Faecaliba…          3 Butyricim… virosa   <NA>   b               703 TRUE    
##  5 Faecaliba…          3 Alistipes  indisti… <NA>   b               819 TRUE    
##  6 Faecaliba…          3 Clostridi… <NA>     CAG:7  b              1504 TRUE    
##  7 Faecaliba…          3 Lachnoclo… asparag… <NA>   b              2208 TRUE    
##  8 Faecaliba…          3 Butyricic… <NA>     <NA>   b              2209 FALSE   
##  9 Faecaliba…          3 Oscilliba… <NA>     ER4    b               193 TRUE    
## 10 Faecaliba…          3 Desulfovi… piger    <NA>   b                 3 TRUE    
## # … with 19,470,913 more rows
```


```r
both_venn$genus_td <- as.factor(both_venn$genus_td)
both_venn$genus_asd <- as.factor(both_venn$genus_asd)
```


```r
both_venn2 <- 
  both_venn %>% 
  filter(genus_td != "NA" | genus_asd != "NA")
```


## Build Venn Diagram (NOTE to Berlin: The following are 3 ways of displaying the same information)


```r
venn_data <- list(
  "TD Genera" = both_venn2$genus_td,
  "ASD Genera" = both_venn2$genus_asd
)
```




```r
ggvenn(venn_data, fill_color = c("darkred", "skyblue4"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-11-1.png)<!-- -->

## Try to build a COOLER (aka to-scale) venn diagram


```r
anyNA(venn_data)
```

```
## [1] FALSE
```



```r
grid.newpage()
draw.pairwise.venn(area1 = 1264,                      
                   area2 = 1101,
                   cross.area = 1068, 
                   fill = c("darkred", "skyblue4"), 
                   category = c("TD Genera", "ASD Genera"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

```
## (polygon[GRID.polygon.25], polygon[GRID.polygon.26], polygon[GRID.polygon.27], polygon[GRID.polygon.28], text[GRID.text.29], text[GRID.text.30], lines[GRID.lines.31], text[GRID.text.32], text[GRID.text.33], text[GRID.text.34])
```


## Bargraphs of number of genera unique to each group


```r
unique_names <- c("TD group", "ASD Group")
unique_counts <- c(196, 33)
unique_genera <- data_frame(unique_names, unique_counts)
```

```
## Warning: `data_frame()` was deprecated in tibble 1.1.0.
## Please use `tibble()` instead.
```

```r
unique_genera
```

```
## # A tibble: 2 x 2
##   unique_names unique_counts
##   <chr>                <dbl>
## 1 TD group               196
## 2 ASD Group               33
```


```r
unique_genera %>% 
  ggplot(aes(x = unique_names, y = unique_counts, fill = unique_names)) +
  geom_col(color = "black") + 
  scale_fill_manual(values = c("darkred", "skyblue4")) +
  theme_linedraw() +
  labs(title = "Number of Unique Genera Per Group",
       x = NULL,
       y = "Unique Genera") +
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5)) 
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

#Prep data for Venn Diagram by Gender
##Capitalize A and B

```r
both_venn$condition <- str_to_upper(both_venn$condition, locale = "en")
```

## Wrangle the data so they have enough in common to join them together
### Abundance Data

```r
asd <- readr::read_csv("data/ASD_meta_abundance_2.csv")
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
asd
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
asd2 <- 
  asd %>% 
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

###Demographics data

```r
demographics <- readr::read_csv("data/demographics.csv")
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

##Join the two dataframes

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
demo_abundance <- full_join(asd2, demographics2, by = "sample_id")
```


```r
#write.csv(demo_abundance, file = "demographics_and_abundance.csv", row.names = FALSE)
```


##Divide the genera by gender

```r
demo_venn_f <- 
  demo_venn %>% 
  filter(gender == "Female") %>% 
  rename(genus_f = "genus")
demo_venn_f
```

```
## # A tibble: 5,091 x 2
##    genus_f          gender
##    <chr>            <chr> 
##  1 Faecalibacterium Female
##  2 Faecalibacterium Female
##  3 Faecalibacterium Female
##  4 Faecalibacterium Female
##  5 Hungatella       Female
##  6 Hungatella       Female
##  7 Hungatella       Female
##  8 Hungatella       Female
##  9 Clostridium      Female
## 10 Clostridium      Female
## # … with 5,081 more rows
```

```r
demo_venn_m <-
  demo_venn %>% 
  filter(gender == "Male") %>% 
  rename(genus_m = "genus")
demo_venn_m
```

```
## # A tibble: 90,117 x 2
##    genus_m          gender
##    <chr>            <chr> 
##  1 Faecalibacterium Male  
##  2 Faecalibacterium Male  
##  3 Faecalibacterium Male  
##  4 Faecalibacterium Male  
##  5 Faecalibacterium Male  
##  6 Faecalibacterium Male  
##  7 Faecalibacterium Male  
##  8 Faecalibacterium Male  
##  9 Faecalibacterium Male  
## 10 Faecalibacterium Male  
## # … with 90,107 more rows
```


```r
demo_venn_f$genus_f <- as.factor(demo_venn_f$genus_f)
demo_venn_m$genus_m <- as.factor(demo_venn_m$genus_m)
```

#Venn diagrams of overlap by gender
##Not-to=Scale Venn Diagram

```r
demo_venn_data <- list(
  "Male Genera" = demo_venn_m$genus_m,
  "Female Genera" = demo_venn_f$genus_f
)
```


```r
ggvenn(demo_venn_data, fill_color = c("darkred", "skyblue4"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-26-1.png)<!-- -->
## To-Scale Venn Diagram

```r
grid.newpage()
draw.pairwise.venn(area1 = 652+643,                      
                   area2 = 644,
                   cross.area = 643, 
                   fill = c("darkred", "skyblue4"), 
                   category = c("Male Genera", "Female Genera"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

```
## (polygon[GRID.polygon.117], polygon[GRID.polygon.118], polygon[GRID.polygon.119], polygon[GRID.polygon.120], text[GRID.text.121], text[GRID.text.122], lines[GRID.lines.123], text[GRID.text.124], text[GRID.text.125], text[GRID.text.126])
```
## Make Bar Graphs

```r
unique_gender <- c("Male", "Female")
unique_counts4 <- c(652, 1)
unique_gender <- data_frame(unique_gender, unique_counts4)
unique_gender
```

```
## # A tibble: 2 x 2
##   unique_gender unique_counts4
##   <chr>                  <dbl>
## 1 Male                     652
## 2 Female                     1
```


```r
unique_gender %>% 
  ggplot(aes(x = unique_gender, y = unique_counts4, fill = unique_gender)) +
  geom_col(color = "black") + 
  scale_fill_manual(values = c("darkred", "skyblue4")) +
  theme_linedraw() +
  labs(title = "Number of Unique Genera by Sex",
       x = NULL,
       y = "Unique Genera ") +
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5)) 
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-29-1.png)<!-- -->


## Venn Diagram by Age Group

```r
age_venn <- full_join(asd2, demographics2, by = "sample_id") %>% 
  select(-c(sample_id, abundance, gender)) %>% 
  mutate(age = case_when(age <= 7 ~ "younger",
                         age > 7 ~ "older"))
age_venn$genus <- as.factor(age_venn$genus)
age_venn_y <-
  age_venn %>% 
  filter(age == "younger") %>% 
  rename(genus_y = "genus")

age_venn_o <-
  age_venn %>% 
  filter(age == "older") %>% 
  rename(genus_o = "genus")
```


```r
age_venn_data <- list(
  "Younger Genera" = age_venn_y$genus_y,
  "Older Genera" = age_venn_o$genus_o
)
```


```r
ggvenn(age_venn_data, fill_color = c("darkred", "skyblue4"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-32-1.png)<!-- -->

## Make COOLER Venn Diagram 

```r
grid.newpage()
draw.pairwise.venn(area1 = 359+926,                      
                   area2 = 926+11,
                   cross.area = 926, 
                   fill = c("darkred", "skyblue4"), 
                   category = c("Younger Genera", "Older Genera"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-33-1.png)<!-- -->

```
## (polygon[GRID.polygon.206], polygon[GRID.polygon.207], polygon[GRID.polygon.208], polygon[GRID.polygon.209], text[GRID.text.210], text[GRID.text.211], lines[GRID.lines.212], text[GRID.text.213], text[GRID.text.214], text[GRID.text.215])
```
## Make Bar Graphs

```r
unique_age <- c("Younger", "Older")
unique_counts3 <- c(359, 11)
unique_age <- data_frame(unique_age, unique_counts3)
unique_age
```

```
## # A tibble: 2 x 2
##   unique_age unique_counts3
##   <chr>               <dbl>
## 1 Younger               359
## 2 Older                  11
```


```r
unique_age %>% 
  ggplot(aes(x = unique_age, y = unique_counts3, fill = unique_age)) +
  geom_col(color = "black") + 
  scale_fill_manual(values = c("darkred", "skyblue4")) +
  theme_linedraw() +
  labs(title = "Number of Unique Genera Per Age Group",
       x = NULL,
       y = "Unique Genera ") +
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5)) 
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-35-1.png)<!-- -->


#Venn Diagram of Species (NOTE to Berlin: The following are 3 ways of displaying the same information)
## Prep the data

```r
asd_microbiome <- read_csv("data/ASD_meta_abundance_2.csv")
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
## # … with 5,609 more rows, and 49 more variables: a68 <dbl>, a69 <dbl>,
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

## Make Venn Diagram

```r
species_venn_data2 <- list(
  "TD Species" = td_A2$tax_td,
  "ASD Species" = asd_B2$tax_asd
)
```


```r
ggvenn(species_venn_data2, fill_color = c("darkred", "skyblue4"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-43-1.png)<!-- -->
## Make COOLER Venn Diagram

```r
grid.newpage()
draw.pairwise.venn(area1 = (766+3591),                      
                   area2 = (172 + 3591),
                   cross.area = 3591, 
                   fill = c("darkred", "skyblue4"), 
                   category = c("TD Species", "ASD Species"))
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-44-1.png)<!-- -->

```
## (polygon[GRID.polygon.295], polygon[GRID.polygon.296], polygon[GRID.polygon.297], polygon[GRID.polygon.298], text[GRID.text.299], text[GRID.text.300], lines[GRID.lines.301], text[GRID.text.302], text[GRID.text.303], text[GRID.text.304])
```


```r
unique_names2 <- c("TD group", "ASD Group")
unique_counts2 <- c(766, 172)
unique_species <- data_frame(unique_names2, unique_counts2)
unique_species
```

```
## # A tibble: 2 x 2
##   unique_names2 unique_counts2
##   <chr>                  <dbl>
## 1 TD group                 766
## 2 ASD Group                172
```



```r
unique_species %>% 
  ggplot(aes(x = unique_names2, y = unique_counts2, fill = unique_names2)) +
  geom_col(color = "black") + 
  scale_fill_manual(values = c("darkred", "skyblue4")) +
  theme_linedraw() +
  labs(title = "Number of Unique Species Per Group",
       x = NULL,
       y = "Unique Species") +
  theme(plot.title = element_text(size = rel(1.5), hjust = 0.5)) 
```

![](Ally-s-Venn-Diagram_files/figure-html/unnamed-chunk-46-1.png)<!-- -->

