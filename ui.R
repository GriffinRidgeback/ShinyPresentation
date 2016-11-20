library(shiny)

shinyUI(fluidPage(
  titlePanel("Predict Fertility Rates using two different models"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Exploratory Variable for Model 1"),
      
      sliderInput(
        "sliderAgriculture",
        "% of males involved in agriculture as occupation",
        1,
        90,
        step = 0.5,
        value = 45
      ),
      
      br(),
      
      h4("Exploratory Variables for Model 2"),
      
      sliderInput(
        "sliderExamination",
        "% draftees receiving highest mark on army examination",
        3,
        35,
        step = 1,
        value = 16
      ),
      
      sliderInput(
        "sliderEducation",
        "% education beyond primary school for draftees",
        1,
        55,
        step = 1,
        value = 27
      ),
      
      sliderInput(
        "sliderCatholic",
        "% Catholic (as opposed to Protestant)",
        2,
        100,
        step = 0.5,
        value = 48
      ),
      
      sliderInput(
        "sliderInfantMortality",
        "% live births who live less than 1 year",
        10,
        30,
        step = 0.5,
        value = 15
      ),
      
      br(),
      
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
      
      br(),
      
      submitButton("Generate Models")
    ),
    
    mainPanel(tabsetPanel(
      tabPanel(
        "Plot",
        plotOutput("plot1"),
        h3("Predicted Fertility from Model 1:"),
        h4(textOutput("formula1")),
        h5(textOutput("pred1")),
        br(),
        h3("Predicted Fertility from Model 2:"),
        h4(textOutput("formula2")),
        h5(textOutput("pred2"))
      ),
      tabPanel("Help",
               h2("How to use the application"),
               h3("Slider bars"),
               tags$ol(
                 tags$li("The top slider controls the input to the first model."), 
                 tags$li("The next four sliders control the inputs to the second model."), 
                 tags$li("The checkboxes control the display of the regression line."),
                 tags$li("The pushbutton runs the models with the selected paramters.")
               ),
               br(),
               helpText("Once the pushbutton is pressed, the results of running the models (i.e., the predicted"),
               helpText(" Fertility rate) will displayed graphically in the plot and textually below the plot."),
               br(),
               helpText("The various icons described in the lower left-hand legend will"),
               helpText("adjust accordingly based on the inputs and model calculations."),
               br(),
               helpText("The regression lines will remain unchanged.")
               )
      
    ))
  )
))