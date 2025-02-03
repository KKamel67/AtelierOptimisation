commande <- read.table(file = "./data/commande.csv", header = TRUE, sep = "\t", fileEncoding = "UTF-8")
commande <- do.call("rbind",lapply(1:10, function(x) commande))