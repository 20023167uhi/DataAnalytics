################################
# - String Sum function -
#
# String Sum is a function that takes in a list of string character elements 
# and sums them together based on their index value in the alphabet.
#
# Non-letter items will be skipped over and capital letters will be converted
# to lowercase and then added to the sum.
# 
# Note: This code is purposefully slightly over-commented.
# 
################################

chr_to_num <- function(chr_item){
  # This function converts a character to its index within the alphabet.
  
  num_val <- match(chr_item, letters) 
  # Get the index value from the lower case letters list.
  return(num_val)
}

string_sum <- function(chr_vec, skip_cap=FALSE){
  # Function that will sum letters based on their index in the alphabet.
  # Symbols that are not in the alphabet will be skipped over with a warning 
  # added that a "non-letter item" was found.
  
  num_vec <- c() 
  # Create an empty vector that will be filled with letter index values 
  
  for (item in chr_vec){
  # Cycle through each element of the list and perform the actions below 
    
    if (item %in% letters){ 
    # Check if the item from the vector of letters is in the list of 
    # lower case letters 
      
      num_vec <- c(num_vec, chr_to_num(item)) 
      # Append the index value to the list of index values
    
    } else if (item %in% LETTERS){ 
    # Check if the item from the vector of letters is in the list of 
    # upper case letters 
      if (skip_cap){
        # Option to skip capital letters (by default FALSE)
        
        warning(paste(
          "Capital letters are being skipped, [", item, "] was skipped."
        ))
        
      } else {
        # If skip_cap is False, capital letters are added to the sum
        warning(paste(
          "Capital [", item, "] found, converted to [", tolower(item), "] and added to sum."
        )) 
        
        # Send a warning that a upper case letter was found
        item <- tolower(item) 
        # Converts character to lower case
        num_vec <- c(num_vec, chr_to_num(item)) 
        # Append the index value to the list of index values
      }
      
    } else {
    # State warning that a non-letter item was found and say what it was
      warning(paste("Non-letter item [", item, "] found and omitted from sum."))
    }
  }
  return(sum(num_vec)) 
  # Return the sum of the vector index values. 
}

string_sum("a")
# A single character.

string_sum(c("a", "b", "c")) 
# A vector of characters.

string_sum(c("a", "B", "c")) 
# A vector of characters with a capital.

string_sum(c("a", 2, "c")) 
# A vector of characters with a numerical.

string_sum(c("a", "2", "c")) 
# A vector of characters with a string numerical.

string_sum(c("?", "b", "c")) 
# A vector of characters with a symbol.

string_sum(c("g", "$", "T", 5, "f", "G")) 
# A vector of characters with numericals, symbols, and capitals.

string_sum(c("g", "$", "T", 5, "f", "G"), skip_cap = T)
# A vector of characters with numericals, symbols, and capitals and 
# a condition to say "Capitals are illegal and should be skipped".
