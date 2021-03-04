---
title: "C_ref_Tidy_Attempt"
output: 
  html_document: 
    keep_md: yes
---

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

title: "Tidy Attempt"
output: html_document
---




```r
getwd()
```

```
## [1] "/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/Berlin"
```



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
## here() starts at /Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11
```

```r
library(naniar)
```



```r
c_ref_asd_microbiome <- read_csv(here("Berlin/ASD meta abundance 2 copy.csv"))
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
c_ref_asd_microbiome <- janitor::clean_names(c_ref_asd_microbiome)
```


#### pivoting longer and taking out unclassified data

```r
c_ref_asd_microbiome_longer <- c_ref_asd_microbiome %>% 
  pivot_longer(-taxonomy, names_to = "condition", values_to = "abundance")%>% 
  filter(str_detect(taxonomy, "Unclassified") == FALSE)
c_ref_asd_microbiome_longer
```

```
## # A tibble: 279,720 x 3
##    taxonomy                                            condition abundance
##    <chr>                                               <chr>         <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium prausnitzii a3             4988
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii a5             5060
##  3 g__Faecalibacterium;s__Faecalibacterium prausnitzii a6             2905
##  4 g__Faecalibacterium;s__Faecalibacterium prausnitzii a9             5745
##  5 g__Faecalibacterium;s__Faecalibacterium prausnitzii a31            4822
##  6 g__Faecalibacterium;s__Faecalibacterium prausnitzii a51            3889
##  7 g__Faecalibacterium;s__Faecalibacterium prausnitzii a52            4646
##  8 g__Faecalibacterium;s__Faecalibacterium prausnitzii a53            6337
##  9 g__Faecalibacterium;s__Faecalibacterium prausnitzii a54            5064
## 10 g__Faecalibacterium;s__Faecalibacterium prausnitzii a59            6359
## # … with 279,710 more rows
```

#### wrangling the taxonomy column into genus, species, strain

```r
c_ref_asd_microbiome_tidy <- c_ref_asd_microbiome_longer %>% 
  separate(condition, into = c("condition", "patient_id"), sep = 1) %>% 
  separate(taxonomy, into = c("genus", "species"), sep = ";s__") %>% 
  separate(genus, into = c("trash", "genus"), sep = "__") %>% 
  separate(species, into = c("species", "strain"), sep = " sp. ") %>%
  separate(species, into = c("extra_genus", "species"), sep = " ")
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
c_ref_asd_microbiome_tidy
```

```
## # A tibble: 279,720 x 8
##    trash genus      extra_genus   species  strain condition patient_id abundance
##    <chr> <chr>      <chr>         <chr>    <chr>  <chr>     <chr>          <dbl>
##  1 g     Faecaliba… Faecalibacte… prausni… <NA>   a         3               4988
##  2 g     Faecaliba… Faecalibacte… prausni… <NA>   a         5               5060
##  3 g     Faecaliba… Faecalibacte… prausni… <NA>   a         6               2905
##  4 g     Faecaliba… Faecalibacte… prausni… <NA>   a         9               5745
##  5 g     Faecaliba… Faecalibacte… prausni… <NA>   a         31              4822
##  6 g     Faecaliba… Faecalibacte… prausni… <NA>   a         51              3889
##  7 g     Faecaliba… Faecalibacte… prausni… <NA>   a         52              4646
##  8 g     Faecaliba… Faecalibacte… prausni… <NA>   a         53              6337
##  9 g     Faecaliba… Faecalibacte… prausni… <NA>   a         54              5064
## 10 g     Faecaliba… Faecalibacte… prausni… <NA>   a         59              6359
## # … with 279,710 more rows
```


#### getting rid of extra genus/g and making a culture column


```r
c_ref_asd_microbiome_tidy3 <- c_ref_asd_microbiome_tidy %>% 
  mutate(cultured = ifelse(extra_genus == "uncultured", FALSE, TRUE)) %>% 
  select(- extra_genus, - trash)
c_ref_asd_microbiome_tidy3
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
## # … with 279,710 more rows
```

#### finding unknown species

```r
c_ref_asd_microbiome_tidy4 <- c_ref_asd_microbiome_tidy3 %>% 
  mutate(species = ifelse(species == genus, NA, species))
view(c_ref_asd_microbiome_tidy4)
```


```r
c_ref_asd_microbiome_tidy4 %>% 
  filter(species == "copri")
```

```
## # A tibble: 120 x 7
##    genus      species strain condition patient_id abundance cultured
##    <chr>      <chr>   <chr>  <chr>     <chr>          <dbl> <lgl>   
##  1 Prevotella copri   <NA>   a         3                 34 TRUE    
##  2 Prevotella copri   <NA>   a         5                 92 TRUE    
##  3 Prevotella copri   <NA>   a         6                 28 TRUE    
##  4 Prevotella copri   <NA>   a         9                 25 TRUE    
##  5 Prevotella copri   <NA>   a         31              1030 TRUE    
##  6 Prevotella copri   <NA>   a         51               561 TRUE    
##  7 Prevotella copri   <NA>   a         52               541 TRUE    
##  8 Prevotella copri   <NA>   a         53              1295 TRUE    
##  9 Prevotella copri   <NA>   a         54              1003 TRUE    
## 10 Prevotella copri   <NA>   a         59                37 TRUE    
## # … with 110 more rows
```


#### write

```r
write.csv(c_ref_asd_microbiome_tidy4, file = "c_ref_tidiermicrobiome.csv", row.names = FALSE)
```
