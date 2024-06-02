# -------------------------------------------------------------- #
# Title:
# Author: Marius D. PASCARIU
# Last Update: Sun Jun  2 11:46:04 2024
# -------------------------------------------------------------- #



query_tradingview <- function(
    columns  = c("name", "market", "exchange", "close", "market_cap_basic"), 
    market   = "america",
    exchange = c("AMEX", "NASDAQ", "NYSE"),
    type     = c("stock", "dr", "fund"),
    subtype  = c("common", "etf", "unit", "mutual", "money", "reit", "trust"),
    sortby   = "market_cap_basic",
    range    = 0:50
) {
  
  httr::POST(
    url    = URL_TRADINGVIEW(market),
    config = httr::add_headers(.headers = HEADERS), 
    body   = CUSTOM_API_SETTINGS(columns, market, exchange, type, subtype, sortby, range)
  ) %>% 
    content("text") %>% 
    fromJSON() %>% 
    clean_tradingview_data(., columns)
  
}


clean_tradingview_data <- function(X, columns) {
  
  bind_rows(
    lapply(X$data$d, function(x) {
      data.frame(t(data.frame(unlist(x), row.names = columns)), row.names = NULL)
    })) %>% 
    as_tibble() %>%
    # format date columns
    mutate_at(
      vars(columns[columns %in% COLUMNS_DATE]), 
      function(x) as.POSIXct(as.numeric(x), origin="1970-01-01")
    ) %>% 
    # format numerical columns
    mutate_at(
      vars(columns[columns %in% COLUMNS_NUM]), as.numeric
    ) %>% 
    # format logical columns
    mutate_at(
      vars(columns[columns %in% COLUMNS_LOGIC]), as.logical
    ) 
    
  
}
