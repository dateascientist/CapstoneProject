Coursera - Data Science Capstone
========================================================
author: Devan Sperlie
date: Nov 16th, 2017
autosize: true
font-import: http://fonts.googleapis.com/css?family=Roboto
font-family: 'Roboto'

App Introduction & Pre-Processing
========================================================
  
The goal of my Shiny application is to predict the next word from an input of words
submitted by the end user.  
  
To build the data set for this model, I sampled 12,000 lines of text each from a
corpora of tweets, blog writings, and news articles for a total of 36,000 lines 
of total text. The corpora can be found
[here.](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)  
  
The corpora of text then had to be cleaned by striping white spaces, converting 
to lower case, replacing abbreviations, replacing symbols, etc in order to properly
build a clean dictionary of n-grams (consecutive sequences of words).

![quadgrams](images/quad.png)
![trigrams](images/tri.png)
![bigrams](images/bi.png)

I used the package *tidytext* by Julia Silge and David Robinson for the tidying
and creation of my n-gram frequency dictionaries. Other packages used include
*qdap*, *stringr*, and one of my favorite packages of all time, *tidyverse*.

Model & Prediction
========================================================

- The text input from the user is first cleaned (remove whitespace, convert
to lowercase, etc).
- The app then calculates how many words are in the string and passes a **maximum**
of three words to the predict function.
- The app compares these last 3 words of the phrase entered to a dictionary
of tri-grams. If a match is found the next word (word4) is returned. If no match
is found, the last two words are then compared to a dictionary of bi-grams. The 
step-back process continues, and if no match is found, an error is shown.
- If only two words are entered, the process starts with comparing bi-grams, and
if only one is entered, comparing unigrams.

Application & Performance
========================================================
The application itself is extremely straight forward. You simply type in your 
phrase and click Submit to see the predicted word!

![application](images/app.png)

A key performance indicator of my model is how long it takes to return a 
predicted word. I built a benchmarking function that randomly samples 100 phrases
to measure performance of prediction. I then reduced the number of n-grams to 
include to optimize performance while still maintaining prediction accuracy. As
a result, I reduced the time by almost 90%!


```
$Filtered
   min    max   mean 
0.0100 0.0500 0.0268 

$Full
   min    max   mean 
0.1900 0.5000 0.2229 
```


Lessons Learned
========================================================

* Natural Language Processing is an extremely interesting (and difficult!) topic
and I am glad to have gotten the opportunity to design a predictive model for 
this course. I learned a lot but am no means an expert yet!
* The larger the n-gram dictionary, the better the model is at predicting the 
next word. This also negatively affects the performance of my model however. 
Creating a hash table or an indexed data.table might be the optimal path if I 
was to continue to optimize my project further.
* As a result of shrinking my dictionaries to an acceptable size for matching 
performance, some rare words may not be matched.
* I originally built my model using the packages tm and RWeka but recently 
switched to the tidytext package by Julia Silge and David Robinson. I found the 
package was much quicker at unnesting tokens and creating tidy n-gram data frames
out of my sample data!  
  
All code for my project can be found at:
https://github.com/ilikefishes/CapstoneProject

