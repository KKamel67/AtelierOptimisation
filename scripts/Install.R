pkgs_to_install <- c("data.table", "dplyr", "plotly", "shiny", "generator", "plyr", "microbenchmark","shinydashboard")

sapply(pkgs_to_install, renv::install, prompt = FALSE)
