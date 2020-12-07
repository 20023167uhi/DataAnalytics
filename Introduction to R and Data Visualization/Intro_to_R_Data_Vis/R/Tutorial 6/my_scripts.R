clean_data <- function(df){
  df[df == "---"] <- "NA"
  df[] <- lapply(df, gsub, pattern = '\\*', replacement = '')
  df[] <- sapply(df[], as.numeric)
  return (df)
}

get_data <- function(fp){
  df <- read_tsv(fp)
  df <- clean_data(df) # from above
  return (df)
}