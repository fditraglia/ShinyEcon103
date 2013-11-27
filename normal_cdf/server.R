library(shiny)


shinyServer(function(input, output) {
  
  x0 <- reactive({ input$x0 })
  
  
  
  output$CDFplot <- renderPlot({
    
    x <- seq(from = -5, to = 5, by = 0.05)
    pdf <- dnorm(x)
    cdf <- pnorm(x)
    
    cdf.x0 <- pnorm(x0())
    
    par(mfrow = c(1,2))
    
    plot(x, pdf, type = 'l', xlab = 'x', ylab = 'f(x)', main = 'Probability Density Function (pdf)', lwd = 2)
    
    x.shade <- x[x <= x0()]
    pdf.shade <- pdf[1:length(x.shade)]
    
    shade.points <- cbind(c(x.shade[1], x.shade, x.shade[length(x.shade)]), c(0, pdf.shade, 0))
    
    
    polygon(shade.points, density = 30, col = 'red')
    
    abline(v = x0(), col = "blue", lty = 2, lwd = 3)
    
    plot(x, cdf, type = 'l', xlab = expression(x[0]), ylab  = expression(F(x[0])), main = 'Cumulative Distribution Function (CDF)', lwd = 2)
    
    abline(v = x0(), col = "blue", lty = 2, lwd = 3)
    points(x0(), cdf.x0, col = "blue", pch = 20, cex = 1.5)
    
    
    
  })
  
  
})
