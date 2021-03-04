---
title: "Berlin ShinyApp Attempt"
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
microbiome <- read_csv(here("Berlin/a_ref_microbiome.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   group = col_character(),
##   id = col_double(),
##   abundance = col_double()
## )
```

```r
asd_group <- read_csv(here("Berlin/a_ref_asd_group.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   group = col_character(),
##   id = col_double(),
##   abundance = col_double()
## )
```

```r
td_group <- read_csv(here("Berlin/a_ref_td_group.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   genus = col_character(),
##   species = col_character(),
##   group = col_character(),
##   id = col_double(),
##   abundance = col_double()
## )
```

```r
microbiome_diversity <- read_csv(here("Berlin/a_ref_microbiome_diversity.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   group = col_character(),
##   n_genus = col_double(),
##   n_species = col_double()
## )
```

```r
unique_genera <- read_csv(here("Berlin/unique_genera.csv"))
```

```
## 
## ── Column specification ────────────────────────────────────────────────────────
## cols(
##   unique_names = col_character(),
##   unique_counts = col_double()
## )
```
Graphs Comparing TD and ASD Groups

```r
ui <- fluidPage(    
  
  titlePanel("TD and ASD Species/Genus Abundance"), 
  sidebarLayout(      
  sidebarPanel(
  selectInput("genus", "species", " Select Group of Interest:", choices=unique(microbiome_diversity$group)),
      hr(),
      helpText("Reference: Zhou Dan et al. (2020) Altered gut microbial profile is associated with abnormal metabolism activity of Autism Spectrum Disorder, Gut Microbes, 11:5, 1246-1267, DOI: 10.1080/19490976.2020.1747329")
    ),
    mainPanel(
      plotOutput("Plot")  
    )
    )
    )
server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  output$Plot <- renderPlot({
  ggplot(microbiome_diversity, aes_string(x = input$x, y = input$y, fill= "group")) + geom_col(position = "dodge") + theme(axis.text.x = element_text(angle = 60, hjust = 1)) + theme(plot.title = element_text(size = rel(1.5), hjust = 0.5))+ scale_fill_trek("romulan")
  })
  session$onSessionEnded(stopApp)
  }

shinyApp(ui, server)
```


Graphs comparing Genus, Species, and Unique Counts

```r
ui <- dashboardPage(
  dashboardHeader(title = "Abundance"),
  dashboardSidebar(),
  dashboardBody(
  selectInput("x", "Select X Variable", choices = c("group"), selected = "group"),
  selectInput("y", "Select Y Variable", choices = c("n_genus", "n_species", "unique_counts"), selected = "n_genus"),
  plotOutput("plot", width = "500px", height = "400px"))
)

server <- function(input, output, session) { 
  output$plot <- renderPlot({
  ggplot(microbiome_diversity, aes_string(x = input$x, y = input$y, fill= "group")) + geom_col(position = "dodge") + theme(axis.text.x = element_text()) + theme(plot.title = element_text(size = rel(1.5)))+ scale_fill_brewer(palette = "Set1")
  })
  session$onSessionEnded(stopApp)
  }
shinyApp(ui, server)
```
