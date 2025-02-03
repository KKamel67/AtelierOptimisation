
library(generator)

full_names <- r_full_names(1000000)
full_names_splitted <- strsplit(full_names, split = " ")
prenoms <- sapply(full_names_splitted, "[[", 1)
noms <- sapply(full_names_splitted, "[[", 2)

employees <- data.frame("prenom" = prenoms, "nom" = noms)


# Parcours
f1_parcours <- function(df) {

  df$quadrigram <- NA
  df$email <- NA

  for (i in seq(1,nrow(df))) {
    df[i,"quadrigram"] <- paste0(substr(df[i,"prenom"],1,1),toupper(substr(df[i,"nom"],1,3)))
    df[i,"email"] <- sprintf("%s.%s@notresocietedata.com",tolower(substr(df[i,"prenom"],1,1)),tolower(df[i,"nom"]))
  }

  return(df)
}


compute_rh_elements <- function(nom, prenom) {

  first_letter_prenom <- substr(prenom,1,1)

  return(list("quadrigram"= paste0(first_letter_prenom,toupper(substr(nom,1,3))),
              "email" = sprintf("%s.%s@notresocietedata.com",tolower(first_letter_prenom),tolower(nom))
              )
         )
}

f2_parcours <- function(df) {

  rh_elements <- compute_rh_elements(nom = df$nom, prenom = df$prenom)
  df$quadrigram <- rh_elements[["quadrigram"]]
  df$email <- rh_elements[["email"]]

  return(df)
}

microbenchmark(f1_parcours(employees), times = 10)
microbenchmark(f2_parcours(employees), times = 10)
