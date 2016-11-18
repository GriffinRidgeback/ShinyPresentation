library(shiny)
shinyServer(function(input, output) {
  
  model.1 <- lm(Fertility ~ Agriculture, data = swiss)
  model.2 <- lm(Fertility ~ . -Agriculture, data = swiss)
  
  model1pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    round(predict(model.1, newdata = data.frame(Agriculture = agricultureInput)), 2)
  })
  
  model2pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    examinationInput <- input$sliderExamination
    educationInput <- input$sliderEducation
    catholicInput <- input$sliderCatholic
    infantMortalityInput <- input$sliderInfantMortality
    round(predict(model.2, newdata = data.frame(
          Agriculture = agricultureInput,
          Examination = examinationInput,
          Education = educationInput,
          Catholic = catholicInput,
          Infant.Mortality = infantMortalityInput
      )), 2)
  })
  
  output$plot1 <- renderPlot({
    agricultureInput <- input$sliderAgriculture
    examinationInput <- input$sliderExamination
    educationInput <- input$sliderEducation
    catholicInput <- input$sliderCatholic
    infantMortalityInput <- input$sliderInfantMortality
    
    plot(1:nrow(swiss), 
         swiss$Fertility, 
         xlab = "", 
         ylab = "Fertility Rates", 
         bty = "n", 
         pch = 16, 
         col = "orange",
         xlim = c(0, 100),
         ylim = c(0, 100))

    if(input$showModel1){
      abline(model.1, col = "red", lwd = 2)
    }
    
    if(input$showModel2){
      abline(model.2$coefficients[1:2], col = "blue", lwd = 2)
    }
    
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    
    points(agricultureInput, model1pred(), col = "red", pch = 16, cex = 2)
    
    points(examinationInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$formula1 <- renderText({
    deparse(model.1$call)
  })
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$formula2 <- renderText({
    deparse(model.2$call)
  })
  output$pred2 <- renderText({
    model2pred()
  })
})