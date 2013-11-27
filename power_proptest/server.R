library(shiny)


shinyServer(function(input, output) {
  
  p <- reactive({ input$p })
  n <- reactive({ input$n })
  alpha <- reactive({ input$alpha })
  
  output$PowerPlot <- renderPlot({
    
    #These are the only calculations that depend on the inputs directly
    crit.value <- qnorm(1 - alpha() / 2)
    mu <- sqrt(n()) * (2 * p() - 1)
    sigma.squared <- 4 * p() * (1 - p())
    
    #Calculate the power of the test
    p.lower <- pnorm(-crit.value, mean = mu, sd = sqrt(sigma.squared))
    p.upper <- 1 - pnorm(crit.value, mean = mu, sd = sqrt(sigma.squared))
    power <- p.lower + p.upper
    power <- round(power, 2)
    
    #Set up plotting region
    max.p <- 0.75
    max.n <- 200
    min.n <- 20
    min.p <- 1 - max.p
    max.mu <- sqrt(max.n) * (2 * max.p - 1)
    max.sigma <- sqrt(4 * 0.5 * 0.5)
    min.sigma <- sqrt(4 * max.p * min.p)
    max.x <- max.mu + 3 * max.sigma
    min.x <- -max.mu - 3 * max.sigma
    max.fx <- dnorm(0, mean = 0, sd = min.sigma)
    
    x <- seq(min.x, max.x, 0.05)
    dist.h0 <- dnorm(x, mean = 0, sd = 1)
    
    dist.h1 <- dnorm(x, mean = mu, sd = sqrt(sigma.squared))
    
    y <- cbind(dist.h0, dist.h1)
    matplot(x, y, type = 'l', lty = c(2,1), col = c('black', 'black'), 
            xlab = "Dashed Line: Sampling Distribution Under the Null (p = 1/2)",
            ylab = "", ylim = c(0, max.fx * 1.1), 
            xlim = c(min.x, max.x), main = bquote(1 - beta == .(power)), 
            cex.lab = 1.3, cex.main = 1.5)
    
    
    text(0, 1.02 * max.fx, "Fail to\n Reject", col = "red", cex = 1.2)
    text(min.x + 0.2 * (max.x - min.x) , 1.02 * max.fx, "Reject", 
         col = "blue", cex = 1.2)
    text(min.x + 0.8 * (max.x - min.x) , 1.02 * max.fx, "Reject", 
         col = "blue", cex = 1.2)
    
    x.lower <- x[x < -crit.value]
    y.lower <- dnorm(x.lower, mean = mu, sd = sqrt(sigma.squared))
    x.lower <- c(x.lower[1], x.lower, tail(x.lower, 1))
    y.lower <- c(0, y.lower, 0)
    
    
    x.upper <- x[x > crit.value]
    y.upper <- dnorm(x.upper, mean = mu, sd = sqrt(sigma.squared))
    x.upper <- c(x.upper[1], x.upper, tail(x.upper, 1))
    y.upper <- c(0, y.upper, 0)
    
    
    polygon(x.lower, y.lower, density = 10, col = "blue")
    polygon(x.upper, y.upper, density = 10, col = "blue")
    
    abline(v = c(-crit.value, crit.value), col = 'red', lty = 1, lwd = 2)
    
    
  })
  
  
})
