library(qdap)
library(stringr)
library(tidyverse)
library(tidytext)


clean_string <- function(x) {
  x <- bracketX(x)
  x <- strip(x)
  x <- clean(x)
  x <- replace_abbreviation(x)
  x <- replace_contraction(x)
  x <- replace_ordinal(x)
  x <- replace_symbol(x)
  x <- tolower(x)
  return(x)
}

clean_input <- function(textstring) {
  textstring <- clean_string(textstring)
  
  length <- str_count(textstring, "\\S+")
  
  if (length <= 3) {
    textstring
  } else {
    word(textstring, start = (length(textstring) - 4),-1)
  }
} 

predict_next <- function(input) {
  length <- str_count(input, "\\S+")
  
  if (length == 1) {
    predicted <- filter(bigrams, word1 == input) %>%
      top_n(1) %>%
      select(word2) %>%
      slice(1) %>%
      as.character()
    
    if (predicted != "character(0)") {
      return(predicted)
    } else {
      as.character("Error Not Found")
    }
  } else if (length == 2) {
    predicted <- filter(trigrams, phrase == input) %>%
      top_n(1) %>%
      select(word3) %>%
      slice(1) %>%
      as.character()
    
    if (predicted != "character(0)") {
      return(predicted)
    } else {
      predict_next(word(input, start = (length(input) - 2), -1))
    }
  }
  else if (length == 3) {
    predicted <- filter(quadgrams, phrase == input) %>%
      top_n(1) %>%
      select(word4) %>%
      slice(1) %>%
      as.character()
    
    if (predicted != "character(0)") {
      return(predicted)
    } else {
      predict_next(word(input, start = (length(input) - 3), -1))
    }
  }
}