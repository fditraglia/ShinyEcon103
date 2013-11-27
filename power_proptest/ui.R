library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("Power: Two-Sided Test for a Population Proportion"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    
    
    sliderInput("p", 'True Population Proportion (p)', 
                min = 0.25, max = 0.75, value = 0.25, step= 0.01),
    
    sliderInput("n", 'Sample Size (n)', 
                min = 20, max = 200, value = 20, step= 1),
    
    sliderInput("alpha", 'Significance Level (alpha)', 
                min = 0.01, max = 0.20, value = 0.05, step= 0.01)
    
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("PowerPlot")
  )
))