# -------------------------------------------------------------- #
# Title:
# Author: Marius D. PASCARIU
# Last Update: Sat Jun  1 21:42:17 2024
# -------------------------------------------------------------- #
remove(list = ls())
library(tidyverse)
library(httr)
library(jsonlite)
library(data.table)




SCREEN_TRADINGVIEW <- function(
    columns  = c("name", "close", "market_cap_basic"), 
    market   = "america",
    exchange = c("AMEX", "NASDAQ", "NYSE"),
    type     = c("stock", "dr", "fund"),
    subtype  = c("common", "etf", "unit", "mutual", "money", "reit", "trust"),
    sortby   = "market_cap_basic",
    range    = 0:50
    ) {

  
  json_body = CUSTOM_API_SETTINGS(columns, market, exchange, type, subtype, sortby, range)
  
  raw_data <- httr::POST(
    url    = URL_TRADINGVIEW(market),
    config = httr::add_headers(.headers = HEADERS), 
    body   = json_body
    ) %>% 
    content("text") %>% 
    fromJSON()
  
  my_df_data <- rbindlist(
    lapply(raw_data$data$d, function(x) {
      data.frame(t(data.frame(x)), stringsAsFactors = FALSE)
    })) %>% 
    as_tibble()
}

SCREEN_TRADINGVIEW()


json <- CUSTOM_API_SETTINGS(
    columns  = c("name", "close", "market_cap_basic"), 
    market   = "america",
    exchange = c("AMEX", "NASDAQ", "NYSE"),
    type     = c("stock", "dr", "fund"),
    subtype  = c("common", "etf", "unit", "mutual", "money", "reit", "trust"),
    sortby   = "market_cap_basic",
    range    = 0:50
)











names(my_df_data) <- columns_ %>% 
  str_remove_all('\"') %>% 
  str_remove_all('\n ') %>% 
  str_split(', ') %>% 
  unlist()

final_data <- my_df_data %>% 
  mutate_at(vars(matches("close")), as.numeric) %>% 
  print(width = Inf)

