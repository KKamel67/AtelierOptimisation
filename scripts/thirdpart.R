
library(generator)

full_names <- r_full_names(1000000)
full_names_splitted <- strsplit(full_names, split = " ")
prenoms <- sapply(full_names_splitted, "[[", 1)
noms <- sapply(full_names_splitted, "[[", 2)

employees <- data.frame("prenom" = prenoms, "nom" = noms)


# Enrichissement
f1_enrich <- function(df) {

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

f2_enrich <- function(df) {

  rh_elements <- compute_rh_elements(nom = df$nom, prenom = df$prenom)
  df$quadrigram <- rh_elements[["quadrigram"]]
  df$email <- rh_elements[["email"]]

  return(df)
}

microbenchmark(f1_enrich(employees), times = 10)
microbenchmark(f2_enrich(employees), times = 10)

print(Sys.time())
rr = f1_enrich(employees)
print(Sys.time())

# Création d'une liste de 10 data frame de 50 lignes (A exécuter une seule fois)
lst_df <- list()
for (i in seq(10)) {
  lst_df[[i]] <- data.frame("id" = rep(Sys.time(),50000), "rd_letter" = sample(letters,size = 50, replace = TRUE))
  Sys.sleep(1)
}


# Concat
f1_concat <- function(l){

  df_concat <- data.frame("id" = lubridate::POSIXct(0), "rd_letter" = character(0))

  for (i in seq(length(l))){
    df_concat <- rbind(df_concat,l[[i]])
  }

  return(df_concat)
}



f2_concat <- function(l){

  return(do.call("rbind", l))
}

microbenchmark(f1_concat(lst_df), times = 1000, unit = "milliseconds")
microbenchmark(f2_concat(lst_df), times = 1000, unit = "milliseconds")




## Reduce
f1_cbind <- function(l){

  df_concat <- l[[1]]

  for (i in seq(2,length(l))){
    df_concat <- cbind(df_concat,l[[i]])
  }

  return(df_concat)
}



f2_cbind <- function(l){

  return(Reduce(f = "cbind", x = lst_df))
}


microbenchmark(f1_cbind(lst_df), times = 10000, unit = "milliseconds")
microbenchmark(f2_cbind(lst_df), times = 10000, unit = "milliseconds")

# rowSums, colSums, setdiff, intersect, ....

