library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("Power: One-Sided Test for a Normal Mean, Population Variance Known"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    
    
    sliderInput("alpha", 'Significance Level', 
               min = 0.01, max = 0.2, value = 0.05, step= 0.01),
    
    sliderInput("n", 'Sample Size (n)', 
                min = 10, max = 50, value = 25, step= 1),
    
    sliderInput("sigma", 'Population Std. Dev.', 
                min = 0.1, max = 1, value = 0.5, step= 0.1),
    
    sliderInput("mu", 'True (unknown) Population Mean',
                min = 0, max = 1, value = 0.2, step = 0.1)
    
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("PowerPlot")
  )
))