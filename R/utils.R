# -------------------------------------------------------------- #
# Title:
# Author: Marius D. PASCARIU
# Last Update: Sun Jun  2 21:46:45 2024
# -------------------------------------------------------------- #

null_to_na_recurse <- function(obj) {
  if (is.list(obj)) {
    obj <- jsonlite:::null_to_na(obj)
    obj <- lapply(obj, null_to_na_recurse)
  }
  return(obj)
}
