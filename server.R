#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(dplyr)
titanic <- data.frame(Titanic)
tit <- titanic[rep(row.names(titanic), titanic$Freq), 1:4]
row.names(tit) <- 1:nrow(tit)

t <- tit %>% group_by(Class, Sex, Age) %>% summarize(survival.prob = mean(as.numeric(Survived)-1))
t$com <- paste(t$Sex, t$Age, "")

library(caret)
cv <- trainControl(method='cv', number=3)
model <- train(Survived~., tit, trainControl=cv, method='lda')

library(RColorBrewer)
red <- brewer.pal(4, "Reds")

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$barplot <- renderPlot({
    barplot(t[t$Class==input$Class,]$survival.prob, names.arg=t[t$Class==input$Class,]$com, col=red, 
            ylab='probability', main='Probability of Survival')
  })
  
  output$prediction <- renderText({
    pred <- predict(model, data.frame('Class' = input$class, 'Sex' = input$Sex, 'Age' = input$Age))
    paste('Will the person survive on the Titanic?', pred)
  })
})
