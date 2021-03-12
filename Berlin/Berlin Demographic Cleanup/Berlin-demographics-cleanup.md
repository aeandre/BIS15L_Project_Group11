---
title: "Berlin demographics cleanup"
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
library(ggvenn)
library(VennDiagram)
library(shiny)
library(shinydashboard)
library(trekcolors)
library(ggplot2)
```


```r
getwd()
```

```
## [1] "/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/Berlin"
```


```r
demographics <- read_csv(here("Berlin/demographics copy.csv"))
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
demographics2 <- demographics %>% 
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
write.csv(demographics2, file = "demographics_tidy.csv", row.names = FALSE)
```

