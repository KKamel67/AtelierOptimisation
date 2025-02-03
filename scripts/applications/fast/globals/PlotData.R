plot_data <- function(dt) {
  
  fig <- plot_ly()
  if (nrow(dt) > 0) {
    fig <- plot_ly(dt, x = ~date_commande, y = ~id, type = 'scatter', mode = 'lines')
  }
  
  return(fig)
}

