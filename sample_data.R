library(tidyverse)

# Read in the 3 en_US text files

twitter <- readLines("data/en_US.twitter.txt",
                     encoding = "UTF-8",
                     skipNul = TRUE)

blog <- readLines("data/en_US.blogs.txt",
                  encoding = "UTF-8",
                  skipNul = TRUE)

news <- readLines("data/en_US.news.txt", 
                  encoding = "UTF-8", 
                  skipNul = TRUE)

# Take random sample of 12,000 lines from each

twitterSample <- twitter %>%
  sample(size = 12000, replace = FALSE)

blogSample <- blog %>%
  sample(size = 12000, replace = FALSE)

newsSample <- news %>%
  sample(size = 12000, replace = FALSE)

# Combine the 3 samples into one character vector

finalSample <- c(twitterSample, blogSample, newsSample)

# Cleanup and remove unwanted objects

rm(twitter, blog, news, twitterSample, blogSample, newsSample)

# Write out final sample data set to txt file

writeLines(finalSample, "data/capstonetext.txt")