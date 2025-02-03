
library(doParallel)


commande_splitted <- split(commande, commande$date_commande)

output_path <- "D:/Users/kemihakam/Desktop/Consortia/AtelierOptimisation/Optimisation/output"
output_path <- file.path(output_path,format(Sys.time(),"%y%m%d_%H%M%S"))
dir.create(output_path)


# Parallel
f1_write <- function(lst_df, output_path){

  lapply(names(lst_df),
        FUN = function(date_cmd) {
          write.table(x = lst_df[[date_cmd]], file = file.path(output_path, paste0(date_cmd,".txt")), row.names = FALSE)
        }
  )

}


f2_write <- function(lst_df, output_path){

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


f2_write <- function(df, output_path, parallel = TRUE){

  df_splitted <- split(df, df$date_commande)

  llply(names(df_splitted),
        .fun = function(date_cmd) {
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex1.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex2.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex3.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex4.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex5.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex6.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex7.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex8.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex9.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex10.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex11.txt")), row.names = FALSE)
           write.table(x = df_splitted[[date_cmd]], file = file.path(output_path, timestamp, paste0(date_cmd,"ex12.txt")), row.names = FALSE)
        },
        .parallel = parallel
  )
}




microbenchmark(f1_write(commande_splitted, output_path), times = 10)


closeAllConnections()
cl <- makeCluster(8)
registerDoParallel(cl)
paropts <- list(preschedule=TRUE)
clusterSetRNGStream(cl, 123)
microbenchmark(f2_write(commande_splitted), times = 10)
stopCluster(cl)
rm(cl)

