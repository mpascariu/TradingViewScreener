# -------------------------------------------------------------- #
# Title: API setup
# Author: Marius D. PASCARIU
# Last Update: Sun Jun  2 20:40:08 2024
# -------------------------------------------------------------- #


URL_TRADINGVIEW <- function(market) {
  paste0('https://scanner.tradingview.com/', market, '/scan')
}


HEADERS = c(
  authority         = "scanner.tradingview.com", 
  accept            = "text/plain, */*; q=0.01", 
  origin            = "https =//www.tradingview.com", 
  `user-agent`      = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36", 
  `content-type`    = "application/x-www-form-urlencoded; charset=UTF-8", 
  `sec-fetch-site`  = "same-site", 
  `sec-fetch-mode`  = "cors", 
  referer           = "https =//www.tradingview.com/", 
  `accept-encoding` = "gzip, deflate, br", 
  `accept-language` = "en-US,en;q=0.9,it;q=0.8"
)


DEFAULT_API_SETTINGS <-
  '{"filter": [
    {"left": "market_cap_basic", "operation":"nempty"},
    {"left": "type", "operation":"in_range", "right":["stock", "dr", "fund"]},
    {"left": "subtype", "operation":"in_range", "right":["common", "etf", "unit", "mutual", "money", "reit", "trust"]},
    {"left": "exchange", "operation":"in_range", "right":[ "AMEX", "NASDAQ", "NYSE"]}
  ],
  "options":{"lang":"en"},
  "markets":["america"],
  "symbols":{"query":{"types":[]},"tickers":[]},
  "columns":["name", "close", "market_cap_basic"],
  "sort":{"sortBy":"market_cap_basic", "sortOrder":"desc"},
  "range":[0, 5000]}'


CUSTOM_API_SETTINGS <- function(
    columns, 
    market,
    exchange,
    type,
    subtype,
    sortby,
    range
) {
  
  type     = paste0('"', paste0(type, collapse = '","'), '"')
  subtype  = paste0('"', paste0(subtype, collapse = '","'), '"')
  exchange = paste0('"', paste0(exchange, collapse = '","'), '"')
  columns  = paste0('"', paste0(columns, collapse = '","'), '"')
  range    = paste0("[", min(range),",", max(range), "]")
  
  paste0(
    '{"filter": [
    {"left": "market_cap_basic", "operation":"nempty"},
    {"left": "type", "operation":"in_range", "right":[', type,']},
    {"left": "subtype", "operation":"in_range", "right":[', subtype,']},
    {"left": "exchange", "operation":"in_range", "right":[', exchange,']}
  ],
  "options":{"lang":"en"},
  "markets":["', market,'"],
  "symbols":{"query":{"types":[]},"tickers":[]},
  "columns":[', columns,'],
  "sort":{"sortBy":"', sortby,'", "sortOrder":"desc"},
  "range":', range, '}'
  )
}

get_exchanges <- function(market) {
  json_file <- URL_TRADINGVIEW(market)
  json_data <- fromJSON(file=json_file)
  exchanges <- unlist(json_data$data) %>% 
    str_remove("\\:.*") %>% 
    unique()
  
  return(exchanges)
}