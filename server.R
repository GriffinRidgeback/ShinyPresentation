library(shiny)
shinyServer(function(input, output) {
  
  model.1 <- lm(Fertility ~ Agriculture, data = swiss)
  model.2 <- lm(Fertility ~ . -Agriculture, data = swiss)
  
  model1pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    predict(model.1, newdata = data.frame(Agriculture = agricultureInput))
  })
  
  model2pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    examinationInput <- input$sliderExamination
    educationInput <- input$sliderEducation
    catholicInput <- input$sliderCatholic
    infantMortalityInput <- input$sliderInfantMortality
    predict(model.2, newdata = data.frame(
      Agriculture = agricultureInput,
      Examination = examinationInput,
      Education = educationInput,
      Catholic = catholicInput,
      Infant.Mortality = infantMortalityInput
      ))
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
    
    # if(input$showModel2){
    #   model2lines <- predict(model2, newdata = data.frame(carat = mpgInput,
    #                meanCarat = ifelse(mpgInput > mean(diamonds$carat),
    #                                   mpgInput, mean(diamonds$carat))))
    #   lines(1:length(diamonds$carat), model2lines, col = "blue", lwd = 2)
    # }
    
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    
    points(agricultureInput, model1pred(), col = "red", pch = 16, cex = 2)
    
    points(examinationInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})