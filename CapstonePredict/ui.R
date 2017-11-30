library(shiny)
library(shinythemes)

source("data/functions.R")

url <-
  "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"

fluidPage(
  theme = shinytheme("darkly"),
  titlePanel("Predict - Coursera Data Science Capstone"),
  br(),
  sidebarLayout(
    sidebarPanel(
      h4(textInput("user_input", label = "Enter text here:", value = "hello")),
      submitButton("Submit"),
      br(),
      h4("Next word predicted:"),
      textOutput("value")
    ),
    mainPanel(tabsetPanel(
      tabPanel(
        "Documentation",
        br(),
        p(
          "This app attempts to predict the next word based on a phrase submitted
          by the end user."
        ),
        p("Only English words are included in this model."),
        p(
          "The app compares the last 3 words of the phrase entered to a dictionary
          of tri-grams. If no match is found, the last two words are then compared
          to a dictionary of bi-grams. The step-back process continues, and if no
          match is found, an error is thrown."
        ),
        p(
          "The dictionary of n-grams was compiled from a random sample of corpora
          containing a collection of tweets, blog writings, and news articles.
          It can be found below."
        ),
        tags$a(href = url, "Download corpora.")
        ),
      tabPanel(
        "Lessons Learned",
        br(),
        p(
          "Natural Language Processing is an extremely interesting (and difficult!)
          topic and I am glad to have gotten the opportunity to design a predictive 
          model for this course."
        ),
        p(
          "Throughout the process of building my model I have learned a few things:"
        ),
        tags$ul(
          tags$li("The larger the n-gram dictionary, the better the model is 
                  at predicting the next word. This also negatively affects the 
                  performance of my model however. Creating a hash table or an indexed 
                  data.table might be the optimal path if I was to continue 
                  to optimize my project."),
          br(),
          tags$li("As a result of shrinking my dictionaries to an acceptable size
                  for matching performance, some rarer words may not be matched."), 
          br(),
          tags$li("I originally built my model using the packages tm and RWeka
                  but recently switched to the tidytext package by Julia Silge 
                  and David Robinson. I found the package was much quicker at unnesting
                  tokens and creating tidy n-gram data frames out of my sample data!")
        )
      )
        ))
    )
    )
