Tutorial 5 If statments and For-While loops
================
Tom Blackwood
30/11/2020

## Exercise 1

Checking data to find data frames, vectors, and lists

### Part 1.

Checking the length of a vector and if it is 10 then you get a special
message.

``` r
x1 <- rpois(n = rpois(n = 1, lambda = 10), lambda = 10)

if (length(x1) == 10){
  print("***Length of x1 is 10!!!***")
} else {
  print(paste("Length x1 is", length(x1)))
}
```

    ## [1] "Length x1 is 7"

### Part 2.

Checking for `Data Frames` and seeing what happens when a list is used
in a data frame check with else conditions.

Also checking a `List` against a `Data Frame` checker to see if it can
pass.

``` r
x2 <- data.frame(
   emp_id = c (1:5), 
   emp_name = c("Rick","Dan","Michelle","Ryan","Gary"),
   salary = runif(n = 5, min = 500, max = 900), 
   
   start_date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15", "2014-05-11",
      "2015-03-27")),
   stringsAsFactors = FALSE
)

x3 <- list("a" = 2.5, "b" = TRUE, "c" = 1:3)

if (is.data.frame(x2)){
  print("***We got a data frame!!!***")
  print(x2)
}
```

    ## [1] "***We got a data frame!!!***"
    ##   emp_id emp_name   salary start_date
    ## 1      1     Rick 867.3839 2012-01-01
    ## 2      2      Dan 510.5673 2013-09-23
    ## 3      3 Michelle 502.9712 2014-11-15
    ## 4      4     Ryan 756.2815 2014-05-11
    ## 5      5     Gary 749.3101 2015-03-27

``` r
x3 <- list("a" = 2.5, "b" = TRUE, "c" = 1:3)
if (is.data.frame(x3)){
  print("***We got a data frame!!!***")
  print(x3)
} else {
  print("x3 is not a dataframe.")
  print(x3)
}
```

    ## [1] "x3 is not a dataframe."
    ## $a
    ## [1] 2.5
    ## 
    ## $b
    ## [1] TRUE
    ## 
    ## $c
    ## [1] 1 2 3

### Part 3.

Checking if something is a data frame or vector. If vector, find it’s
length or else if it’s a data frame find it’s dimensions (number of
columns and rows).

``` r
x4 <- list(x1, x2, x3)
for (el in x4){
  if (is.data.frame(el)){
    print("We got a data frame!!!")
    print(dim(el))
  } else if (is.list(el)){
    print("The element is a list with elements and lengths:")
    print(lengths(el, use.names = TRUE))
  } else if (is.vector(el)){
    print(paste("The element is a vector with length", length(el)))
  } 
}
```

    ## [1] "The element is a vector with length 7"
    ## [1] "We got a data frame!!!"
    ## [1] 5 4
    ## [1] "The element is a list with elements and lengths:"
    ## a b c 
    ## 1 1 3

In order to include a list in the checking, a sequence of events has to
be noted. First check if we have a data frame, the list and vector
checks won’t return true. Then check if the element is a list element,
the vector element will not pass, but the data frame would. Thirdly,
check if the vector element is true, the list element will pass this.

## Exercise 2 Brother - For-loops

Writing for-loops and posting terrible memes. (Terrible memes were
optional.)

<img src="https://images-cdn.9gag.com/photo/aoNnZ5n_700b.jpg"
     alt="The Loops, Brother"
     style="float: center;" />

### Part 1

Creating a vector and running the for-loop to make a cumulative sum

``` r
x5 <- 0
print(x1)
```

    ## [1] 12 16  7  7 12  7 15

``` r
for (el in x1){
  x5 <- x5 + el
  print(x5)
}
```

    ## [1] 12
    ## [1] 28
    ## [1] 35
    ## [1] 42
    ## [1] 54
    ## [1] 61
    ## [1] 76

### Part 2

For loops that add vector elements

``` r
vec_len <- rpois(n = 1, lambda = 10)

vec_1 <- rpois(n = vec_len, lambda = 10)
vec_2 <- rpois(n = vec_len, lambda = 10)
vec_3 <- c()

print(paste(c("Vector 1 is:", vec_1), collapse=" "))
```

    ## [1] "Vector 1 is: 8 11 10 8 15 8 13 11 9 13 5 13 9 9 9 17 16"

``` r
print(paste(c("Vector 2 is:", vec_2), collapse=" "))
```

    ## [1] "Vector 2 is: 18 9 12 11 7 11 13 3 12 14 9 11 9 7 6 11 8"

``` r
print(paste(c("Vector 3 is:", vec_3), collapse=" "))
```

    ## [1] "Vector 3 is:"

``` r
for (i in c(1:vec_len)){
  vec_3[i] <- vec_1[i] + vec_2[i]
}
print(paste(c("Vector 3 is now:", vec_3), collapse=" "))
```

    ## [1] "Vector 3 is now: 26 20 22 19 22 19 26 14 21 27 14 24 18 16 15 28 24"

### Challenge

Create a while loop that has the first 100 prime number elements.

``` r
num_of_primes <- 100

is.prime <- function(num) {
   if (num == 2) {
      TRUE
   } else if (any(num %% 2:(num-1) == 0)) {
      FALSE
   } else { 
      TRUE
   }
}
prime_num = c()
n <- 0

while (length(prime_num) < num_of_primes){
  if (is.prime(n)){
    prime_num[length(prime_num) + 1] <- n
  }
  n <- n + 1
}
print(cat("The first", length(prime_num), "prime numbers are:\n", paste(c(prime_num), collapse=" "), "\n"))
```

    ## The first 100 prime numbers are:
    ##  2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523 541 
    ## NULL

## Exercise 3 Optional/Extensions Exercises

These are some optional exercises on for-loops and while-loops

### Part 1

While-loops and For-loops are timed using `system.time()` for adding two
random vectors of length 10^3, 10^4, 10^5, and 10^6.

``` r
while_add <- function(vec_len, vec_1, vec_2){
  vec_3 <- c()
  n <- 1
  while (n < vec_len) {
    vec_3[n] <- vec_1[n] + vec_2[n]
    n <- n + 1
  }
  return(TRUE)
}

for_add <- function(vec_len, vec_1, vec_2){
  for (i in c(1:vec_len)){
    vec_3[i] <- vec_1[i] + vec_2[i]
  }
  return(TRUE)
}

#-----------------------------------

vector_n <- c(10^3, 10^4, 10^5, 10^6)

vec_1 <- rpois(n = vector_n[length(vector_n)], lambda = 10)
vec_2 <- rpois(n = vector_n[length(vector_n)], lambda = 10)


for (vec_len in c(1:length(vector_n))){
  
  print(paste("The time to calculate ",vector_n[vec_len]," elements in the While-Loop is:", sep = " "))
  print(system.time(a <- while_add(vector_n[vec_len], vec_1, vec_2)))
  
  print(paste("The time to calculate ",vector_n[vec_len]," elements in the For-Loop is:", sep = " "))
  print(system.time(a <- for_add(vector_n[vec_len], vec_1, vec_2)))
  
  print("")
  
}
```

    ## [1] "The time to calculate  1000  elements in the While-Loop is:"
    ##    user  system elapsed 
    ##    0.02    0.00    0.02 
    ## [1] "The time to calculate  1000  elements in the For-Loop is:"
    ##    user  system elapsed 
    ##       0       0       0 
    ## [1] ""
    ## [1] "The time to calculate  10000  elements in the While-Loop is:"
    ##    user  system elapsed 
    ##       0       0       0 
    ## [1] "The time to calculate  10000  elements in the For-Loop is:"
    ##    user  system elapsed 
    ##       0       0       0 
    ## [1] ""
    ## [1] "The time to calculate  1e+05  elements in the While-Loop is:"
    ##    user  system elapsed 
    ##    0.04    0.00    0.05 
    ## [1] "The time to calculate  1e+05  elements in the For-Loop is:"
    ##    user  system elapsed 
    ##    0.02    0.00    0.03 
    ## [1] ""
    ## [1] "The time to calculate  1e+06  elements in the While-Loop is:"
    ##    user  system elapsed 
    ##    0.39    0.04    0.44 
    ## [1] "The time to calculate  1e+06  elements in the For-Loop is:"
    ##    user  system elapsed 
    ##    0.28    0.02    0.31 
    ## [1] ""

### Part 2 + 3 Finding Divinity in Fibonacci

This part of the exercise is to make a Fibonacci sequence by adding what
`is` to what `was` and then calculated the `divinity ratio` by dividing
the `is` component by the `was`.

This function works by adding what `is` to what `was` to make `now`. And
then what `is` is now what `was` because `now` is what `is`.

It’s a terrible existential crisis.

<img src="http://www.quickmeme.com/img/fa/fa87a4aa3343c8063a073e8f11be03b29c8f12e7e1973f5b4f6808bf4e0760fd.jpg"
     alt="I was with it"
     style="float: center;" />

And to get the Divine Ratio, what `is` must be divided by what `was`,
which generally should pan out to about 1.618.

``` r
num_of_loops <- 13

was <- 0
is <- 1
now <- c()
divine <- c()

for (i in c(1:num_of_loops)){

  if (was == 0){ 
    divine[i] = "NA"
  } else {
    divine[i] <- is/was
  }
  
  now[i] <- is + was
  
  was <- is
  is <- now[i]
}

print(cat("The first", num_of_loops, "elements of the Fibonacci sequence, starting with 0 and 1, are:\n", paste(now, collapse=" "), "\n"))
```

    ## The first 13 elements of the Fibonacci sequence, starting with 0 and 1, are:
    ##  1 2 3 5 8 13 21 34 55 89 144 233 377 
    ## NULL

``` r
print(cat("The 'divine ratio' of the first", num_of_loops, "elements, starting with 0 and 1, are:\n", paste(divine, collapse=" "), "\n"))
```

    ## The 'divine ratio' of the first 13 elements, starting with 0 and 1, are:
    ##  NA 1 2 1.5 1.66666666666667 1.6 1.625 1.61538461538462 1.61904761904762 1.61764705882353 1.61818181818182 1.61797752808989 1.61805555555556 
    ## NULL

### Part 4 - Clocking in

Shows time every second for the length of `timeout`

``` r
timeout <- 10
sleeptime <- 1

for (t in c(1:timeout)){
  print(format(Sys.time(), "%a %b %d %X %Y"))
  Sys.sleep(sleeptime)
}
```

    ## [1] "Thu Dec 24 12:08:47 2020"
    ## [1] "Thu Dec 24 12:08:48 2020"
    ## [1] "Thu Dec 24 12:08:49 2020"
    ## [1] "Thu Dec 24 12:08:50 2020"
    ## [1] "Thu Dec 24 12:08:51 2020"
    ## [1] "Thu Dec 24 12:08:52 2020"
    ## [1] "Thu Dec 24 12:08:53 2020"
    ## [1] "Thu Dec 24 12:08:54 2020"
    ## [1] "Thu Dec 24 12:08:55 2020"
    ## [1] "Thu Dec 24 12:08:56 2020"
