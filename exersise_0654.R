# Custom theme version ========================================================
# Exercise 6.5.4. Use bslib::bs_theme_preview() to make the ugliest theme you can
# I want to add new appearance to working app

# LIBRARIES
library("shiny")
library("bslib")
library("ggplot2")

dataset <- diamonds # dataset

## This one with "Theme customizer" ====
# This is new block
custom_theme <- bs_theme(
  version = 5,
  bg = "#FF374B", # the ugliest color
  fg = "#000000",
  primary = "#0199F8",
  secondary = "#FF374B",
  base_font = "Maven Pro"
)

ui <- fluidPage(
  theme = custom_theme, # This is new row
  titlePanel("Diamonds Explorer"),
  fluidRow(
    column(6,
           plotOutput("plot1")
    ),
    column(6,
           plotOutput("plot2")
    )
  ),
  hr(),
  fluidRow(
    column(6,
           selectInput('x1', 'X', names(dataset), selected = "carat"),
           selectInput('y1', 'Y', names(dataset), selected = "price")
    ),
    column(6,
           selectInput('x2', 'X', names(dataset), selected = "clarity"),
           selectInput('y2', 'Y', names(dataset), selected = "price")
    )
  )
)

server <- function(input, output) {
  
  # You'll need to replace this with your actual dataset
  dataset <- diamonds
  
  # Set the initial values based on default parameters
  initial_x1 <- "carat"
  initial_y1 <- "price"
  initial_x2 <- "clarity"
  initial_y2 <- "price"
  
  # Reactive variables based on user inputs
  reactive_x1 <- reactive({
    input$x1
  })
  
  reactive_y1 <- reactive({
    input$y1
  })
  
  reactive_x2 <- reactive({
    input$x2
  })
  
  reactive_y2 <- reactive({
    input$y2
  })
  
  # Render the first plot
  output$plot1 <- renderPlot({
    plot(dataset[[reactive_x1()]], dataset[[reactive_y1()]], 
         xlab = reactive_x1(), ylab = reactive_y1(), pch = 20, col = 'blue')
  })
  
  # Render the second plot
  output$plot2 <- renderPlot({
    plot(dataset[[reactive_x2()]], dataset[[reactive_y2()]], 
         xlab = reactive_x2(), ylab = reactive_y2(), pch = 20, col = 'red')
  })
}

run_with_themer(shinyApp(ui = ui, server = server)) # This is new row


## Exercise 6.5.4. Another version ====
# This version creates new background theme in my_css.css file. You need to
# have this file in the same folder as this code.

ui <- fluidPage(
  includeCSS("my_css.css"), # my_css.css created separately in a text editor
  titlePanel("Diamonds Explorer"),
  fluidRow(
    column(6,
           plotOutput("plot1")
    ),
    column(6,
           plotOutput("plot2")
    )
  ),
  hr(),
  fluidRow(
    column(6,
           selectInput('x1', 'X', names(dataset), selected = "carat"),
           selectInput('y1', 'Y', names(dataset), selected = "price")
    ),
    column(6,
           selectInput('x2', 'X', names(dataset), selected = "clarity"),
           selectInput('y2', 'Y', names(dataset), selected = "price")
    )
  )
)

server <- function(input, output) {
  
  # You'll need to replace this with your actual dataset
  dataset <- diamonds
  
  # Set the initial values based on default parameters
  initial_x1 <- "carat"
  initial_y1 <- "price"
  initial_x2 <- "clarity"
  initial_y2 <- "price"
  
  # Reactive variables based on user inputs
  reactive_x1 <- reactive({
    input$x1
  })
  
  reactive_y1 <- reactive({
    input$y1
  })
  
  reactive_x2 <- reactive({
    input$x2
  })
  
  reactive_y2 <- reactive({
    input$y2
  })
  
  # Render the first plot
  output$plot1 <- renderPlot({
    plot(dataset[[reactive_x1()]], dataset[[reactive_y1()]], 
         xlab = reactive_x1(), ylab = reactive_y1(), pch = 20, col = 'blue')
  })
  
  # Render the second plot
  output$plot2 <- renderPlot({
    plot(dataset[[reactive_x2()]], dataset[[reactive_y2()]], 
         xlab = reactive_x2(), ylab = reactive_y2(), pch = 20, col = 'red')
  })
}

shinyApp(ui = ui, server = server)
