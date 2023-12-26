#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
library(caret)
library(kernlab)
library(tidyverse)
library(imputeTS)
library(e1071)
library(rpart)
library(rpart.plot)

df = read_csv(url("https://intro-datascience.s3.us-east-2.amazonaws.com/HMO_data.csv"))

df$bmi <- na_interpolation(df$bmi,option = 'linear')
df$hypertension <- ifelse(is.na(df$hypertension), ifelse(runif(1,0,1) > 0.5, 1,0), df$hypertension)
#Generate a new column score which takes few parameters that affect the cost and
#current cost into consideration and adds or subtracts same points from a default
#score of 0 as each and every parameter is considered 1 by 1.
#Setting default as 0
df$score <- 0

#Parameters considered based on their importance or statistical significance based on
#tree model run on cost and plots used to see how cost is changing based on differet
#parameters
df$score <- ifelse(df$cost > 5000, df$score - 5, df$score + 5)
df$score <- ifelse(df$smoker == 'yes' , df$score - 4, df$score + 4)
df$score <- ifelse(df$bmi >= 18.5 & df$bmi <= 24.9 , df$score + 3, df$score - 3)
df$score <- ifelse(df$age <= 40 , df$score + 2, df$score - 2)
df$score <- ifelse(df$exercise == 'active' , df$score + 1, df$score - 1)

#Since for a particular parameter same points are added are subtracted and added
#their total will not be 0. Which means based on what is considered a good thing
#and what is considered a bad. If score greater than 0 then it is a good thing
#i.e positive, so not expensive person and visa versa
#1 - not expensive & 0 - expensive
df$expensive <- ifelse(df$score > 0, FALSE,TRUE)

#Convert expensive column to a factor to get a confusion matrix
df$expensive <- as.factor(df$expensive)

#Check if there is any person with score 0
sum(df$score == 0)
#Make a copy of dataframe
df1 <- df

#Get rid of cost and score column
df1 <- select(df1, -c(cost, score))

#Check the structure of data
str(df1)

# generate a list of cases to include in the training data
trainList <- createDataPartition(y=df1$expensive,p=.60,list=FALSE)

#The split is 60% training and 40% test 

#Create a trainSet subset dataframe from df1
trainSet <- df1[trainList,]

#create a testing data set
testSet <- df1[-trainList,]

#MODEL
treeModel <- rpart(expensive ~., data = df1)


our_model <- treeModel
save(our_model, file = "our_model.rda")

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  fileInput("upload", label="HMO input file", accept = c(".csv")),
  #Read the actual (solution) data
  fileInput("upload_Solution", label="HMO solution file", accept = c(".csv")),
  #get a number (how much of the dataframe to show)
  numericInput("n", "Number of Rows", value = 5, min = 1, step = 1),
  #a place to output a table (i.e., a dataframe)
  tableOutput("headForDF"),
  #output the results (for now, just simple text)
  verbatimTextOutput("txt_results", placeholder = TRUE)
)

# Define server logic required to draw a histogram
server <- function(input, output,session) {
  #require an input file, then read a CSV file
  getTestData <- reactive({
    req(input$upload)
    read_csv(input$upload$name)
  })
  #require an the actual values for the prediction (i.e. solution file)
  getSolutionData <- reactive({
    req(input$upload_Solution)
    read_csv(input$upload_Solution$name)
  })
  
  #show the output of the model
  output$txt_results <- renderPrint({
    #load the data
    dataset <- getTestData()
    dataset_solution <- getSolutionData()
    #load and use the model on the new data
    use_model_to_predict(dataset, dataset_solution)
  })
  #show a few lines of the dataframe
  output$headForDF <- renderTable({
    df <- getTestData()
    head(df, input$n)
  })
}
#these libraries are needed, will be used with predict
library(caret); library(kernlab); library(e1071)
#load a model, do prediction and compute the confusion matrix
use_model_to_predict <- function(df, df_solution){
  #load the pre-built model, we named it ‘out_model.rda’)
  load(file="our_model.rda")
  #use the model with new data
  
  
  treePred <- predict(our_model, df, type = 'class')
  df_solution$expensive <- as.factor(df_solution$expensive)
  confusionMatrix(treePred, df_solution$expensive)
  
}

# Run the application 
shinyApp(ui = ui, server = server)
