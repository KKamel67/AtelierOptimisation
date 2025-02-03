dt_commande <- as.data.table(commande)
commande_fois10 <- do.call("rbind",lapply(1:10, function(x) commande))
dt_commande_fois10 <- as.data.table(commande_fois10)

dt_commande_produit <- as.data.table(commande_produit)
commande_produit_fois10 <- do.call("rbind",lapply(1:10, function(x) commande_produit))
dt_commande_produit_fois10 <- as.data.table(commande_produit_fois10)


# Filtering
f1_filter <- function(df){
  return(df[df$prix_total > 65,])
}

f2_filter <- function(dt){
  return(dt[prix_total > 65,])
}

microbenchmark(f1_filter(commande_produit), times = 1000)
microbenchmark(f2_filter(dt_commande_produit), times = 1000)

microbenchmark(f1_filter(commande_produit_fois10), times = 1000)
microbenchmark(f2_filter(dt_commande_produit_fois10), times = 1000)

# Aggregating
f1_aggregate <- function(df){
  return(aggregate(x = commande$montant, by = list(commande$date_commande), FUN = "sum"))
}

f2_aggregate <- function(dt){
  return(dt[,lapply(.SD,sum),by=date_commande, .SDcols=c("montant")])
}


microbenchmark(f1_aggregate(commande), times = 1000)
microbenchmark(f2_aggregate(dt_commande), times = 1000)

microbenchmark(f1_aggregate(commande_fois10), times = 1000)
microbenchmark(f2_aggregate(dt_commande_fois10), times = 1000)
