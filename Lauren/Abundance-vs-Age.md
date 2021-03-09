---
title: "Abundance vs Age"
output: 
  html_document: 
    keep_md: yes
---



## load library

```r
library(tidyverse)
```

```
## Warning in as.POSIXlt.POSIXct(Sys.time()): unknown timezone 'zone/tz/2021a.1.0/
## zoneinfo/America/Los_Angeles'
```

```
## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
```

```
## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
## ✓ tibble  3.0.4     ✓ dplyr   1.0.2
## ✓ tidyr   1.1.2     ✓ stringr 1.4.0
## ✓ readr   1.4.0     ✓ forcats 0.5.0
```

```
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(here)
```

```
## here() starts at /Users/lonubla/Desktop/BIS15L_Project_Group11-main/BIS15L_Project_Group11-main/Lauren
```


```r
setwd("/Users/lonubla/Desktop/BIS15L_Project_Group11-main/BIS15L_Project_Group11-main/tidy_data")
getwd()
```

```
## [1] "/Users/lonubla/Desktop/BIS15L_Project_Group11-main/BIS15L_Project_Group11-main/tidy_data"
```



```r
demo_abund <- readr::read_csv(here("/Users/lonubla/Desktop/BIS15L_Project_Group11-main/BIS15L_Project_Group11-main/tidy_data/demographics_and_abundance.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   sample_id = col_character(),
##   abundance = col_double(),
##   gender = col_character(),
##   age = col_double()
## )
```

```r
abund_vs_age <- demo_abund%>%
  select(-gender)
```


```r
names(abund_vs_age)
```

```
## [1] "genus"     "sample_id" "abundance" "age"
```

```r
view(abund_vs_age)
```


### Number of individuals in each genus

```r
abund_vs_age%>%
  group_by(age)%>%
  summarise(avg_abund=mean(abundance, na.rm = T))%>%
  ggplot(aes(x=factor(age), y=avg_abund))+ geom_col(fill="darkred")+ 
  scale_fill_manual()+
  labs(title = "Age vs Abundance", x = "Age", y = "Count")
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

![](Abundance-vs-Age_files/figure-html/unnamed-chunk-7-1.png)<!-- -->
