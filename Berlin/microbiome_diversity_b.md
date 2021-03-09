---
title: "microbiome_diversity_b"
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
```


```r
getwd()
```

```
## [1] "/Users/Astrobeecal/Desktop/GitHub/BIS15L_Project_Group11/Berlin"
```



```r
asd <- read_csv(here("Berlin/Copy_others/Ally/ASD_meta_abundance_2 copy.csv"))
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
asd_tidy <- asd %>% 
  pivot_longer(-Taxonomy, 
               names_to = "subject", 
               values_to = "abundance") %>% 
  separate(subject, into = c("group", "number"), sep = 1)
asd_tidy
```

```
## # A tibble: 337,140 x 4
##    Taxonomy                                            group number abundance
##    <chr>                                               <chr> <chr>      <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     3           4988
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     5           5060
##  3 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     6           2905
##  4 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     9           5745
##  5 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     31          4822
##  6 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     51          3889
##  7 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     52          4646
##  8 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     53          6337
##  9 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     54          5064
## 10 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     59          6359
## # … with 337,130 more rows
```


```r
asd_tidy2 <- asd_tidy %>% 
  filter(str_detect(Taxonomy, "Unclassified") == FALSE)
asd_tidy2
```

```
## # A tibble: 279,720 x 4
##    Taxonomy                                            group number abundance
##    <chr>                                               <chr> <chr>      <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     3           4988
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     5           5060
##  3 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     6           2905
##  4 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     9           5745
##  5 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     31          4822
##  6 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     51          3889
##  7 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     52          4646
##  8 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     53          6337
##  9 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     54          5064
## 10 g__Faecalibacterium;s__Faecalibacterium prausnitzii A     59          6359
## # … with 279,710 more rows
```


```r
asd_tidy3 <- 
  asd_tidy2 %>% 
  separate(Taxonomy, into = c("genus", "species"), sep = ";")
```


```r
asd_tidy4 <-
  asd_tidy3 %>% 
  separate(genus, into = c("g", "genus"), sep = "__") %>% 
  separate(species, into = c("s", "species"), sep = "__") %>% 
  select( -g, -s) %>% 
  rename(id = "number")
asd_tidy4
```

```
## # A tibble: 279,720 x 5
##    genus            species                      group id    abundance
##    <chr>            <chr>                        <chr> <chr>     <dbl>
##  1 Faecalibacterium Faecalibacterium prausnitzii A     3          4988
##  2 Faecalibacterium Faecalibacterium prausnitzii A     5          5060
##  3 Faecalibacterium Faecalibacterium prausnitzii A     6          2905
##  4 Faecalibacterium Faecalibacterium prausnitzii A     9          5745
##  5 Faecalibacterium Faecalibacterium prausnitzii A     31         4822
##  6 Faecalibacterium Faecalibacterium prausnitzii A     51         3889
##  7 Faecalibacterium Faecalibacterium prausnitzii A     52         4646
##  8 Faecalibacterium Faecalibacterium prausnitzii A     53         6337
##  9 Faecalibacterium Faecalibacterium prausnitzii A     54         5064
## 10 Faecalibacterium Faecalibacterium prausnitzii A     59         6359
## # … with 279,710 more rows
```


```r
asd_tidy4$genus <- as.factor(asd_tidy4$genus)
asd_tidy4$species <- as.factor(asd_tidy4$species)
asd_tidy4$id <- as.factor(asd_tidy4$id)
```


```r
asd_group <-
  asd_tidy4 %>% 
  filter(group == "B")
asd_group
```

```
## # A tibble: 139,860 x 5
##    genus            species                      group id    abundance
##    <fct>            <fct>                        <chr> <fct>     <dbl>
##  1 Faecalibacterium Faecalibacterium prausnitzii B     1          4269
##  2 Faecalibacterium Faecalibacterium prausnitzii B     2          4397
##  3 Faecalibacterium Faecalibacterium prausnitzii B     3          4499
##  4 Faecalibacterium Faecalibacterium prausnitzii B     5          6126
##  5 Faecalibacterium Faecalibacterium prausnitzii B     6          7020
##  6 Faecalibacterium Faecalibacterium prausnitzii B     7          5404
##  7 Faecalibacterium Faecalibacterium prausnitzii B     8          4404
##  8 Faecalibacterium Faecalibacterium prausnitzii B     13         5811
##  9 Faecalibacterium Faecalibacterium prausnitzii B     14         3360
## 10 Faecalibacterium Faecalibacterium prausnitzii B     28         4141
## # … with 139,850 more rows
```


```r
td_group <-
  asd_tidy4 %>% 
  filter(group == "A")
td_group
```

```
## # A tibble: 139,860 x 5
##    genus            species                      group id    abundance
##    <fct>            <fct>                        <chr> <fct>     <dbl>
##  1 Faecalibacterium Faecalibacterium prausnitzii A     3          4988
##  2 Faecalibacterium Faecalibacterium prausnitzii A     5          5060
##  3 Faecalibacterium Faecalibacterium prausnitzii A     6          2905
##  4 Faecalibacterium Faecalibacterium prausnitzii A     9          5745
##  5 Faecalibacterium Faecalibacterium prausnitzii A     31         4822
##  6 Faecalibacterium Faecalibacterium prausnitzii A     51         3889
##  7 Faecalibacterium Faecalibacterium prausnitzii A     52         4646
##  8 Faecalibacterium Faecalibacterium prausnitzii A     53         6337
##  9 Faecalibacterium Faecalibacterium prausnitzii A     54         5064
## 10 Faecalibacterium Faecalibacterium prausnitzii A     59         6359
## # … with 139,850 more rows
```


```r
td_diversity <- td_group %>% 
  filter(abundance != 0) %>% 
  summarize(n_genus = n_distinct(genus), n_species = n_distinct(species))
td_diversity
```

```
## # A tibble: 1 x 2
##   n_genus n_species
##     <int>     <int>
## 1    1263      4357
```



```r
asd_diversity <-
asd_group %>% 
  filter(abundance != 0) %>% 
  summarize(n_genus = n_distinct(genus), n_species = n_distinct(species))
asd_diversity
```

```
## # A tibble: 1 x 2
##   n_genus n_species
##     <int>     <int>
## 1    1100      3763
```


```r
group <- c("td", "asd")
microbiome_diversity <-
  full_join(td_diversity, asd_diversity) %>% 
  cbind(group) %>% 
  select(group, n_genus, n_species)
```

```
## Joining, by = c("n_genus", "n_species")
```


```r
microbiome_diversity
```

```
##   group n_genus n_species
## 1    td    1263      4357
## 2   asd    1100      3763
```


```r
write.csv(microbiome_diversity, file = "microbiome_diversity.csv", row.names = FALSE)
```

