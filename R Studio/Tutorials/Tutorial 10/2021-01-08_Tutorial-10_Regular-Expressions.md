Tutorial 10 - Regular Expressons
================
Tom Blackwood
08/01/2021

## 1\. Loading dataset

The small regular expression dataset was loaded, and the dataframe is as
shown below.

    # A tibble: 4 x 4
      col1  col2  col3    col4
      <chr> <chr> <chr>  <dbl>
    1 qd    I     a        138
    2 e     NBJ   bb    819974
    3 bus   HZZ   a      68489
    4 nzg   Y     a a    14326

Using `str_detect` the `" "` value, entries in column 3 which have a
space can be detected.

    [1] "a a"

### 1.1 Finding entries with at least 2 letters

The `map_df` function was used with `str_count` expressing the values to
be counted that exist from capital A to lower case z, or `[A-z]`. After
that the values were filtered to replace those less than 2 with `NA`.

``` 
     col1  col2  col3  col4
[1,] "qd"  NA    NA    NA  
[2,] NA    "NBJ" "bb"  NA  
[3,] "bus" "HZZ" NA    NA  
[4,] "nzg" NA    "a a" NA  
```

### 1.2 Finding entries that start with more than 2 letters

The `map_df` was again used to make a `str_count` but the filter
conditions were set to `^[A-z]{2}`. The `^` ensures that the first
letters of the element conform to the following requirement of being
between the symbols of `[A-z]`. Lastly the `{2}` tells the function that
it is looking for 2 elements within the specification of `[A-z]`.

``` 
     col1  col2  col3 col4
[1,] "qd"  NA    NA   NA  
[2,] NA    "NBJ" "bb" NA  
[3,] "bus" "HZZ" NA   NA  
[4,] "nzg" NA    NA   NA  
```

### 1.3 Finding elements with 3 numerics.

This is similar to 1.1 above where the characters were counted but this
time the specification is `[0-9]`, or from 0 to 9.

``` 
     col1 col2 col3 col4    
[1,] NA   NA   NA   NA      
[2,] NA   NA   NA   "819974"
[3,] NA   NA   NA   "68489" 
[4,] NA   NA   NA   "14326" 
```

## 2\. Reading in the weather datasets for `regex` to clean.

The function written to clean the weather station datasets was modified
to include the regular ex(pression functions for cleaning.
`str_remove()` was used to remove the special characters `*` and `#`.
`str_detect()` was used to find where the condition of where the
appearance of `[0-9]` was `FALSE` and set it to `NA`. Lastly the dataset
was set to `as.numeric()` before the set was returned.

    # A tibble: 6 x 6
      station `tmax (degC)` `tmin (degC)` `af (days)` `rain (mm)` `sun (hours)`
      <chr>           <dbl>         <dbl>       <dbl>       <dbl>         <dbl>
    1 Braemar           1.7          -5.7          27          NA          34.2
    2 Braemar           6.2          -3.2          15          NA          68.6
    3 Braemar           7.6           0.8           7          NA          80.9
    4 Braemar          NA            NA            NA          NA         105  
    5 Braemar          15.6           4.6           1          NA         183. 
    6 Braemar          16.4           7.2           0          NA         165. 

## Exerecise 3 - Optional: From Jane Austin’s Library Selecting Character, a Year, a year but within the text of the novel.

    [1] "Lines that contain 'Darcy':"

    # A tibble: 415 x 2
       text                                                           book          
       <chr>                                                          <fct>         
     1 "looked the gentleman; but his friend Mr. Darcy soon drew the~ Pride & Preju~
     2 "themselves. What a contrast between him and his friend! Mr. ~ Pride & Preju~
     3 "down for two dances; and during part of that time, Mr. Darcy~ Pride & Preju~
     4 "\"Come, Darcy,\" said he, \"I must have you dance. I hate to~ Pride & Preju~
     5 "Darcy, looking at the eldest Miss Bennet."                    Pride & Preju~
     6 "Mr. Bingley followed his advice. Mr. Darcy walked off; and E~ Pride & Preju~
     7 "exaggeration, the shocking rudeness of Mr. Darcy."            Pride & Preju~
     8 "Between him and Darcy there was a very steady friendship, in~ Pride & Preju~
     9 "great opposition of character. Bingley was endeared to Darcy~ Pride & Preju~
    10 "never appeared dissatisfied. On the strength of Darcy's rega~ Pride & Preju~
    # ... with 405 more rows

    [1] "Publication years:"

``` 
# A tibble: 4 x 2
  text               book               
  <chr>              <fct>              
1 (1811)             Sense & Sensibility
2 (1814)             Mansfield Park     
3 Jane Austen (1803) Northanger Abbey   
4 (1818)             Persuasion         
```

    [1] "Lines that contain a year:"

``` 
# A tibble: 17 x 2
   text                                                         book            
   <chr>                                                        <fct>           
 1 "(1811)"                                                     Sense & Sensibi~
 2 "(1814)"                                                     Mansfield Park  
 3 "Jane Austen (1803)"                                         Northanger Abbey
 4 "THIS little work was finished in the year 1803, and intend~ Northanger Abbey
 5 "Northanger Abbey was written in 1797-98 under a different ~ Northanger Abbey
 6 "manuscript was revised around 1803 and sold to a London pu~ Northanger Abbey
 7 "Crosbie & Co., who sold it back in 1816. The Signet Classi~ Northanger Abbey
 8 "1818--the year following Miss Austen's death. Spelling and~ Northanger Abbey
 9 "(1818)"                                                     Persuasion      
10 "\"Walter Elliot, born March 1, 1760, married, July 15, 178~ Persuasion      
11 "Gloucester, by which lady (who died 1800) he has issue Eli~ Persuasion      
12 "June 1, 1785; Anne, born August 9, 1787; a still-born son,~ Persuasion      
13 "1789; Mary, born November 20, 1791.\""                      Persuasion      
14 "\"Married, December 16, 1810, Charles, son and heir of Cha~ Persuasion      
15 "time (the summer of 1814) wearing black ribbons for his wi~ Persuasion      
16 "the summer of 1806; and having no parent living, found a h~ Persuasion      
17 "and dated from London, as far back as July, 1803:--"        Persuasion      
```
