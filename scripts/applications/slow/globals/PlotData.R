plot_data <- function(df) {
  
  fig <- plot_ly()
  if (nrow(df) > 0) {
    fig <- plot_ly(df, x = ~date_commande, y = ~id, type = 'scatter', mode = 'lines')
  }
  
  return(fig)
}

