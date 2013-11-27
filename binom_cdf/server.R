library(shiny)


shinyServer(function(input, output) {
  
  n <- reactive({ input$n })
  p <- reactive({ input$p })
  x0 <- reactive({ input$x0 })
  
  
  output$thresholdSlider <- renderUI({
    max.x0 <- n() + 1
    sliderInput("x0", 'Threshold for CDF (x0)', 
                min = -1, max = max.x0, value = -0.5, step= 0.1)
  })
  
  
  output$CDFplot <- renderPlot({
    
    support <- 0:n()
    xmin <- min(support) - 1
    xmax <- max(support) + 1
    x <- seq(from = xmin, to = xmax, by = (xmax - xmin)/499)
    
    pmf <- dbinom(support, size = n(), prob = p())
    cdf <- pbinom(x, size = n(), prob = p())
    cdf.x0 <- pbinom(x0(), size = n(), prob = p())
    pmf.col <- ifelse(support <= x0(), 'red', 'black')
    
    par(mfrow = c(1,2))
    
    plot(support, pmf, type = 'h', xlim = c(xmin, xmax), xlab = 'x', ylab = 'p(x)', ylim = c(0, max(pmf)), col = pmf.col, lwd = 2, main = "Probability Mass Function (pmf)")
    abline(v = x0(), col = "blue", lty = 2, lwd = 2)
    
    plot(x, cdf, type = 's', lwd = 2, xlab = expression(x[0]), ylab = expression(F(x[0])), main = "Cumulative Distribution Function (CDF)")
    points(x0(), cdf.x0, col = "blue", pch = 20, cex = 1.5)
    abline(v = x0(), col = "blue", lty = 2, lwd = 2)
    
    
    
    
  })
  
  
})
