library(memoise)

# Suite de Fibonacci
fibo <- function(n) {
  if (n < 2) {
    return(n)
  }
  return (fibo(n - 1) + fibo(n - 2))
}


fibo_memo <- memoise(function(n) {
  if (n < 2) {
    return(n)
  }
  return (fibo_memo(n - 1) + fibo_memo(n - 2))
}
)
