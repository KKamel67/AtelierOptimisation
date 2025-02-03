# Chargement des fichiers du répertoire uis
liste_ui_files <- list.files( path = "./uis/", pattern = ".*\\.R")

if( length(liste_ui_files) > 0 ){
	
	for (ui_file in liste_ui_files) {
		source( file = file.path( paste0("./uis/"),  ui_file), encoding = "UTF-8", local = TRUE)
	}

	rm(ui_file, liste_ui_files)
}

dashboardPage(
  header  = Header,
  sidebar = Sidebar,					 
  body    = Body,
  title   = "Fast app",
  skin    = "green"
)
