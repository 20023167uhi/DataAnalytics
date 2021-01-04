Tutorial 8
================
Tom Blackwood
02/01/2021

## Historical Weather for Dunstaffnage station

This is an R Markdown document is part of a series of reports made to
plot weather data from various train stations. This document hosts the
data from the data frame below.

``` r
head(params$data)
```

    ## # A tibble: 6 x 10
    ##   station  yyyy    mm `tmax (degC)` `tmin (degC)` `af (days)` `rain (mm)` `sun (hours)`    X8
    ##   <chr>   <dbl> <dbl>         <dbl>         <dbl>       <dbl>       <dbl>         <dbl> <dbl>
    ## 1 Dunsta~  1971     6            NA            NA          NA        71.4            NA    NA
    ## 2 Dunsta~  1971     7            NA            NA          NA        50.1            NA    NA
    ## 3 Dunsta~  1971     8            NA            NA          NA        83              NA    NA
    ## 4 Dunsta~  1971     9            NA            NA          NA        75.3            NA    NA
    ## 5 Dunsta~  1971    10            NA            NA          NA       271.             NA    NA
    ## 6 Dunsta~  1971    11            NA            NA          NA       133.             NA    NA
    ## # ... with 1 more variable: date <date>

And plots like the following for `tmax (degC)` vs `date` can be made:

``` r
ggplot(params$data, aes(x = date, y = `tmax (degC)`, colour = yyyy)) + 
  geom_line()
```

    ## Warning: Removed 7 row(s) containing missing values (geom_path).

![](Report-Dunstaffnage_files/figure-gfm/plot_weather-1.png)<!-- -->
