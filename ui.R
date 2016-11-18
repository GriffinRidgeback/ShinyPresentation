library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Predict Fertility Rates using two different models"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      sliderInput("sliderAgriculture", "% of males involved in agriculture as occupation", 1, 90, step = 0.5, value = 45),
      
      sliderInput("sliderExamination", "% draftees receiving highest mark on army examination", 3, 35, step = 1, value = 16),
      
      sliderInput("sliderEducation", "% education beyond primary school for draftees", 1, 55, step = 1, value = 27),
      
      sliderInput("sliderCatholic", "% Catholic (as opposed to Protestant)", 2, 100, step = 0.5, value = 48),
      
      sliderInput("sliderInfantMortality", "% live births who live less than 1 year", 10, 30, step = 0.5, value = 15),
      
      checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
      
      checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE)
    ),
    
    mainPanel(
      
      plotOutput("plot1"),
      
      h3("Predicted Fertility from Model 1:"),
      h4(textOutput("formula1")),
      h5(textOutput("pred1")),
      
      h3("Predicted Fertility from Model 2:"),
      h4(textOutput("formula2")),
      h5(textOutput("pred2"))
    )
  )
))