<<<<<<< HEAD
Tutorial 2 - Manipulating data with dplyr
================
Tom Blackwood
10/11/2020

## Exercise 1 - Using the `select` function

Using the `select` function pulls columns that are selected from a data
frame. Using **storms** as the source, the *numerical values* can be
grabbed the.

    ## # A tibble: 10,010 x 10
    ##     year month   day  hour   lat  long  wind pressure ts_diameter hu_diameter
    ##    <dbl> <dbl> <int> <dbl> <dbl> <dbl> <int>    <int>       <dbl>       <dbl>
    ##  1  1975     6    27     0  27.5 -79      25     1013          NA          NA
    ##  2  1975     6    27     6  28.5 -79      25     1013          NA          NA
    ##  3  1975     6    27    12  29.5 -79      25     1013          NA          NA
    ##  4  1975     6    27    18  30.5 -79      25     1013          NA          NA
    ##  5  1975     6    28     0  31.5 -78.8    25     1012          NA          NA
    ##  6  1975     6    28     6  32.4 -78.7    25     1012          NA          NA
    ##  7  1975     6    28    12  33.3 -78      25     1011          NA          NA
    ##  8  1975     6    28    18  34   -77      30     1006          NA          NA
    ##  9  1975     6    29     0  34.4 -75.8    35     1004          NA          NA
    ## 10  1975     6    29     6  34   -74.8    40     1002          NA          NA
    ## # ... with 10,000 more rows

or the *character values* can be used.

    ## # A tibble: 10,010 x 2
    ##    name  status             
    ##    <chr> <chr>              
    ##  1 Amy   tropical depression
    ##  2 Amy   tropical depression
    ##  3 Amy   tropical depression
    ##  4 Amy   tropical depression
    ##  5 Amy   tropical depression
    ##  6 Amy   tropical depression
    ##  7 Amy   tropical depression
    ##  8 Amy   tropical depression
    ##  9 Amy   tropical storm     
    ## 10 Amy   tropical storm     
    ## # ... with 10,000 more rows

The columns can even be selected based on looking for certain
conditions, specifically here columns with *diameter* in their name

    ## # A tibble: 10,010 x 2
    ##    ts_diameter hu_diameter
    ##          <dbl>       <dbl>
    ##  1          NA          NA
    ##  2          NA          NA
    ##  3          NA          NA
    ##  4          NA          NA
    ##  5          NA          NA
    ##  6          NA          NA
    ##  7          NA          NA
    ##  8          NA          NA
    ##  9          NA          NA
    ## 10          NA          NA
    ## # ... with 10,000 more rows

Using the `%like%` function from the `data.table` library, partial
string matches within the columns can be selected. Here, **tropical** is
used to select both *tropical depression* and *tropical storm*

    ## # A tibble: 6,919 x 13
    ##    name   year month   day  hour   lat  long status category  wind pressure
    ##    <chr> <dbl> <dbl> <int> <dbl> <dbl> <dbl> <chr>  <ord>    <int>    <int>
    ##  1 Amy    1975     6    27     0  27.5 -79   tropi~ -1          25     1013
    ##  2 Amy    1975     6    27     6  28.5 -79   tropi~ -1          25     1013
    ##  3 Amy    1975     6    27    12  29.5 -79   tropi~ -1          25     1013
    ##  4 Amy    1975     6    27    18  30.5 -79   tropi~ -1          25     1013
    ##  5 Amy    1975     6    28     0  31.5 -78.8 tropi~ -1          25     1012
    ##  6 Amy    1975     6    28     6  32.4 -78.7 tropi~ -1          25     1012
    ##  7 Amy    1975     6    28    12  33.3 -78   tropi~ -1          25     1011
    ##  8 Amy    1975     6    28    18  34   -77   tropi~ -1          30     1006
    ##  9 Amy    1975     6    29     0  34.4 -75.8 tropi~ 0           35     1004
    ## 10 Amy    1975     6    29     6  34   -74.8 tropi~ 0           40     1002
    ## # ... with 6,909 more rows, and 2 more variables: ts_diameter <dbl>,
    ## #   hu_diameter <dbl>

## Exercise 2 - `mutate() across() everything()`. “*Everything, sir?*”, “**EVERYTHING\!\!\!**”

Continuing with the **storms** data, the `mutate()` function combined
with `across()` and `everything()` change the values of the data frame
to make everything the same type. In the example below, the **storms**
data is mutated using the `mutate()` function. Where the changes are set
to be done across the whole data frame using `across()`, and using every
data type is selected by `everything()`. The data type the selected to
mutate into is *character* or `chr`.

    ## # A tibble: 10,010 x 13
    ##    name  year  month day   hour  lat   long  status category wind  pressure
    ##    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  <chr>    <chr> <chr>   
    ##  1 Amy   1975  6     27    0     27.5  -79   tropi~ -1       25    1013    
    ##  2 Amy   1975  6     27    6     28.5  -79   tropi~ -1       25    1013    
    ##  3 Amy   1975  6     27    12    29.5  -79   tropi~ -1       25    1013    
    ##  4 Amy   1975  6     27    18    30.5  -79   tropi~ -1       25    1013    
    ##  5 Amy   1975  6     28    0     31.5  -78.8 tropi~ -1       25    1012    
    ##  6 Amy   1975  6     28    6     32.4  -78.7 tropi~ -1       25    1012    
    ##  7 Amy   1975  6     28    12    33.3  -78   tropi~ -1       25    1011    
    ##  8 Amy   1975  6     28    18    34    -77   tropi~ -1       30    1006    
    ##  9 Amy   1975  6     29    0     34.4  -75.8 tropi~ 0        35    1004    
    ## 10 Amy   1975  6     29    6     34    -74.8 tropi~ 0        40    1002    
    ## # ... with 10,000 more rows, and 2 more variables: ts_diameter <chr>,
    ## #   hu_diameter <chr>

The `where()` function can be used to convert data of a specific type,
where you might want to keep *boolean* variables or *coordinates*,
`ord`, or convert integers to floats. Here the *numerals* are being
converted to *characters*.

    ## # A tibble: 10,010 x 13
    ##    name  year  month day   hour  lat   long  status category wind  pressure
    ##    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  <ord>    <chr> <chr>   
    ##  1 Amy   1975  6     27    0     27.5  -79   tropi~ -1       25    1013    
    ##  2 Amy   1975  6     27    6     28.5  -79   tropi~ -1       25    1013    
    ##  3 Amy   1975  6     27    12    29.5  -79   tropi~ -1       25    1013    
    ##  4 Amy   1975  6     27    18    30.5  -79   tropi~ -1       25    1013    
    ##  5 Amy   1975  6     28    0     31.5  -78.8 tropi~ -1       25    1012    
    ##  6 Amy   1975  6     28    6     32.4  -78.7 tropi~ -1       25    1012    
    ##  7 Amy   1975  6     28    12    33.3  -78   tropi~ -1       25    1011    
    ##  8 Amy   1975  6     28    18    34    -77   tropi~ -1       30    1006    
    ##  9 Amy   1975  6     29    0     34.4  -75.8 tropi~ 0        35    1004    
    ## 10 Amy   1975  6     29    6     34    -74.8 tropi~ 0        40    1002    
    ## # ... with 10,000 more rows, and 2 more variables: ts_diameter <chr>,
    ## #   hu_diameter <chr>

## Exercise 3 - `arrange()` and `count()`

The `count()` function is used on **storms** to count the number of
elements within *year* and weighted by *name*. This returns a table
ordered by year. The `arrange()` function, with `desc()`, can be used to
change the order of the storms to give the longest active storm by how
frequently a storm name occurs in the the list by the count function.

To counter this, the `unique()` function will also be used to remove
duplicate counts where *name* and *year* are both the same. (Though
there may still be an error where a storm continues over the new year
and it may be counted twice.). Using `unique()` removes the requirement
to weight the storm by name in `count()`.

    ## # A tibble: 426 x 3
    ##     vars wt_vars      n
    ##    <dbl> <chr>    <int>
    ##  1  1975 Amy          1
    ##  2  1975 Caroline     1
    ##  3  1975 Doris        1
    ##  4  1976 Belle        1
    ##  5  1976 Gloria       1
    ##  6  1977 Anita        1
    ##  7  1977 Clara        1
    ##  8  1977 Evelyn       1
    ##  9  1978 Amelia       1
    ## 10  1978 Bess         1
    ## # ... with 416 more rows

## Exercise 4 plotting ~~schemes~~ results

The `select()` and `filter()` functions will be used to select data to
plot with `ggplot()` from the **storms** dataset. For this the *Tomas*
dataset will be selected from table (because it is a most excellent name
for a storm\!). The values for *name*, *wind speed*, *pressure*, and
*status* are selected. *Category* was requested which gives a numeral
value of the of the *status* of the storm but using *status* is a bit
more informative for the layman.

![](2020-11-11_Tutorial-2_Manipulating-data-with-dplyr_files/figure-gfm/storm_plt-1.png)<!-- -->

Plotting more than one storm and using colour to define the different
storms.

![](2020-11-11_Tutorial-2_Manipulating-data-with-dplyr_files/figure-gfm/storm_plt2-1.png)<!-- -->

## Bonus Round

Plotting the path of Tomas and Clara using GPS coordinates. Tomas is in
Green and Clara in Red. (I haven’t yet worked out the `addLegend`
function yet…)

<!--html_preserve-->

<div id="htmlwidget-2dbcb2e0e9369679d508" class="leaflet html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-2dbcb2e0e9369679d508">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addPolylines","args":[[[[{"lng":[-53.7,-55.3,-56.8,-57.8,-58.9,-59.5,-60.1,-61,-61.2,-61.7,-62.4,-63.3,-64.4,-65.8,-67.1,-68.2,-69.2,-70.3,-71.4,-72.5,-73.4,-73.9,-74.3,-74.7,-75.1,-75.5,-75.9,-76.2,-76.2,-75.7,-75.2,-74.7,-74,-73.1,-71.8,-71.6,-70.9,-70.3,-69.8,-69.6,-69.5,-69.3],"lat":[9,9.8,10.8,11.9,12.7,13,13.1,13.3,13.4,13.5,13.8,14,14.2,14.1,13.9,13.6,13.5,13.5,13.5,13.5,13.6,13.8,14,14.3,14.7,15.1,15.5,15.9,16.4,17,17.7,18.7,19.7,20.4,21.4,21.7,22.6,23.8,24.9,25.4,25.7,26]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"green","weight":5,"opacity":0.5,"fill":false,"fillColor":"green","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addPolylines","args":[[[[{"lng":[-80,-79,-78.2,-77.6,-77,-76.4,-75.8,-75,-74.3,-73,-71.7,-69.7,-67.7,-66.2,-64.6,-63.5,-62.8,-62.8,-63.2,-63.6,-63.8,-63.7,-63.2,-62.5],"lat":[32.8,33.2,33.6,33.8,34,34.2,34.4,34.6,34.7,34.9,35.1,35.3,35.5,35.6,35.5,34.8,34,33.4,32.8,32.8,33,33.5,34.2,34.8]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"red","weight":5,"opacity":0.5,"fill":false,"fillColor":"red","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["green","red"],"labels":["Tomas","Clara"],"na_color":null,"na_label":"NA","opacity":0.5,"position":"bottomright","type":"unknown","title":"Storm names","extra":null,"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[9,35.6],"lng":[-80,-53.7]}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->
=======
Tutorial 2 - Manipulating data with dplyr
================
Tom Blackwood
10/11/2020

## Exercise 1 - Using the `select` function

Using the `select` function pulls columns that are selected from a data
frame. Using **storms** as the source, the *numerical values* can be
grabbed the.

    ## # A tibble: 10,010 x 10
    ##     year month   day  hour   lat  long  wind pressure ts_diameter hu_diameter
    ##    <dbl> <dbl> <int> <dbl> <dbl> <dbl> <int>    <int>       <dbl>       <dbl>
    ##  1  1975     6    27     0  27.5 -79      25     1013          NA          NA
    ##  2  1975     6    27     6  28.5 -79      25     1013          NA          NA
    ##  3  1975     6    27    12  29.5 -79      25     1013          NA          NA
    ##  4  1975     6    27    18  30.5 -79      25     1013          NA          NA
    ##  5  1975     6    28     0  31.5 -78.8    25     1012          NA          NA
    ##  6  1975     6    28     6  32.4 -78.7    25     1012          NA          NA
    ##  7  1975     6    28    12  33.3 -78      25     1011          NA          NA
    ##  8  1975     6    28    18  34   -77      30     1006          NA          NA
    ##  9  1975     6    29     0  34.4 -75.8    35     1004          NA          NA
    ## 10  1975     6    29     6  34   -74.8    40     1002          NA          NA
    ## # ... with 10,000 more rows

or the *character values* can be used.

    ## # A tibble: 10,010 x 2
    ##    name  status             
    ##    <chr> <chr>              
    ##  1 Amy   tropical depression
    ##  2 Amy   tropical depression
    ##  3 Amy   tropical depression
    ##  4 Amy   tropical depression
    ##  5 Amy   tropical depression
    ##  6 Amy   tropical depression
    ##  7 Amy   tropical depression
    ##  8 Amy   tropical depression
    ##  9 Amy   tropical storm     
    ## 10 Amy   tropical storm     
    ## # ... with 10,000 more rows

The columns can even be selected based on looking for certain
conditions, specifically here columns with *diameter* in their name

    ## # A tibble: 10,010 x 2
    ##    ts_diameter hu_diameter
    ##          <dbl>       <dbl>
    ##  1          NA          NA
    ##  2          NA          NA
    ##  3          NA          NA
    ##  4          NA          NA
    ##  5          NA          NA
    ##  6          NA          NA
    ##  7          NA          NA
    ##  8          NA          NA
    ##  9          NA          NA
    ## 10          NA          NA
    ## # ... with 10,000 more rows

Using the `%like%` function from the `data.table` library, partial
string matches within the columns can be selected. Here, **tropical** is
used to select both *tropical depression* and *tropical storm*

    ## # A tibble: 6,919 x 13
    ##    name   year month   day  hour   lat  long status category  wind pressure
    ##    <chr> <dbl> <dbl> <int> <dbl> <dbl> <dbl> <chr>  <ord>    <int>    <int>
    ##  1 Amy    1975     6    27     0  27.5 -79   tropi~ -1          25     1013
    ##  2 Amy    1975     6    27     6  28.5 -79   tropi~ -1          25     1013
    ##  3 Amy    1975     6    27    12  29.5 -79   tropi~ -1          25     1013
    ##  4 Amy    1975     6    27    18  30.5 -79   tropi~ -1          25     1013
    ##  5 Amy    1975     6    28     0  31.5 -78.8 tropi~ -1          25     1012
    ##  6 Amy    1975     6    28     6  32.4 -78.7 tropi~ -1          25     1012
    ##  7 Amy    1975     6    28    12  33.3 -78   tropi~ -1          25     1011
    ##  8 Amy    1975     6    28    18  34   -77   tropi~ -1          30     1006
    ##  9 Amy    1975     6    29     0  34.4 -75.8 tropi~ 0           35     1004
    ## 10 Amy    1975     6    29     6  34   -74.8 tropi~ 0           40     1002
    ## # ... with 6,909 more rows, and 2 more variables: ts_diameter <dbl>,
    ## #   hu_diameter <dbl>

## Exercise 2 - `mutate() across() everything()`. “*Everything, sir?*”, “**EVERYTHING\!\!\!**”

Continuing with the **storms** data, the `mutate()` function combined
with `across()` and `everything()` change the values of the data frame
to make everything the same type. In the example below, the **storms**
data is mutated using the `mutate()` function. Where the changes are set
to be done across the whole data frame using `across()`, and using every
data type is selected by `everything()`. The data type the selected to
mutate into is *character* or `chr`.

    ## # A tibble: 10,010 x 13
    ##    name  year  month day   hour  lat   long  status category wind  pressure
    ##    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  <chr>    <chr> <chr>   
    ##  1 Amy   1975  6     27    0     27.5  -79   tropi~ -1       25    1013    
    ##  2 Amy   1975  6     27    6     28.5  -79   tropi~ -1       25    1013    
    ##  3 Amy   1975  6     27    12    29.5  -79   tropi~ -1       25    1013    
    ##  4 Amy   1975  6     27    18    30.5  -79   tropi~ -1       25    1013    
    ##  5 Amy   1975  6     28    0     31.5  -78.8 tropi~ -1       25    1012    
    ##  6 Amy   1975  6     28    6     32.4  -78.7 tropi~ -1       25    1012    
    ##  7 Amy   1975  6     28    12    33.3  -78   tropi~ -1       25    1011    
    ##  8 Amy   1975  6     28    18    34    -77   tropi~ -1       30    1006    
    ##  9 Amy   1975  6     29    0     34.4  -75.8 tropi~ 0        35    1004    
    ## 10 Amy   1975  6     29    6     34    -74.8 tropi~ 0        40    1002    
    ## # ... with 10,000 more rows, and 2 more variables: ts_diameter <chr>,
    ## #   hu_diameter <chr>

The `where()` function can be used to convert data of a specific type,
where you might want to keep *boolean* variables or *coordinates*,
`ord`, or convert integers to floats. Here the *numerals* are being
converted to *characters*.

    ## # A tibble: 10,010 x 13
    ##    name  year  month day   hour  lat   long  status category wind  pressure
    ##    <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>  <ord>    <chr> <chr>   
    ##  1 Amy   1975  6     27    0     27.5  -79   tropi~ -1       25    1013    
    ##  2 Amy   1975  6     27    6     28.5  -79   tropi~ -1       25    1013    
    ##  3 Amy   1975  6     27    12    29.5  -79   tropi~ -1       25    1013    
    ##  4 Amy   1975  6     27    18    30.5  -79   tropi~ -1       25    1013    
    ##  5 Amy   1975  6     28    0     31.5  -78.8 tropi~ -1       25    1012    
    ##  6 Amy   1975  6     28    6     32.4  -78.7 tropi~ -1       25    1012    
    ##  7 Amy   1975  6     28    12    33.3  -78   tropi~ -1       25    1011    
    ##  8 Amy   1975  6     28    18    34    -77   tropi~ -1       30    1006    
    ##  9 Amy   1975  6     29    0     34.4  -75.8 tropi~ 0        35    1004    
    ## 10 Amy   1975  6     29    6     34    -74.8 tropi~ 0        40    1002    
    ## # ... with 10,000 more rows, and 2 more variables: ts_diameter <chr>,
    ## #   hu_diameter <chr>

## Exercise 3 - `arrange()` and `count()`

The `count()` function is used on **storms** to count the number of
elements within *year* and weighted by *name*. This returns a table
ordered by year. The `arrange()` function, with `desc()`, can be used to
change the order of the storms to give the longest active storm by how
frequently a storm name occurs in the the list by the count function.

To counter this, the `unique()` function will also be used to remove
duplicate counts where *name* and *year* are both the same. (Though
there may still be an error where a storm continues over the new year
and it may be counted twice.). Using `unique()` removes the requirement
to weight the storm by name in `count()`.

    ## # A tibble: 426 x 3
    ##     vars wt_vars      n
    ##    <dbl> <chr>    <int>
    ##  1  1975 Amy          1
    ##  2  1975 Caroline     1
    ##  3  1975 Doris        1
    ##  4  1976 Belle        1
    ##  5  1976 Gloria       1
    ##  6  1977 Anita        1
    ##  7  1977 Clara        1
    ##  8  1977 Evelyn       1
    ##  9  1978 Amelia       1
    ## 10  1978 Bess         1
    ## # ... with 416 more rows

## Exercise 4 plotting ~~schemes~~ results

The `select()` and `filter()` functions will be used to select data to
plot with `ggplot()` from the **storms** dataset. For this the *Tomas*
dataset will be selected from table (because it is a most excellent name
for a storm\!). The values for *name*, *wind speed*, *pressure*, and
*status* are selected. *Category* was requested which gives a numeral
value of the of the *status* of the storm but using *status* is a bit
more informative for the layman.

![](2020-11-11_Tutorial-2_Manipulating-data-with-dplyr_files/figure-gfm/storm_plt-1.png)<!-- -->

Plotting more than one storm and using colour to define the different
storms.

![](2020-11-11_Tutorial-2_Manipulating-data-with-dplyr_files/figure-gfm/storm_plt2-1.png)<!-- -->

## Bonus Round

Plotting the path of Tomas and Clara using GPS coordinates. Tomas is in
Green and Clara in Red. (I haven’t yet worked out the `addLegend`
function yet…)

<!--html_preserve-->

<div id="htmlwidget-2dbcb2e0e9369679d508" class="leaflet html-widget" style="width:672px;height:480px;">

</div>

<script type="application/json" data-for="htmlwidget-2dbcb2e0e9369679d508">{"x":{"options":{"crs":{"crsClass":"L.CRS.EPSG3857","code":null,"proj4def":null,"projectedBounds":null,"options":{}}},"calls":[{"method":"addTiles","args":["//{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",null,null,{"minZoom":0,"maxZoom":18,"tileSize":256,"subdomains":"abc","errorTileUrl":"","tms":false,"noWrap":false,"zoomOffset":0,"zoomReverse":false,"opacity":1,"zIndex":1,"detectRetina":false,"attribution":"&copy; <a href=\"http://openstreetmap.org\">OpenStreetMap<\/a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA<\/a>"}]},{"method":"addPolylines","args":[[[[{"lng":[-53.7,-55.3,-56.8,-57.8,-58.9,-59.5,-60.1,-61,-61.2,-61.7,-62.4,-63.3,-64.4,-65.8,-67.1,-68.2,-69.2,-70.3,-71.4,-72.5,-73.4,-73.9,-74.3,-74.7,-75.1,-75.5,-75.9,-76.2,-76.2,-75.7,-75.2,-74.7,-74,-73.1,-71.8,-71.6,-70.9,-70.3,-69.8,-69.6,-69.5,-69.3],"lat":[9,9.8,10.8,11.9,12.7,13,13.1,13.3,13.4,13.5,13.8,14,14.2,14.1,13.9,13.6,13.5,13.5,13.5,13.5,13.6,13.8,14,14.3,14.7,15.1,15.5,15.9,16.4,17,17.7,18.7,19.7,20.4,21.4,21.7,22.6,23.8,24.9,25.4,25.7,26]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"green","weight":5,"opacity":0.5,"fill":false,"fillColor":"green","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addPolylines","args":[[[[{"lng":[-80,-79,-78.2,-77.6,-77,-76.4,-75.8,-75,-74.3,-73,-71.7,-69.7,-67.7,-66.2,-64.6,-63.5,-62.8,-62.8,-63.2,-63.6,-63.8,-63.7,-63.2,-62.5],"lat":[32.8,33.2,33.6,33.8,34,34.2,34.4,34.6,34.7,34.9,35.1,35.3,35.5,35.6,35.5,34.8,34,33.4,32.8,32.8,33,33.5,34.2,34.8]}]]],null,null,{"interactive":true,"className":"","stroke":true,"color":"red","weight":5,"opacity":0.5,"fill":false,"fillColor":"red","fillOpacity":0.2,"smoothFactor":1,"noClip":false},null,null,null,{"interactive":false,"permanent":false,"direction":"auto","opacity":1,"offset":[0,0],"textsize":"10px","textOnly":false,"className":"","sticky":true},null]},{"method":"addLegend","args":[{"colors":["green","red"],"labels":["Tomas","Clara"],"na_color":null,"na_label":"NA","opacity":0.5,"position":"bottomright","type":"unknown","title":"Storm names","extra":null,"layerId":null,"className":"info legend","group":null}]}],"limits":{"lat":[9,35.6],"lng":[-80,-53.7]}},"evals":[],"jsHooks":[]}</script>

<!--/html_preserve-->
>>>>>>> 3013c44af8585c29197643405665e4f26f348d8c
