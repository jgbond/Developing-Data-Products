library(shiny)

shinyUI(fluidPage(
    
    # Make horizontal lines more aesthetically pleasing
    tags$head(
        tags$style(HTML("hr {border-top: 1px solid #C0C0C0;}"))
    ),

    # Application title
    titlePanel("Motor Trend Car Road Tests from 1974"),
    hr(),

    # Sidebar with a slider input for variables
    sidebarLayout(
        sidebarPanel(
            h3("Car Variables"),
            p("Adjust these variables to configure your car options"),
            hr(),
            sliderInput("cyl1",
                        "Number of cylinders:",
                        min = 4,
                        max = 8,
                        value = c(4,8),
                        step = 2),
            hr(),
            sliderInput("disp1",
                        "Displacement:",
                        min = 70,
                        max = 480,
                        value = c(70,480),
                        step = 10),
            hr(),
            sliderInput("hp1",
                        "Horsepower:",
                        min = 50,
                        max = 350,
                        value = c(50,350),
                        step = 50),
            hr(),
            checkboxGroupInput("transGroup",
                               label = h4("Transmission Type"),
                               choices = unique(df$am),
                               selected = unique(df$am)),
            p("You must select at least one transmission type"),
            hr(),
            checkboxGroupInput("brandGroup",
                               label = h4("Brand"),
                               choices = unique(df$brand),
                               selected = unique(df$brand)),
            p("You must select at least one brand")
        ),

        # Show the plot
        mainPanel(
            p("Car models that meet your specification will appear below"),
            hr(),
            h3("Cars by Weight and MPG"),
            plotOutput("carPlot")
        )
    )
))
