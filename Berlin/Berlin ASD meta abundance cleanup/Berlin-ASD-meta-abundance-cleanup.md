---
title: "Project Try Berlin"
author: "Berlin DeGroen"
output: 
  html_document: 
    keep_md: yes
---



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
#install.packages("VennDiagram")
#install.packages("ggvenn")
```



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
asd <- read_csv(here("Berlin/ASD meta abundance 2.csv"))
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
glimpse(asd)
```

```
## Rows: 5,619
## Columns: 61
## $ Taxonomy <chr> "g__Faecalibacterium;s__Faecalibacterium prausnitzii", "g__Hu…
## $ A3       <dbl> 4988, 5803, 3793, 64, 15, 100, 2119, 12, 453, 1266, 17, 524, …
## $ A5       <dbl> 5060, 5612, 2795, 1385, 20, 29, 1230, 24, 691, 1682, 119, 201…
## $ A6       <dbl> 2905, 4109, 1355, 725, 723, 11, 1322, 1, 2278, 43, 9, 101, 19…
## $ A9       <dbl> 5745, 1432, 5558, 1553, 620, 1320, 2675, 44, 107, 1726, 1938,…
## $ A31      <dbl> 4822, 2652, 5383, 40, 3261, 51, 1470, 26, 342, 1804, 49, 415,…
## $ A51      <dbl> 3889, 4175, 3505, 53, 43, 45, 2262, 9, 1304, 1441, 46, 292, 1…
## $ A52      <dbl> 4646, 3891, 5541, 33, 83, 52, 2984, 25, 1400, 2691, 44, 200, …
## $ A53      <dbl> 6337, 894, 4429, 175, 37, 64, 2004, 19, 1207, 1886, 42, 1226,…
## $ A54      <dbl> 5064, 4903, 4121, 58, 43, 60, 1904, 17, 2034, 919, 48, 394, 3…
## $ A59      <dbl> 6359, 2970, 3258, 1636, 1114, 896, 1227, 17, 2051, 2215, 27, …
## $ A67      <dbl> 3194, 4029, 1901, 1170, 2531, 26, 821, 15, 20, 1063, 2305, 66…
## $ A68      <dbl> 4486, 1266, 2940, 80, 207, 54, 1420, 7, 105, 1765, 37, 124, 1…
## $ A69      <dbl> 3807, 4822, 3820, 59, 59, 35, 167, 9, 752, 146, 28, 157, 7, 5…
## $ A71      <dbl> 6208, 1635, 5118, 77, 50, 1953, 1696, 127, 527, 2171, 1768, 1…
## $ A73      <dbl> 3008, 4761, 1582, 1364, 55, 23, 1389, 24, 478, 1679, 35, 113,…
## $ A76      <dbl> 5628, 1366, 4168, 67, 1194, 54, 1192, 17, 423, 948, 2002, 116…
## $ A78      <dbl> 5732, 1867, 3831, 63, 68, 50, 1772, 15, 260, 632, 33, 1114, 6…
## $ A87      <dbl> 5240, 2065, 3464, 7, 49, 70, 1807, 15, 2534, 1231, 101, 116, …
## $ A89      <dbl> 3616, 4777, 2942, 999, 979, 55, 144, 21, 1611, 1110, 46, 152,…
## $ A93      <dbl> 3355, 5954, 3291, 39, 10, 36, 1291, 18, 2758, 1317, 24, 237, …
## $ A101     <dbl> 3833, 6849, 4586, 3285, 3159, 1109, 1876, 31, 438, 2153, 31, …
## $ A109     <dbl> 3771, 4390, 1014, 30, 61, 25, 245, 17, 1595, 82, 24, 165, 1, …
## $ A113     <dbl> 5489, 2091, 4100, 54, 2606, 48, 1945, 17, 2038, 1116, 60, 103…
## $ A114     <dbl> 6762, 1638, 4336, 1168, 2821, 3034, 2036, 74, 747, 2065, 154,…
## $ A115     <dbl> 3045, 4613, 2301, 50, 21, 67, 1489, 11, 1336, 1033, 15, 79, 2…
## $ A142     <dbl> 6205, 2601, 6372, 38, 2276, 1196, 1754, 42, 646, 1169, 2649, …
## $ A144     <dbl> 6048, 1892, 4020, 49, 3, 123, 1556, 2940, 909, 1583, 1863, 12…
## $ A149     <dbl> 5418, 3267, 3511, 27, 34, 160, 2035, 20, 227, 1016, 35, 1202,…
## $ A164     <dbl> 5120, 2294, 4328, 1685, 2681, 49, 2370, 35, 402, 1592, 52, 13…
## $ A165     <dbl> 8504, 2978, 3906, 838, 2103, 1158, 2136, 82, 539, 1051, 1233,…
## $ B1       <dbl> 4269, 1217, 3853, 1624, 2452, 185, 1358, 30, 145, 1949, 28, 1…
## $ B2       <dbl> 4397, 6238, 4624, 1, 3, 41, 1850, 13, 2524, 1858, 21, 284, 1,…
## $ B3       <dbl> 4499, 2325, 3842, 703, 819, 24, 1504, 381, 2208, 2209, 48, 19…
## $ B5       <dbl> 6126, 5004, 4399, 43, 2761, 1418, 1566, 1569, 453, 1979, 338,…
## $ B6       <dbl> 7020, 2829, 3916, 46, 691, 119, 1831, 15, 236, 2451, 383, 260…
## $ B7       <dbl> 5404, 2192, 3355, 1505, 2768, 23, 643, 4, 2670, 750, 14, 1052…
## $ B8       <dbl> 4404, 2921, 5165, 32, 25, 757, 2117, 22, 1656, 1563, 974, 135…
## $ B13      <dbl> 5811, 4303, 4453, 1474, 1095, 629, 1581, 16, 2566, 2502, 30, …
## $ B14      <dbl> 3360, 2793, 1999, 2, 13, 12, 1229, 2, 128, 1262, 9, 67, 1, 20…
## $ B28      <dbl> 4141, 3671, 3974, 52, 4, 37, 2649, 53, 46, 1989, 41, 123, 154…
## $ B29      <dbl> 2880, 5350, 1185, 4, 4, 7, 1284, 16, 2564, 1146, 8, 97, 2, 0,…
## $ B36      <dbl> 3805, 4566, 3895, 5, 6, 8, 818, 40, 1438, 2241, 38, 86, 143, …
## $ B37      <dbl> 4168, 3984, 2710, 43, 356, 19, 1451, 61, 2142, 1341, 25, 92, …
## $ B94      <dbl> 4543, 5597, 3425, 1449, 2380, 65, 1999, 57, 323, 1038, 29, 14…
## $ B99      <dbl> 2804, 5191, 1559, 5, 23, 13, 108, 888, 563, 572, 16, 108, 3, …
## $ B103     <dbl> 5728, 2204, 4902, 36, 3089, 851, 2361, 20, 776, 1756, 1448, 1…
## $ B106     <dbl> 3827, 5523, 3016, 34, 33, 34, 2246, 9, 437, 727, 18, 313, 1, …
## $ B111     <dbl> 6030, 1556, 6066, 37, 2052, 208, 1839, 1718, 475, 653, 55, 13…
## $ B114     <dbl> 4950, 4983, 5082, 113, 2801, 803, 1769, 1473, 1537, 2117, 113…
## $ B115     <dbl> 4749, 5993, 3764, 46, 2, 30, 2045, 33, 580, 1132, 17, 1274, 5…
## $ B120     <dbl> 4471, 2126, 4085, 2065, 90, 829, 2475, 15, 1555, 1099, 411, 1…
## $ B127     <dbl> 5868, 4429, 6041, 21, 22, 136, 1649, 1711, 554, 2072, 500, 14…
## $ B132     <dbl> 6561, 2598, 6188, 27, 30, 159, 2018, 1456, 389, 1868, 1383, 1…
## $ B141     <dbl> 4910, 4222, 3960, 55, 1027, 22, 1999, 11, 548, 1853, 28, 265,…
## $ B142     <dbl> 4492, 4925, 4403, 35, 2641, 41, 2027, 9, 1815, 2277, 77, 179,…
## $ B143     <dbl> 2812, 5753, 2841, 8, 4, 10, 180, 46, 1508, 1069, 18, 52, 3, 0…
## $ B152     <dbl> 5303, 1261, 2746, 884, 1587, 28, 2134, 19, 1169, 1226, 18, 53…
## $ B156     <dbl> 4205, 1822, 3808, 13, 2223, 38, 1134, 25, 321, 1601, 19, 1257…
## $ B158     <dbl> 3430, 2478, 3856, 3, 6, 15, 1487, 47, 2169, 839, 35, 94, 1, 1…
## $ B164     <dbl> 4563, 4868, 3211, 218, 1473, 64, 1797, 8, 159, 1278, 12, 732,…
```

```r
summary(asd)
```

```
##    Taxonomy               A3               A5                A6         
##  Length:5619        Min.   :   0.0   Min.   :   0.00   Min.   :   0.00  
##  Class :character   1st Qu.:   0.0   1st Qu.:   0.00   1st Qu.:   0.00  
##  Mode  :character   Median :   0.0   Median :   0.00   Median :   0.00  
##                     Mean   :  13.1   Mean   :  15.41   Mean   :  10.35  
##                     3rd Qu.:   1.0   3rd Qu.:   1.00   3rd Qu.:   1.00  
##                     Max.   :5803.0   Max.   :5612.00   Max.   :4109.00  
##        A9              A31               A51               A52         
##  Min.   :   0.0   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.0   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.0   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :  20.9   Mean   :  17.03   Mean   :  11.92   Mean   :  15.55  
##  3rd Qu.:   2.0   3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00  
##  Max.   :5745.0   Max.   :5383.00   Max.   :4175.00   Max.   :5541.00  
##       A53               A54              A59               A67         
##  Min.   :   0.00   Min.   :   0.0   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.00   1st Qu.:   0.0   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.00   Median :   0.0   Median :   0.00   Median :   0.00  
##  Mean   :  16.71   Mean   :  18.3   Mean   :  18.81   Mean   :  10.48  
##  3rd Qu.:   1.00   3rd Qu.:   1.0   3rd Qu.:   1.00   3rd Qu.:   1.00  
##  Max.   :6337.00   Max.   :5064.0   Max.   :6359.00   Max.   :4029.00  
##       A68                A69               A71               A73          
##  Min.   :   0.000   Min.   :   0.00   Min.   :   0.00   Min.   :   0.000  
##  1st Qu.:   0.000   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.000  
##  Median :   0.000   Median :   0.00   Median :   0.00   Median :   0.000  
##  Mean   :   9.827   Mean   :  13.57   Mean   :  23.31   Mean   :   9.676  
##  3rd Qu.:   1.000   3rd Qu.:   1.00   3rd Qu.:   2.00   3rd Qu.:   1.000  
##  Max.   :4486.000   Max.   :4822.00   Max.   :6208.00   Max.   :4761.000  
##       A76               A78               A87               A89         
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :  16.31   Mean   :  14.65   Mean   :  13.69   Mean   :  13.52  
##  3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00  
##  Max.   :5628.00   Max.   :5732.00   Max.   :5240.00   Max.   :4777.00  
##       A93              A101              A109              A113        
##  Min.   :   0.0   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.0   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.0   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :  15.3   Mean   :  19.72   Mean   :   9.58   Mean   :  16.29  
##  3rd Qu.:   1.0   3rd Qu.:   2.00   3rd Qu.:   1.00   3rd Qu.:   1.00  
##  Max.   :5954.0   Max.   :6849.00   Max.   :4390.00   Max.   :5489.00  
##       A114              A115              A142              A144        
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.00   Median :   0.00   Median :   1.00   Median :   0.00  
##  Mean   :  24.22   Mean   :  11.56   Mean   :  24.75   Mean   :  18.39  
##  3rd Qu.:   2.00   3rd Qu.:   1.00   3rd Qu.:   3.00   3rd Qu.:   1.00  
##  Max.   :6762.00   Max.   :4613.00   Max.   :6372.00   Max.   :6048.00  
##       A149              A164              A165               B1         
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :  15.59   Mean   :  19.13   Mean   :  21.77   Mean   :  14.11  
##  3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   2.00   3rd Qu.:   1.00  
##  Max.   :5418.00   Max.   :5120.00   Max.   :8504.00   Max.   :4269.00  
##        B2                B3                B5                B6        
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.0  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.0  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.0  
##  Mean   :  13.93   Mean   :  15.58   Mean   :  20.82   Mean   :  11.9  
##  3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   2.00   3rd Qu.:   1.0  
##  Max.   :6238.00   Max.   :4499.00   Max.   :6126.00   Max.   :7020.0  
##        B7                B8               B13               B14          
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.000  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.000  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.000  
##  Mean   :  12.52   Mean   :  14.19   Mean   :  17.18   Mean   :   7.961  
##  3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   0.000  
##  Max.   :5404.00   Max.   :5165.00   Max.   :5811.00   Max.   :3360.000  
##       B28              B29                B36                B37         
##  Min.   :   0.0   Min.   :   0.000   Min.   :   0.000   Min.   :   0.00  
##  1st Qu.:   0.0   1st Qu.:   0.000   1st Qu.:   0.000   1st Qu.:   0.00  
##  Median :   0.0   Median :   0.000   Median :   0.000   Median :   0.00  
##  Mean   :  10.7   Mean   :   8.367   Mean   :   9.789   Mean   :  12.84  
##  3rd Qu.:   1.0   3rd Qu.:   0.000   3rd Qu.:   0.000   3rd Qu.:   1.00  
##  Max.   :4141.0   Max.   :5350.000   Max.   :4566.000   Max.   :4168.00  
##       B94               B99                B103              B106       
##  Min.   :   0.00   Min.   :   0.000   Min.   :   0.00   Min.   :   0.0  
##  1st Qu.:   0.00   1st Qu.:   0.000   1st Qu.:   0.00   1st Qu.:   0.0  
##  Median :   0.00   Median :   0.000   Median :   0.00   Median :   0.0  
##  Mean   :  16.18   Mean   :   8.055   Mean   :  17.52   Mean   :  15.6  
##  3rd Qu.:   1.00   3rd Qu.:   0.000   3rd Qu.:   1.00   3rd Qu.:   1.0  
##  Max.   :5597.00   Max.   :5191.000   Max.   :5728.00   Max.   :5523.0  
##       B111              B114              B115              B120       
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.0  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.0  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.0  
##  Mean   :  21.54   Mean   :  20.96   Mean   :  15.41   Mean   :  18.2  
##  3rd Qu.:   2.00   3rd Qu.:   2.00   3rd Qu.:   1.00   3rd Qu.:   1.0  
##  Max.   :6066.00   Max.   :5082.00   Max.   :5993.00   Max.   :4471.0  
##       B127              B132              B141              B142        
##  Min.   :   0.00   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.00   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :  20.57   Mean   :  20.24   Mean   :  13.41   Mean   :  14.84  
##  3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   1.00  
##  Max.   :6041.00   Max.   :6561.00   Max.   :4910.00   Max.   :4925.00  
##       B143               B152              B156              B158        
##  Min.   :   0.000   Min.   :   0.00   Min.   :   0.00   Min.   :   0.00  
##  1st Qu.:   0.000   1st Qu.:   0.00   1st Qu.:   0.00   1st Qu.:   0.00  
##  Median :   0.000   Median :   0.00   Median :   0.00   Median :   0.00  
##  Mean   :   8.747   Mean   :  12.92   Mean   :  13.77   Mean   :  10.21  
##  3rd Qu.:   0.000   3rd Qu.:   1.00   3rd Qu.:   1.00   3rd Qu.:   0.00  
##  Max.   :5753.000   Max.   :5303.00   Max.   :4205.00   Max.   :3856.00  
##       B164        
##  Min.   :   0.00  
##  1st Qu.:   0.00  
##  Median :   0.00  
##  Mean   :  10.02  
##  3rd Qu.:   1.00  
##  Max.   :4868.00
```



```r
names(asd)
```

```
##  [1] "Taxonomy" "A3"       "A5"       "A6"       "A9"       "A31"     
##  [7] "A51"      "A52"      "A53"      "A54"      "A59"      "A67"     
## [13] "A68"      "A69"      "A71"      "A73"      "A76"      "A78"     
## [19] "A87"      "A89"      "A93"      "A101"     "A109"     "A113"    
## [25] "A114"     "A115"     "A142"     "A144"     "A149"     "A164"    
## [31] "A165"     "B1"       "B2"       "B3"       "B5"       "B6"      
## [37] "B7"       "B8"       "B13"      "B14"      "B28"      "B29"     
## [43] "B36"      "B37"      "B94"      "B99"      "B103"     "B106"    
## [49] "B111"     "B114"     "B115"     "B120"     "B127"     "B132"    
## [55] "B141"     "B142"     "B143"     "B152"     "B156"     "B158"    
## [61] "B164"
```
##Pivoting longer

```r
asd_longer <- asd %>% 
  pivot_longer(-Taxonomy, names_to = "Condition", values_to = "Abundance")
asd_longer
```

```
## # A tibble: 337,140 x 3
##    Taxonomy                                            Condition Abundance
##    <chr>                                               <chr>         <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium prausnitzii A3             4988
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii A5             5060
##  3 g__Faecalibacterium;s__Faecalibacterium prausnitzii A6             2905
##  4 g__Faecalibacterium;s__Faecalibacterium prausnitzii A9             5745
##  5 g__Faecalibacterium;s__Faecalibacterium prausnitzii A31            4822
##  6 g__Faecalibacterium;s__Faecalibacterium prausnitzii A51            3889
##  7 g__Faecalibacterium;s__Faecalibacterium prausnitzii A52            4646
##  8 g__Faecalibacterium;s__Faecalibacterium prausnitzii A53            6337
##  9 g__Faecalibacterium;s__Faecalibacterium prausnitzii A54            5064
## 10 g__Faecalibacterium;s__Faecalibacterium prausnitzii A59            6359
## # … with 337,130 more rows
```
##Removing "Unclassified" from data

```r
asd_longer_no_unclassified <- asd_longer %>% 
  filter(!str_detect(Taxonomy, "Unclassified"))
asd_longer_no_unclassified
```

```
## # A tibble: 279,720 x 3
##    Taxonomy                                            Condition Abundance
##    <chr>                                               <chr>         <dbl>
##  1 g__Faecalibacterium;s__Faecalibacterium prausnitzii A3             4988
##  2 g__Faecalibacterium;s__Faecalibacterium prausnitzii A5             5060
##  3 g__Faecalibacterium;s__Faecalibacterium prausnitzii A6             2905
##  4 g__Faecalibacterium;s__Faecalibacterium prausnitzii A9             5745
##  5 g__Faecalibacterium;s__Faecalibacterium prausnitzii A31            4822
##  6 g__Faecalibacterium;s__Faecalibacterium prausnitzii A51            3889
##  7 g__Faecalibacterium;s__Faecalibacterium prausnitzii A52            4646
##  8 g__Faecalibacterium;s__Faecalibacterium prausnitzii A53            6337
##  9 g__Faecalibacterium;s__Faecalibacterium prausnitzii A54            5064
## 10 g__Faecalibacterium;s__Faecalibacterium prausnitzii A59            6359
## # … with 279,710 more rows
```


```r
asd_separate <- asd_longer_no_unclassified %>%
  separate(Taxonomy, into = c("Genus", "Species"), sep = ";") %>% 
  separate(Species, into = c("Species", "Strain"), sep = " " )
```

```
## Warning: Expected 2 pieces. Additional pieces discarded in 108780 rows [121,
## 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137,
## 138, 139, 140, ...].
```

```r
asd_separate
```

```
## # A tibble: 279,720 x 5
##    Genus               Species             Strain      Condition Abundance
##    <chr>               <chr>               <chr>       <chr>         <dbl>
##  1 g__Faecalibacterium s__Faecalibacterium prausnitzii A3             4988
##  2 g__Faecalibacterium s__Faecalibacterium prausnitzii A5             5060
##  3 g__Faecalibacterium s__Faecalibacterium prausnitzii A6             2905
##  4 g__Faecalibacterium s__Faecalibacterium prausnitzii A9             5745
##  5 g__Faecalibacterium s__Faecalibacterium prausnitzii A31            4822
##  6 g__Faecalibacterium s__Faecalibacterium prausnitzii A51            3889
##  7 g__Faecalibacterium s__Faecalibacterium prausnitzii A52            4646
##  8 g__Faecalibacterium s__Faecalibacterium prausnitzii A53            6337
##  9 g__Faecalibacterium s__Faecalibacterium prausnitzii A54            5064
## 10 g__Faecalibacterium s__Faecalibacterium prausnitzii A59            6359
## # … with 279,710 more rows
```



```r
asd_separate2 <- asd_separate %>% 
  separate(Genus, into = c("remove", "Genus"), sep = "__") %>% 
  separate(Species, into = c("remove_more", "Species"), sep = "__")
asd_separate2
```

```
## # A tibble: 279,720 x 7
##    remove Genus         remove_more Species        Strain    Condition Abundance
##    <chr>  <chr>         <chr>       <chr>          <chr>     <chr>         <dbl>
##  1 g      Faecalibacte… s           Faecalibacter… prausnit… A3             4988
##  2 g      Faecalibacte… s           Faecalibacter… prausnit… A5             5060
##  3 g      Faecalibacte… s           Faecalibacter… prausnit… A6             2905
##  4 g      Faecalibacte… s           Faecalibacter… prausnit… A9             5745
##  5 g      Faecalibacte… s           Faecalibacter… prausnit… A31            4822
##  6 g      Faecalibacte… s           Faecalibacter… prausnit… A51            3889
##  7 g      Faecalibacte… s           Faecalibacter… prausnit… A52            4646
##  8 g      Faecalibacte… s           Faecalibacter… prausnit… A53            6337
##  9 g      Faecalibacte… s           Faecalibacter… prausnit… A54            5064
## 10 g      Faecalibacte… s           Faecalibacter… prausnit… A59            6359
## # … with 279,710 more rows
```


```r
asd_hopefully_tidy <- asd_separate2 %>%
  select(-remove, -remove_more)
asd_hopefully_tidy
```

```
## # A tibble: 279,720 x 5
##    Genus            Species          Strain      Condition Abundance
##    <chr>            <chr>            <chr>       <chr>         <dbl>
##  1 Faecalibacterium Faecalibacterium prausnitzii A3             4988
##  2 Faecalibacterium Faecalibacterium prausnitzii A5             5060
##  3 Faecalibacterium Faecalibacterium prausnitzii A6             2905
##  4 Faecalibacterium Faecalibacterium prausnitzii A9             5745
##  5 Faecalibacterium Faecalibacterium prausnitzii A31            4822
##  6 Faecalibacterium Faecalibacterium prausnitzii A51            3889
##  7 Faecalibacterium Faecalibacterium prausnitzii A52            4646
##  8 Faecalibacterium Faecalibacterium prausnitzii A53            6337
##  9 Faecalibacterium Faecalibacterium prausnitzii A54            5064
## 10 Faecalibacterium Faecalibacterium prausnitzii A59            6359
## # … with 279,710 more rows
```
##Write.csv

```r
write.csv(asd_hopefully_tidy, file = "asd_hopefully_tidy.csv", row.names = FALSE)
```

