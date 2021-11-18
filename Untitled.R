###zaj3 r mini
set.seed(123)
x <- round(rnorm(20,0,1), 2)


x[which.min(abs(x-2))]
(x-min(x))/(max(x)-min(x))

n <- length(x)

y <- character(n)

y[which(x>0)] <- "nieujemna"
y[which(x<0)] <- "ujemna"

ifelse(x >= 0, "nieujemna", "ujemna")

#zad 1.2

x <- rnorm(20, 0, 1)
y <- -4*x + 1

r_pearson <- 1/(length(x) - 1)*(sum((x - mean(x))/sd(x)*((y - mean(y))/sd(y))))

d <- rank(x) - rank(y)

(r_spearman <- 1 - 6*sum(d^2)/(n*(n^2-1)))
p_value <- pt(r_spearman*sqrt((n-2)/(1-r_spearman^2)), length(x)-2)

###1.4 do domu

#zad. 1.5

gini <- function(y) {
  
  i <- 1:length(y)
  g <- sum((2*i - length(y) - 1)*y)/(length(y)*(length(y) - 1)*mean(y))
  
  return(g)
}

gini(rchisq(1000, 2))

# zad 1.7

cmt <- function(f, n = 1000, a, b) {
  
  stopifnot(is.function(f))
  stopifnot(is.numeric(a), is.numeric(b), length(a) ==1, length(b) ==1,
            is.numeric(n), n>=0, n == floor(n))
  stopifnot(f(a) >= 0, f(b) >= 0)
  
  fmin <- min(f(a), f(b))
  fmax <- max(f(a), f(b))
  x1 <- runif(n, min = a, max = b)
  y1 <- runif(n, min = fmin , max = fmax)
  

    
}








