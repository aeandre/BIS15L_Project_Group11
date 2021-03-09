---
title: "Preparing for Venn Diagram B"
output: 
  html_document: 
    keep_md: yes
---

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


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
asd_tidier <- read_csv(here("Berlin/Copy_others/Ally/asd_group_tidier copy.csv"))
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
td_tidier <- read_csv(here("Berlin/Copy_others/Ally/td_group_tidier copy.csv"))
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
#write.csv(both_venn, file = "both_venn.csv", row.names = FALSE)
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


```r
venn_data <- list(
  "TD Genera" = both_venn2$genus_td,
  "ASD Genera" = both_venn2$genus_asd
)
```


```r
#write.csv(venn_data, file = "venn_data.csv", row.names = FALSE)
```

