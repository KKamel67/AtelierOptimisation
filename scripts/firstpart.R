# Inutiles
f1_useless <- function(df){
  premiere_lettre <- letters[1]
  derniere_lettre <- letters[length(letters)]
  jeu_de_donnees <- df
  filtre <- jeu_de_donnees[jeu_de_donnees$prix_total > 65,]
  return("toto")
}

f2_useless <- function(){
  return("toto")
}

microbenchmark(f1_useless(commande_produit), times = 1000)
microbenchmark(f2_useless(), times = 1000)


# Répétées
f1_repeated <- function(){

  v_res <- c()
  for (i in seq(1,100)) {
    voyelles <- c("a", "e", "i", "o", "u", "y")
    random_letter <- sample(letters, 1)
    if (random_letter %in% voyelles) {
      res <- "Vous avez gagné"
    } else {
      res <- "Vous avez perdu"
    }
    v_res <- append(v_res, res)
  }
  return(v_res)
}

f2_repeated <- function(){

  voyelles <- c("a", "e", "i", "o", "u", "y")
  v_res <- c()
  for (i in seq(1,100)) {
    random_letter <- sample(letters, 1)
    if (random_letter %in% voyelles) {
      res <- "Vous avez gagné"
    } else {
      res <- "Vous avez perdu"
    }
    v_res <- append(v_res, res)
  }
  return(v_res)
}


microbenchmark(f1_repeated(), times = 10000)
microbenchmark(f2_repeated(), times = 10000)
