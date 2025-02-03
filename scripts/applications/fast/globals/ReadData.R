commande <- fread(file = "./data/commande.csv", header = TRUE, sep = "\t", encoding = "UTF-8")
dt_commande <- as.data.table(do.call("rbind",lapply(1:10, function(x) commande)))