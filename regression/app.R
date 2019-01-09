library(shiny)

midterms <- read.csv('http://ditraglia.com/econ103/midterms.csv')
midterms <- na.omit(midterms)
x <- midterms[, 1]
y <- midterms[, 2]

# Function to plot a depiction of the sum of squared vertical deviations when
# predicting y using the linear function a + b * x
plot_RSS <- function(x, y, a, b, meanX = FALSE, meanY = FALSE, showDevs = TRUE){
  fitted <- a + b * x
  residuals <- y - fitted
  SS <- sum(residuals^2)
  plot(x, y, pch = 20, col = 'white', main = bquote(sum(d^2) ==  .(SS)), 
       xlab = bquote(hat(y) == .(a) + (.(b)) *x))
  if(meanX) abline(v = mean(x), lty = 2, lwd = 2)
  if(meanY) abline(h = mean(y), lty = 2, lwd = 2)
  abline(a, b, lwd = 2, col = 'red')
  if(showDevs) segments(x0 = x, y0 = y, x1 = x, y1 = fitted, col = 'red')
  points(x,y, pch = 20, col = 'blue')
}

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Minimizing the Sum of Squared Vertical Deviations"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("intercept",
                     "Intercept: a",
                     min = 0,
                     max = 120,
                     value = 120, step = 1),
         sliderInput("slope",
                     "Slope: b",
                     min = -0.8,
                     max = 0.8,
                     value = -0.6, step = 0.05),
         checkboxInput('showDevs', "Show vertical deviations", 
                       value = TRUE, width = NULL),
         checkboxInput('Xmean', "Show mean of x", value = FALSE, width = NULL),
         checkboxInput('Ymean', "Show mean of y", value = FALSE, width = NULL)
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
     
      plot_RSS(x, y, input$intercept, input$slope, input$Xmean, input$Ymean,
               input$showDevs)
      
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

