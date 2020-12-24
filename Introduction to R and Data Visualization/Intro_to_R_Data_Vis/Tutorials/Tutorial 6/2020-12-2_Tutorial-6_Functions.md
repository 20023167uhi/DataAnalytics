Tutorial 6 Functions
================
Tom Blackwood
02/12/2020

## Exercise 1

### Part 1

Write a function that subtracts one vector from another

``` r
vec_sub <- function(vec_1, vec_2){
  return(vec_1 - vec_2)
}

vec_1 <- c(0,1,2)
vec_2 <- c(6,5,4)

print(vec_sub(vec_1, vec_2))
```

    ## [1] -6 -4 -2

### Part 2

Form a word in a function using vectors

``` r
make_word <- function(str_vec, is_word = FALSE){
  if (is_word){
    return(str_c(str_vec, collapse = ""))  
  } else {
    return(str_c(str_vec, collapse = " "))  
  }
  
}

some_chars <- c("H", "e", "l", "l", "o")
make_word(some_chars)
```

    ## [1] "H e l l o"

``` r
some_strings <- c("Hello", "World!", "I", "live", "another", "day!")
make_word(some_strings)
```

    ## [1] "Hello World! I live another day!"

### Part 3

Take the code above and add a logic boolean to tell the function if it’s
a word or a sentence.

## Exercise 2

Rewrite the code from exercise 1 to include error checking

``` r
make_word <- function(str_vec, is_word = FALSE){
  str_clean <- c()
  for(char in c(1:length(str_vec))){
    if (is.numeric(str_vec[char])){
      str_clean[char] <- FALSE
      
    } else if (is.character(str_vec[char])){
      str_clean[char] <- TRUE
      
    } else {
      str_clean[char] <- FALSE
    }
  }
  
  if (FALSE %in% str_clean){
    warning("Not a string vector") # In practice, this should be a stop
    
  }else{
    if (is_word){
      if(nchar(str_vec[1]) == 1){
        return(str_c(str_vec, collapse = ""))
        
      } else {
        warning("First character is a word and not a letter.") # In practice, this should be a stop
      }
      
    } else {
      if(nchar(str_vec[1]) > 1){
        return(str_c(str_vec, collapse = " "))
        
      } else {
        warning(str_c(c("First element of the vector is ", str_vec[1], ", could be a word and not a sentence."), collapse=""))
        return(str_c(str_vec, collapse = " "))
      }
    }
  }
}

some_chars <- c("H", "e", "l", "l", "o")
make_word(some_chars, is_word=TRUE)
```

    ## [1] "Hello"

``` r
make_word(some_chars)
```

    ## Warning in make_word(some_chars): First element of the vector is H, could be a
    ## word and not a sentence.

    ## [1] "H e l l o"

``` r
some_strings <- c("Hello", "World!", "I", "live", "another", "day!")
make_word(some_strings)
```

    ## [1] "Hello World! I live another day!"

``` r
make_word(some_strings, is_word=TRUE)
```

    ## Warning in make_word(some_strings, is_word = TRUE): First character is a word
    ## and not a letter.

``` r
some_nums <- c(1, 2, 5)
some_stuff <- c(5, "A", TRUE)
some_more <- c(some_chars, some_strings)

make_word(some_nums)
```

    ## Warning in make_word(some_nums): Not a string vector

``` r
make_word(some_stuff)
```

    ## Warning in make_word(some_stuff): First element of the vector is 5, could be a
    ## word and not a sentence.

    ## [1] "5 A TRUE"

``` r
make_word(some_more)
```

    ## Warning in make_word(some_more): First element of the vector is H, could be a
    ## word and not a sentence.

    ## [1] "H e l l o Hello World! I live another day!"

``` r
make_word(some_more, is_word=TRUE)
```

    ## [1] "HelloHelloWorld!Iliveanotherday!"

So, largely it works apart from if you use 2 lists and if you have a
list with mixed data.

## Exercise 3 - Sourcefiles

### Part 1

The cleaning functions from Tutorial 4 are put into a function. The
functions are appended with `_local` to distinguish them from functions
being written into scripts later in the exercise.

``` r
nairn <- read_tsv("../../data/nairn_raw.tsv")
```

    ## Warning: Missing column names filled in: 'X8' [8]

    ## 
    ## -- Column specification --------------------------------------------------------
    ## cols(
    ##   yyyy = col_double(),
    ##   mm = col_double(),
    ##   `tmax (degC)` = col_character(),
    ##   `tmin (degC)` = col_character(),
    ##   `af (days)` = col_character(),
    ##   `rain (mm)` = col_character(),
    ##   `sun (hours)` = col_character(),
    ##   X8 = col_character()
    ## )

``` r
head(nairn)
```

    ## # A tibble: 6 x 8
    ##    yyyy    mm `tmax (degC)` `tmin (degC)` `af (days)` `rain (mm)` `sun (hours)`
    ##   <dbl> <dbl> <chr>         <chr>         <chr>       <chr>       <chr>        
    ## 1  1931     1 5             0.6           11          78.4        43.4         
    ## 2  1931     2 6.7           0.7           7           48.9        63.6         
    ## 3  1931     3 6.2           -1.5          19          37.6        145.4        
    ## 4  1931     4 10.4          3.1           3           44.6        110.1        
    ## 5  1931     5 13.2          6.1           1           63.7        167.4        
    ## 6  1931     6 15.4          8             0           87.8        150.3        
    ## # ... with 1 more variable: X8 <chr>

``` r
clean_data_local <- function(df){
  df[df == "---"] <- "NA"
  df[] <- lapply(df, gsub, pattern = '\\*', replacement = '')
  df[] <- sapply(df[], as.numeric)
  return (df)
}

nairn = clean_data_local(nairn)
```

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

``` r
nairn %>%
  group_by(`tmax (degC)`) %>%
  count()
```

    ## # A tibble: 179 x 2
    ## # Groups:   tmax (degC) [179]
    ##    `tmax (degC)`     n
    ##            <dbl> <int>
    ##  1           2.2     1
    ##  2           2.4     1
    ##  3           2.7     1
    ##  4           3       2
    ##  5           3.1     2
    ##  6           3.2     1
    ##  7           3.3     2
    ##  8           3.4     3
    ##  9           3.5     1
    ## 10           3.6     1
    ## # ... with 169 more rows

### Part 2

create a function to read in a file path, clean the data, and returns a
cleaned dataset.

``` r
get_data_local <- function(fp){
  df <- read_tsv(fp)
  df <- clean_data_local(df) # from above
  return (df)
}

nairn2 <- get_data_local("../../data/nairn_raw.tsv") 
```

    ## Warning: Missing column names filled in: 'X8' [8]

    ## 
    ## -- Column specification --------------------------------------------------------
    ## cols(
    ##   yyyy = col_double(),
    ##   mm = col_double(),
    ##   `tmax (degC)` = col_character(),
    ##   `tmin (degC)` = col_character(),
    ##   `af (days)` = col_character(),
    ##   `rain (mm)` = col_character(),
    ##   `sun (hours)` = col_character(),
    ##   X8 = col_character()
    ## )

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

``` r
nairn2 %>%
  group_by(`tmax (degC)`) %>%
  count()
```

    ## # A tibble: 179 x 2
    ## # Groups:   tmax (degC) [179]
    ##    `tmax (degC)`     n
    ##            <dbl> <int>
    ##  1           2.2     1
    ##  2           2.4     1
    ##  3           2.7     1
    ##  4           3       2
    ##  5           3.1     2
    ##  6           3.2     1
    ##  7           3.3     2
    ##  8           3.4     3
    ##  9           3.5     1
    ## 10           3.6     1
    ## # ... with 169 more rows

### Part 3

Putting the scripts into an external file marked `my_scripts.R`.

Since my markdown file is in `Tutorials/Tutorial 6`, I have to go up two
levels to get to the main folder where `/R/` is to get into
`/R/Tutorial 6/my_scripts.R`.

``` r
# load packages
source("../../R/Tutorial 6/my_scripts.R")

nairn3 <- get_data("../../data/nairn_raw.tsv") 
```

    ## Warning: Missing column names filled in: 'X8' [8]

    ## 
    ## -- Column specification --------------------------------------------------------
    ## cols(
    ##   yyyy = col_double(),
    ##   mm = col_double(),
    ##   `tmax (degC)` = col_character(),
    ##   `tmin (degC)` = col_character(),
    ##   `af (days)` = col_character(),
    ##   `rain (mm)` = col_character(),
    ##   `sun (hours)` = col_character(),
    ##   X8 = col_character()
    ## )

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

``` r
nairn3 %>%
  group_by(`tmax (degC)`) %>%
  count()
```

    ## # A tibble: 179 x 2
    ## # Groups:   tmax (degC) [179]
    ##    `tmax (degC)`     n
    ##            <dbl> <int>
    ##  1           2.2     1
    ##  2           2.4     1
    ##  3           2.7     1
    ##  4           3       2
    ##  5           3.1     2
    ##  6           3.2     1
    ##  7           3.3     2
    ##  8           3.4     3
    ##  9           3.5     1
    ## 10           3.6     1
    ## # ... with 169 more rows

### Part 4

Now the script is going to be used on the `dunstaffnage_raw.tsv` data.

``` r
# load packages
source("../../R/Tutorial 6/my_scripts.R")

dunstaffnage <- get_data("../../data/dunstaffnage_raw.tsv") 
```

    ## Warning: Missing column names filled in: 'X8' [8]

    ## 
    ## -- Column specification --------------------------------------------------------
    ## cols(
    ##   yyyy = col_double(),
    ##   mm = col_double(),
    ##   `tmax (degC)` = col_character(),
    ##   `tmin (degC)` = col_character(),
    ##   `af (days)` = col_character(),
    ##   `rain (mm)` = col_character(),
    ##   `sun (hours)` = col_character(),
    ##   X8 = col_character()
    ## )

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion
    
    ## Warning in lapply(X = X, FUN = FUN, ...): NAs introduced by coercion

``` r
dunstaffnage %>%
  group_by(`tmax (degC)`) %>%
  count()
```

    ## # A tibble: 150 x 2
    ## # Groups:   tmax (degC) [150]
    ##    `tmax (degC)`     n
    ##            <dbl> <int>
    ##  1           4.2     2
    ##  2           4.3     1
    ##  3           4.4     1
    ##  4           4.6     1
    ##  5           4.9     1
    ##  6           5       1
    ##  7           5.3     4
    ##  8           5.5     1
    ##  9           5.6     1
    ## 10           5.7     2
    ## # ... with 140 more rows

``` r
head(dunstaffnage)
```

    ## # A tibble: 6 x 8
    ##    yyyy    mm `tmax (degC)` `tmin (degC)` `af (days)` `rain (mm)` `sun (hours)`
    ##   <dbl> <dbl>         <dbl>         <dbl>       <dbl>       <dbl>         <dbl>
    ## 1  1971     6            NA            NA          NA        71.4            NA
    ## 2  1971     7            NA            NA          NA        50.1            NA
    ## 3  1971     8            NA            NA          NA        83              NA
    ## 4  1971     9            NA            NA          NA        75.3            NA
    ## 5  1971    10            NA            NA          NA       271.             NA
    ## 6  1971    11            NA            NA          NA       133.             NA
    ## # ... with 1 more variable: X8 <dbl>

``` r
summary(dunstaffnage)
```

    ##       yyyy            mm         tmax (degC)     tmin (degC)    
    ##  Min.   :1971   Min.   : 1.00   Min.   : 4.20   Min.   :-2.100  
    ##  1st Qu.:1983   1st Qu.: 3.75   1st Qu.: 8.65   1st Qu.: 3.300  
    ##  Median :1995   Median : 6.50   Median :12.30   Median : 5.900  
    ##  Mean   :1995   Mean   : 6.50   Mean   :12.37   Mean   : 6.265  
    ##  3rd Qu.:2008   3rd Qu.: 9.25   3rd Qu.:16.10   3rd Qu.: 9.500  
    ##  Max.   :2020   Max.   :12.00   Max.   :21.20   Max.   :12.800  
    ##                                 NA's   :21      NA's   :20      
    ##    af (days)        rain (mm)       sun (hours)           X8     
    ##  Min.   : 0.000   Min.   :  3.80   Min.   :  9.60   Min.   : NA  
    ##  1st Qu.: 0.000   1st Qu.: 81.25   1st Qu.: 50.50   1st Qu.: NA  
    ##  Median : 0.000   Median :124.20   Median : 87.75   Median : NA  
    ##  Mean   : 2.392   Mean   :139.99   Mean   :100.80   Mean   :NaN  
    ##  3rd Qu.: 3.000   3rd Qu.:187.70   3rd Qu.:140.35   3rd Qu.: NA  
    ##  Max.   :22.000   Max.   :417.80   Max.   :270.90   Max.   : NA  
    ##  NA's   :19       NA's   :17       NA's   :364      NA's   :588
