
filter_data <- function(df, col_filter, values) {
  
  return(df[df[[col_filter]] %in% values,c("id","date_commande", col_filter)])
}


aggregate_data_by_date_cmd <- function(df) {
  
  df_agg <- data.frame()
  if (nrow(df) > 0) {
    df_agg <- aggregate(id ~ date_commande, data = df, FUN = length)
  }
  
  return(df_agg)
}
