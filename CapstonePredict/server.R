library(shiny)

shinyServer(function(input, output) {
  output$value <- renderText({ predict_next(clean_input(input$user_input)) })
})