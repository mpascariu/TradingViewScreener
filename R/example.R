# -------------------------------------------------------------- #
# Title:
# Author: Marius D. PASCARIU
# Last Update: Sat Jun  1 21:42:17 2024
# -------------------------------------------------------------- #
remove(list = ls())
library(tidyverse)
library(httr)
library(rjson)


columns = c(
  "name", 
  "description",
  "exchange",
  "industry",
  "country",
  "is_primary",
  "currency",
  "close", 
  "Value.Traded",
  "market_cap_basic", 
  "recommendation_buy", 
  "recommendation_sell",
  "time"
)


query_tradingview(
  columns  = columns, 
  market   = "vietnam",
  type     = c("stock", "dr", "fund"),
  subtype  = c("common", "etf", "unit", "mutual", "money", "reit", "trust"),
  sortby   = "Value.Traded",
  range    = 0:50
) %>% 
  filter(is_primary == TRUE) %>% 
  print(width = Inf, n = Inf)
  










