run_all <- function(dt, col_filter, values) {

  dt_filter <- filter_data(dt = dt, col_filter = col_filter, values = values)
  dt_by_date_commande <- aggregate_data_by_date_cmd(dt_filter)
  
  return(plot_data(dt = dt_by_date_commande))
}
