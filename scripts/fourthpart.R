
dt_commande_fois10 <- as.data.table(commande_fois10)

# Ordre des opérations : filtre/jointure
f1_order <- function(ref_client, tbl_cmd){

  merged <- base::merge(x = ref_client,y = tbl_cmd, by.x = "id", by.y ="id_client")
  res <- merged[merged$ville == "Paris" & merged$civilite  == "Mr",]

  return(res)
}


f2_order <- function(ref_client, tbl_cmd){

  ref_client_homme_paris <- ref_client[ref_client$ville == "Paris" & ref_client$civilite  == "Mr",]
  res <- base::merge(x = ref_client_homme_paris,y = tbl_cmd, by.x = "id", by.y ="id_client")

  return(res)
}


microbenchmark(f1_order(clients,commande_fois10), times = 100)
microbenchmark(f2_order(clients,commande_fois10), times = 100)

# commande %>% group_by(statut_paiement) %>% summarise("nb_id"= n())
# commande %>% group_by(moyen_paiement) %>% summarise("nb_id"= n())

# dd1 = commande %>% dplyr::filter(statut_paiement == "Refusée") %>% dplyr::filter(moyen_paiement == "CB")
# nrow(dd1)
# dd2 = commande %>% dplyr::filter(moyen_paiement == "CB") %>% dplyr::filter(statut_paiement == "Refusée")
# nrow(dd2)




# Ordre des opérations : filtres séquentiels
f1_order <- function(df){

  return(df %>% dplyr::filter(moyen_paiement == "CB") %>% dplyr::filter(statut_paiement == "Refusée"))
}


f2_order <- function(df){

  return(df %>% dplyr::filter(statut_paiement == "Refusée") %>% dplyr::filter(moyen_paiement == "CB"))
}


f3_order <- function(dt){

  return(dt[statut_paiement == "Refusée"][moyen_paiement == "CB"])
}


f4_order <- function(dt){

  return(dt[moyen_paiement == "CB"][statut_paiement == "Refusée"])
}


f5_order <- function(dt){

  return(dt[moyen_paiement == "CB" & statut_paiement == "Refusée"])
}


microbenchmark(f1_order(commande_fois10), times = 100)
microbenchmark(f2_order(commande_fois10), times = 100)
microbenchmark(f3_order(dt_commande_fois10), times = 1000)
microbenchmark(f4_order(dt_commande_fois10), times = 1000)
microbenchmark(f5_order(dt_commande_fois10), times = 1000)



# Ordre des opérations : filtre/agrégation
f1_order <- function(df){

  return(df %>% group_by(date_commande) %>% summarise("Montant"= sum(montant)) %>% dplyr::filter(date_commande %in% c('2023-03-26', '2023-05-02', '2023-09-06', '2023-11-12', '2023-02-01', '2023-12-17', '2023-02-22', '2023-03-09', '2023-11-02', '2023-02-10', '2023-06-16', '2023-12-12', '2023-08-23', '2023-03-06', '2023-07-25', '2023-06-21', '2023-12-03', '2023-08-06', '2023-02-15', '2023-09-15')))
}


f2_order <- function(df){

  return(df %>% dplyr::filter(date_commande %in% c('2023-03-26', '2023-05-02', '2023-09-06', '2023-11-12', '2023-02-01', '2023-12-17', '2023-02-22', '2023-03-09', '2023-11-02', '2023-02-10', '2023-06-16', '2023-12-12', '2023-08-23', '2023-03-06', '2023-07-25', '2023-06-21', '2023-12-03', '2023-08-06', '2023-02-15', '2023-09-15')) %>% group_by(date_commande) %>% summarise("Montant"= sum(montant)))
}

microbenchmark(f1_order(commande_fois10), times = 100)
microbenchmark(f2_order(commande_fois10), times = 100)

