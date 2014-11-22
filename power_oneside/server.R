library(shiny)

power.plot <- function(alpha, mu, n, sigma){
  crit.value <- qnorm(1 - alpha)
  shift <- sqrt(n) * mu / sigma
  #Calculate the power of the test
  power <- 1 - pnorm(crit.value - shift)
  power <- round(power, 2)
  #Set up plotting region
  max.mu <- 1
  max.n <- 50
  min.sigma <- 1
  max.shift <- sqrt(max.n) * max.mu / min.sigma
  max.x <- max.shift + 2
  min.x <- -3 
  max.fx <- dnorm(0)
  x <- seq(min.x, max.x, 0.05)
  dist.h0 <- dnorm(x)
  dist.h1 <- dnorm(x, mean = shift)
  y <- cbind(dist.h0, dist.h1)
  matplot(x, y, type = 'l', lty = c(2,1), col = c('black', 'black'), xlab = "Dashed Line: Sampling Distribution Under the Null (mu = 0)", ylab = "", ylim = c(0, max.fx * 1.1), xlim = c(min.x, max.x), main = bquote(1 - beta == .(power)), cex.lab = 1.3, cex.main = 1.5)
  text(0, 1.02 * max.fx, "Fail to\n Reject", col = "red", cex = 1.2)
  text(min.x + 0.8 * (max.x - min.x) , 1.02 * max.fx, "Reject", col = "blue", cex = 1.2)
  x.upper <- x[x > crit.value]
  y.upper <- dnorm(x.upper, mean = shift)
  x.upper <- c(x.upper[1], x.upper, tail(x.upper, 1))
  y.upper <- c(0, y.upper, 0)
  polygon(x.upper, y.upper, density = 10, col = "blue")
  abline(v = crit.value, col = 'red', lty = 1, lwd = 2)
}


shinyServer(function(input, output) {
  
  alpha <- reactive({ input$alpha })
  mu <- reactive({ input$mu })
  n <- reactive({ input$n })
  sigma <- reactive({ input$sigma })
  
  output$PowerPlot <- renderPlot({
    
    power.plot(alpha(), mu(), n(), sigma())
    
  })
  
  
})