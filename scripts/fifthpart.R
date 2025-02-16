library(digest)

f1_run <- function() {

  commande <- read.table(file = "./data/commande.csv", header = TRUE, sep = "\t", fileEncoding = "UTF-8")
  splitted_cmd_by_date <- split(commande, commande$date_commande)
  output_path <- file.path("./output", "generic")
  dir.create(output_path)

  lapply(names(splitted_cmd_by_date),
         FUN = function(date_cmd) {
           write.table(x = splitted_cmd_by_date[[date_cmd]],
                       file = file.path(output_path, paste0(date_cmd,".txt")),
                       row.names = FALSE
                       )
         }
  )
}




f2_run <- function() {

  commande <- read.table(file = "./data/commande.csv", header = TRUE, sep = "\t", fileEncoding = "UTF-8")
  unique_date_cmd <- unique(commande$date_commande)

  output_path <- file.path("./output", "generic")
  dir.create(output_path)

  real_files <- list.files(output_path, full.names = FALSE)
  missing_files <- setdiff(paste0(unique_date_cmd,".txt"), real_files)

  if (length(missing_files) > 0) {
    commande_filter <- commande[commande$date_commande %in% substr(missing_files,1,10),]
    splitted_cmd_by_date <- split(commande_filter, commande_filter$date_commande)
    lapply(names(splitted_cmd_by_date),
           FUN = function(date_cmd) {
             write.table(x = splitted_cmd_by_date[[date_cmd]],
                         file = file.path(output_path, paste0(date_cmd,".txt")),
                         row.names = FALSE
             )
           }
    )
  }
}


print(Sys.time())
f1_run()
print(Sys.time())

print(Sys.time())
f2_run()
print(Sys.time())



## Clé SHA
f1_run <- function() {

  commande <- read.table(file = "./data/commande.csv", header = TRUE, sep = "\t", fileEncoding = "UTF-8")
  splitted_cmd_by_date <- split(commande, commande$date_commande)
  output_path <- file.path("./output", "generic")
  dir.create(output_path)

  lapply(names(splitted_cmd_by_date),
         FUN = function(date_cmd) {
           write.table(x = splitted_cmd_by_date[[date_cmd]],
                       file = file.path(output_path, paste0(date_cmd,".txt")),
                       row.names = FALSE
           )
         }
  )
}


f2_run <- function() {

  commande <- read.table(file = "./data/commande.csv", header = TRUE, sep = "\t", fileEncoding = "UTF-8")
  new_digest <- digest(object= commande, algo = "sha1")
  previous_digest <- readLines("./data/metadata/sha.txt")

  if (previous_digest != new_digest) {
    cat("File has changed\n")
    cat("Let's go Amigo\n")
    splitted_cmd_by_date <- split(commande, commande$date_commande)
    output_path <- file.path("./output", "generic")
    dir.create(output_path)

    lapply(names(splitted_cmd_by_date),
           FUN = function(date_cmd) {
             write.table(x = splitted_cmd_by_date[[date_cmd]],
                         file = file.path(output_path, paste0(date_cmd,".txt")),
                         row.names = FALSE
             )
           }
    )
    writeLines(text = new_digest, "./data/metadata/sha.txt")
  } else {
    cat("File has not changed\n")
  }
}


