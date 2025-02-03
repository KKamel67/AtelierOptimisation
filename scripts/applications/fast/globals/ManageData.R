
filter_data <- function(dt, col_filter, values) {
  
	keep <- c("id", "date_commande", col_filter)
  return(dt[get(col_filter) %in% values, .SD, .SDcols = keep])
}

aggregate_data_by_date_cmd <- function(dt) {
  
  dt_agg <- data.frame()
  if (nrow(dt) > 0) {
    dt_agg <- dt[, .(id = .N), by = date_commande]
  }
  
  return(dt_agg)
}
