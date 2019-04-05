#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting the Survival on the Titanic"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      h1('Plot Options'),
      helpText("Change the class for which survival probabilities are shown in the histogram"),
      radioButtons("Class", 'Class', choices=c('1st', '2nd', '3rd', 'Crew')),
      h2('Prediction Options'),
      helpText("Make a prediction for a passenger based on their class, sex and age"),
      radioButtons("class",  'Class', choices=c('1st', '2nd', '3rd', 'Crew')),
      radioButtons("Sex", 'Gender', choices=c('Male', 'Female')),
      radioButtons("Age", 'Age', choices=c('Child', 'Adult'))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       p(paste0("To visualize the survival probabilities for passengers of different classes, change the class in the ",
                "plot options in the sidebar. Make a prediction for whether a passenger would have survived or not, ",
                "specify the passenger's class, sex and age in the prediction options.")),
       plotOutput("barplot"),
       h3(textOutput('prediction'))
    )
  )
))
