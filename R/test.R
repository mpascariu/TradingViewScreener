# -------------------------------------------------------------- #
# Title:
# Author: Marius D. PASCARIU
# Last Update: Sat Jun  1 21:42:17 2024
# -------------------------------------------------------------- #
remove(list = ls())
library(tidyverse)
library(httr)
library(jsonlite)


cols = c(
  "name", 
  "description",
  "industry",
  "country",
  "exchange",
  "is_primary",
  "currency",
  "close", 
  "market_cap_basic", 
  "recommendation_buy", 
  "recommendation_sell",
  "time"
)


query_tradingview(
  columns  = cols, 
  market   = "america",
  exchange = c("AMEX", "NASDAQ", "NYSE"),
  type     = c("stock", "dr", "fund"),
  subtype  = c("common", "etf", "unit", "mutual", "money", "reit", "trust"),
  sortby   = "market_cap_basic",
  range    = 0:50
) %>% 
  print(width = Inf)


