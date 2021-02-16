---
title: "Project Try Berlin"
output: 
  html_document: 
    keep_md: yes
---



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
library(tidyverse)
library(janitor)
library(here)
library(naniar)
```


```r
asd <- read_csv(here("ASD meta abundance 2.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   `ASD meta abundance` = col_character()
## )
```

```
## Warning: 5620 parsing failures.
## row col  expected     actual                                                                                file
##   1  -- 1 columns 61 columns '/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/ASD meta abundance 2.csv'
##   2  -- 1 columns 61 columns '/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/ASD meta abundance 2.csv'
##   3  -- 1 columns 61 columns '/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/ASD meta abundance 2.csv'
##   4  -- 1 columns 61 columns '/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/ASD meta abundance 2.csv'
##   5  -- 1 columns 61 columns '/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/ASD meta abundance 2.csv'
## ... ... ......... .......... ...................................................................................
## See problems(...) for more details.
```

```r
asd
```

```
## # A tibble: 5,620 x 1
##    `ASD meta abundance`                               
##    <chr>                                              
##  1 Taxonomy                                           
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii
##  3 g__Hungatella;s__Hungatella hathewayi              
##  4 g__Clostridium;s__uncultured Clostridium sp.       
##  5 g__Butyricimonas;s__Butyricimonas virosa           
##  6 g__Alistipes;s__Alistipes indistinctus             
##  7 g__Unclassified;s__Firmicutes bacterium CAG:176    
##  8 g__Clostridium;s__Clostridium sp. CAG:7            
##  9 g__Unclassified;s__Firmicutes bacterium CAG:882    
## 10 g__Lachnoclostridium;s__[Clostridium] asparagiforme
## # … with 5,610 more rows
```


```r
glimpse(asd)
```

```
## Rows: 5,620
## Columns: 1
## $ `ASD meta abundance` <chr> "Taxonomy", "g__Faecalibacterium;s__Faecalibacte…
```

```r
summary(asd)
```

```
##  ASD meta abundance
##  Length:5620       
##  Class :character  
##  Mode  :character
```



```r
names(asd)
```

```
## [1] "ASD meta abundance"
```

I have yet to really dive into this, but this data set seems to just have characters.
