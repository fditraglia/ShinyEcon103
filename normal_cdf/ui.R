library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("CDF of a Standard Normal Random Variable"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    
    
    sliderInput("x0", 'Threshold for CDF (x0)', 
                min = -4, max = 4, value = -1, step= 0.1)
    
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("CDFplot")
  )
))