run_all <- function(df, col_filter, values) {

  df_filter <- filter_data(df = df, col_filter = col_filter, values = values)
  df_by_date_commande <- aggregate_data_by_date_cmd(df_filter)
  
  return(plot_data(df = df_by_date_commande))
}
