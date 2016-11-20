library(shiny)

shinyServer(function(input, output) {
  
  # generate the models
  model.1 <- lm(Fertility ~ Agriculture, data = swiss)
  model.2 <- lm(Fertility ~ . -Agriculture, data = swiss)
  
  # create a factor vector for use in coloring plot
  faith <- ifelse(swiss$Catholic > 50.0, "Catholic", "Protestant")
  faiths <- as.factor(faith)

  # use model 1 for predictions based on a single exploratory variable
  model1pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    round(predict(model.1, newdata = data.frame(Agriculture = agricultureInput)), 2)
  })
  
  # use model 2 for predictions based on multiple exploratory variables
  model2pred <- reactive({
    agricultureInput <- input$sliderAgriculture
    examinationInput <- input$sliderExamination
    educationInput <- input$sliderEducation
    catholicInput <- input$sliderCatholic
    infantMortalityInput <- input$sliderInfantMortality
    round(predict(model.2, newdata = data.frame(
          Agriculture = 0,
          Examination = examinationInput,
          Education = educationInput,
          Catholic = catholicInput,
          Infant.Mortality = infantMortalityInput
      )), 2)
  })
  
  # send the plot to the UI
  output$plot1 <- renderPlot({
    
    # read the slider inputs
    agricultureInput <- input$sliderAgriculture
    examinationInput <- input$sliderExamination
    educationInput <- input$sliderEducation
    catholicInput <- input$sliderCatholic
    infantMortalityInput <- input$sliderInfantMortality
    
    # create scatterplot of raw Fertility data
    plot(1:nrow(swiss), 
         swiss$Fertility, 
         xlab = "", 
         ylab = "Fertility Rates", 
         bty = "n", 
         pch = 16, 
         col = faiths,
         xlim = c(0, 100),
         ylim = c(0, 100))

    # regression line for model 1
    if(input$showModel1){
      abline(model.1, col = "blue", lwd = 2)
    }
    
    # regression line for model 2
    if(input$showModel2){
      abline(model.2$coefficients[1:2], col = "orange", lwd = 2)
    }
    
    # model information
    legend(70, 
           100, 
           c("Model 1 Prediction", "Model 2 Prediction"), 
           pch = 16, 
           col = c("blue", "orange"), 
           bty = "n", 
           cex = 1.2)

    # values of model predictions that change based on slider adjustments    
    points(agricultureInput, model1pred(), col = "deepskyblue2", pch = 16, cex = 2)
    points(examinationInput, model2pred(), col = "ivory4", pch = 15, cex = 2)
    points(educationInput, model1pred(), col = "ivory4", pch = 16, cex = 2)
    points(catholicInput, model1pred(), col = "ivory4", pch = 17, cex = 2)
    points(infantMortalityInput, model1pred(), col = "ivory4", pch = 18, cex = 2)
    
    legend(5, 
           40, 
           c("Agriculture", "Examination", "Education", "Religion", "Infant Mortality"), 
           pch = c(16, 15, 16, 17, 18), 
           col = c("deepskyblue2", "ivory4", "ivory4", "ivory4", "ivory4"), 
           bty = "n", 
           cex = 1.2)    
  })
  
  # formula for model 1
  output$formula1 <- renderText({
    deparse(model.1$call)
  })
  
  # output from model 1
  output$pred1 <- renderText({
    model1pred()
  })
  
  # formula for model 2
  output$formula2 <- renderText({
    deparse(model.2$call)
  })
  
  # output from model 2
  output$pred2 <- renderText({
    model2pred()
  })
})