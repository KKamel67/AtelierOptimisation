function(session,input, output) {
  
  output$values <- renderUI({
        selectInput("selected_values",
                    label = "Vos filtres",
                    choices =  unique(dt_commande[[input$col_filter]]),
                    multiple = TRUE
        )
  })
  
  output$myplot <- renderPlotly({ run_all(dt = dt_commande, col_filter = input$col_filter, values = input$selected_values) })

}
