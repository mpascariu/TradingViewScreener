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
  "time",
  "earnings_release_date",
  
  # Trading variables
  "Perf.YTD",
  "close",
  "Value.Traded",

  # Price to pay
  "price_earnings_ttm",
  "price_revenue_ttm",
  "price_free_cash_flow_ttm",
  "price_sales_ratio",
  "price_book_ratio",

  # # Balance sheet
  "market_cap_basic",
  # "total_shares_diluted",
  "diluted_shares_outstanding_fq",
  "cash_n_equivalents_fq",
  "net_debt",
  "debt_to_equity",
  "cash_ratio",

  #Profitability
  "total_revenue_yoy_growth_ttm",
  "return_on_assets",
  "operating_margin",

  # Yield
  "dividend_yield_recent",
  "buyback_yield",

  # Ratings
  "Recommend.All",
  "recommendation_buy",
  "recommendation_sell",
  "recommendation_total"
  # "twitter_positive",
  # "twitter_negative"
)

market   = "america"
type     = "stock"
subtype  = "common"
sortby   = "Value.Traded"
range    = 0:10000

df <- query_tradingview(columns, market, type, subtype, sortby, range) 

df %>% 
  filter(is_primary == TRUE) %>% 
  print(width = Inf, n = 30)
  










