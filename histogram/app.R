library(shiny)

midterms <- read.csv('http://ditraglia.com/econ103/midterms.csv')
midterms <- na.omit(midterms)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Undersmoothing vs. Oversmoothing"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins",
                     "Number of bins:",
                     min = 1,
                     max = 50,
                     value = 10)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("regPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$regPlot <- renderPlot({
      # generate bins based on input$bins from ui.R
      x    <- midterms[, 2] 
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      # draw the histogram with the specified number of bins
      hist(x, breaks = bins, col = 'darkgray', border = 'white',
           main = 'Histogram of Exam Scores')
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

