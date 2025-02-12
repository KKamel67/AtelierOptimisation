library(doParallel)

commande_splitted <- split(commande, commande$date_commande)


# Parallel
f1_write <- function(lst_df){

  output_path <- "D:/Users/kemihakam/Desktop/Consortia/AtelierOptimisation/Optimisation/output"
  output_path <- file.path(output_path,format(Sys.time(),"%y%m%d_%H%M%S"))
  dir.create(output_path)

  lapply(names(lst_df),
        FUN = function(date_cmd) {
          write.table(x = lst_df[[date_cmd]],
                      file = file.path(output_path, paste0(date_cmd,".txt")),
                      row.names = FALSE
                      )
        }
  )
}


f2_write <- function(lst_df){

  output_path <- "D:/Users/kemihakam/Desktop/Consortia/AtelierOptimisation/Optimisation/output"
  output_path <- file.path(output_path,format(Sys.time(),"%y%m%d_%H%M%S"))
  dir.create(output_path)

  llply(names(lst_df),
        .fun = function(date_cmd) {
           write.table(x = lst_df[[date_cmd]],
                       file = file.path(output_path, paste0(date_cmd,".txt")),
                       row.names = FALSE
                       )
        },
        .parallel = TRUE
  )
}


print(Sys.time())
f1_write(lst_df = commande_splitted)
print(Sys.time())


print(Sys.time())
closeAllConnections()
cl <- makeCluster(4)
registerDoParallel(cl)
paropts <- list(preschedule=TRUE)
clusterSetRNGStream(cl, 123)
f2_write(lst_df = commande_splitted)
stopCluster(cl)
rm(cl)
print(Sys.time())
