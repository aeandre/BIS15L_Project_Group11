library("tidyverse")
library("shiny")

microbiome_diversity <- read_csv(here("Final Project/Copy_others copy/Ally/microbiome_diversity copy.csv"))
demographics_and_abundance <- read_csv(here("Final Project/Copy_others copy/Ally/demographics_and_abundance copy.csv"))

ui <- fluidPage(    
  
  titlePanel("Genera Abundance Versus Demographics"),
  
  sidebarLayout(      
    
    sidebarPanel(
      selectInput("x", "Select X Variable", choices = c("age", "gender"), selected = "age"),
      selectInput("y", "Select Y Variable", choices = c("abundance"), selected = "abundance"),
      
      hr(),
      helpText("Reference: Zhou Dan, et al. (2020) Altered gut microbial profile is associated with abnormal metabolism activity of Autism Spectrum Disorder, Gut Microbes, 11:5, 1246-1267, DOI: 10.1080/19490976.2020.1747329
")
    ),
    
    mainPanel(
      plotOutput("Plot")  
    )
    
  )
)

server <- function(input, output) {
  
  output$Plot <- renderPlot({
    
    ggplot(demographics_and_abundance, aes_string(x = input$x, y = input$y, fill= as.factor("abundance"))) + geom_col(position = "dodge") + theme(axis.text.x = element_text()) + theme(plot.title = element_text(size = rel(1.5)))+ scale_fill_manual(values = "darkred")
  })
}

shinyApp(ui, server)