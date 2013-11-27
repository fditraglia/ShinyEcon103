library(shiny)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
  
  #  Application title
  headerPanel("CDF of a Binomial Random Variable"),
  
  # Sidebar with sliders that demonstrate various available options
  sidebarPanel(
    
    sliderInput("p", 'Probability of Success (p)', 
                min = 0.1, max = 0.9, value = 0.5, step= 0.1),
    
    sliderInput("n", 'Number of Bernoulli Trials (n)', 
                min = 1, max = 20, value = 10, step= 1),
    
    
    uiOutput("thresholdSlider") 
    
    #sliderInput("x0", 'Threshold for CDF (x0)', 
    #           min = -1, max = 31, value = 2.4, step= 0.1)
    
  ),
  
  # Show a table summarizing the values entered
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("CDFplot")
  )
))