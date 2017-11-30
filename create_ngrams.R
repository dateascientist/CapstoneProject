library(tidytext)
library(tidyverse)
library(qdap)

source("functions.R")

final_sample <- readLines("data/capstonetext.txt")

final_sample <- as_tibble(final_sample) %>%
  rename(text = value)

final_sample$text <- clean_string(final_sample$text)

bigrams <- final_sample %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>%
  count(bigram, sort = TRUE) %>%
  filter(n >= 3) %>%
  separate(bigram, c("word1", "word2"), sep = " ")

trigrams <- final_sample %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3) %>%
  count(trigram, sort = TRUE) %>%
  filter(n >= 3) %>%
  separate(trigram, c("word1", "word2", "word3"), sep = " ") %>%
  unite("phrase", c("word1", "word2"), sep = " ")

quadgrams <- final_sample %>%
  unnest_tokens(quadgram, text, token = "ngrams", n = 4) %>%
  count(quadgram, sort = TRUE) %>%
  filter(n >= 3) %>%
  separate(quadgram, c("word1", "word2", "word3", "word4"), sep = " ") %>%
  unite("phrase", c("word1", "word2", "word3"), sep = " ")

#save(unigrams, file = "data/uni.Rdata")
#save(bigrams, file = "data/bi.Rdata")
#save(trigrams, file = "data/tri.Rdata")
#save(quadgrams, file = "data/quad.Rdata")


