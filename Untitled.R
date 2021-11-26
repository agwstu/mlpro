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


# zadanie 2.16


###(AO;  Rozwijanie  macierzy). Napisz funkcj¦ rozwin(), która przeksztaªca dan¡ macierz
#rozmiaru n   m (niekoniecznie liczbow¡) z ustawionym atrybutem dimnames na ramk¦ danych zawieraj¡c¡
#nm obserwacji i trzy kolumny o nazwach zadanych przy u»yciu odpowiedniego argumentu funkcji. Warto±ci
#z macierzy maj¡ znajdowa¢ si¦ w pierwszej kolumnie, a w kolejnych dwóch   kombinacje nazw wierszy
#i kolumn odpowiadaj¡ce podanym poziom czynnika.
#Na przykªad obiekt WorldPhones (wbudowany) zawiera dane o liczbie telefonów (w tysi¡cach) w ró»nych
#regionach ±wiata w wybranych


## PADR
## Zadanie 2.16



rozwin <- function(X, name){
  stopifnot(is.matrix(X))# is.data.frame(x)
  stopifnot(!is.null(dimnames(X)))
  stopifnot(is.character(name), length(name) == 3)
  
  res <- data.frame(as.double(X), # rozwijamy macierz
                    # pamiętamy o układzie kolumnowym w macierzach więc:
                    # powtarzmy każdą nazwę kolumny nrow(X) razy
                    rep(colnames(X), each=nrow(X)),
                    # wektor etykiet wierszy (cały) nrow(X) razy
                    rep(rownames(X), times=ncol(X)))
  colnames(res) <- name # ustawiamy żądane nazwy kolumn
  return(res) # i zwracamy - wystarczy samo res
}



d <- rozwin(WorldPhones, c("ile", "gdzie", "kiedy"))
head(d)



#### UWAGA: POR. pakiet rehsape2
# install.packages('reshape2')
library(reshape2)



?reshape2::melt
melt(WorldPhones, varnames = c("kiedy", "gdzie"), value.name="ile")



microbenchmark::microbenchmark(bazowy = rozwin(WorldPhones,
                                               c("ile", "gdzie", "kiedy")),
                               reshape2 = melt(WorldPhones))
typeof(1); typeof(1L); typeof(mean); typeof(NA)



> class(1); class(1L); class(mean); class(NA)



> typeof(c(1L, 2L)); typeof(c(1L, 2)); typeof(c(1, "1"))



ff <- factor(c("OK", "OK"), levels = c("OK", "NOK"))



typeof(ff); class(ff); str(ff)

attributes(ff)



attr(ff, "class") <- NULL



attributes(ff)



typeof(ff); class(ff); str(ff)

