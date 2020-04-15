library(shiny)
library(tidyverse)
library(ggrepel)

shinyServer(function(input, output) {
    # Load and tidy the data we need
    df <- mtcars
    df$am <- as.factor(df$am)
    # Convert numerical values of transmissions into text
    levels(df$am) <- c("Automatic", "Manual")
    # Create brand and model variables
    df <- mutate(df, brand = sub("(\\w)\\ .*", "\\1", rownames(mtcars)), car = rownames(mtcars))
    df <- mutate(df, model = str_split_fixed(df$car, " ", 2)[,2])
    
    output$carPlot <- renderPlot({
        
        minCyl <- input$cyl1[1]
        maxCyl <- input$cyl1[2]
        minDisp <- input$disp1[1]
        maxDisp <- input$disp1[2]
        minHp <- input$hp1[1]
        maxHp <- input$hp1[2]
        
        df2 <- filter(df,
                      cyl >= minCyl,
                      cyl <= maxCyl,
                      disp >= minDisp,
                      disp <= maxDisp,
                      hp >= minHp,
                      hp <= maxHp,
                      am %in% input$transGroup,
                      brand %in% input$brandGroup)
        
        # Create a warning if users remove essential variables
        validate(need(input$transGroup, "Choose at least one transmission type"))
        validate(need(input$brandGroup, "Choose at least one brand"))
        
        ggplot(data = df2, aes(x = wt, y = mpg, color = brand, alpha = 0.7, shape = am, size = 2)) +
            geom_point() +
            labs(x = "Weight (1000 lbs)",
                 y = "Miles/(US) gallon",
                 shape = "Transmission",
                 color = "Brand") +
            xlim(1, 6) +
            ylim(10, 35) +
            guides(size = FALSE, alpha = FALSE) +
            geom_label_repel(label = df2$model, size = 3, color = "black")
    })

})
