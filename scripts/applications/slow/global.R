library(shiny)
library(shinydashboard)
library(plotly)


liste_global_files <- list.files(path = "./globals/", pattern = ".*\\.R")

if( length(liste_global_files) > 0 ){
	
	for (global_file in liste_global_files) {
		source( file = file.path( paste0("./globals/"),  global_file), encoding = "UTF-8", local = TRUE)
	}

	rm(global_file, liste_global_files)
}
