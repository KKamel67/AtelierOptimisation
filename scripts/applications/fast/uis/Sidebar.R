Sidebar = dashboardSidebar(
	  width = 500
	, selectInput(inputId = "col_filter", label = "Colonne de filtre", choices = c("moyen_paiement", "statut_paiement", "statut_commande"), multiple = FALSE)
	, uiOutput("values") 	
)
