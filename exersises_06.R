# The 1st version =============================================================
# This is the first straightforward approach to solve Exercise No 3 from
# 6.2.4 Exercises of Hadley Wickham book Mastering Shiny
# I'm very inexperienced in R and completely new in Shiny. So, I can not solve
# this exercise by myself. I could not to write server function for the UI I found
# in Mastering Shiny Solutions https://mastering-shiny-solutions.netlify.app/layout-themes-html#layout-themes-html
# So, I left minimal design of UI from the Mastering Shiny Solutions (2 plots x 2 controls)
# and put it into ChatGPT. This is the first minimal version:

# Libraries
library("shiny")
library("ggplot2")

dataset <- diamonds # dataset

ui <- fluidPage(
  title = "Diamonds Explorer",
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
           selectInput('x1', 'X', names(dataset)),
           selectInput('y1', 'Y', names(dataset))
    ),
    column(6,
           selectInput('x2', 'X', names(dataset)),
           selectInput('y2', 'Y', names(dataset))
    )
  )
)

server <- function(input, output) {
  
  # Render the first plot
  output$plot1 <- renderPlot({
    plot(dataset[[input$x1]], dataset[[input$y1]], 
         xlab = input$x1, ylab = input$y1, pch = 20, col = 'blue')
  })
  
  # Render the second plot
  output$plot2 <- renderPlot({
    plot(dataset[[input$x2]], dataset[[input$y2]], 
         xlab = input$x2, ylab = input$y2, pch = 20, col = 'red')
  })
}

shinyApp(ui = ui, server = server)

# The 2nd version =============================================================
# This is the second (also straightforward) approach.
# From the previous code you can see that the variable "carat" is the first
# selection.Obviously this is because it is the first variable in the dataset.
# I decided to make some other default options while still maintaining
# functionality of the user's choice. This was also created by ChatGPT after
# several of my suggestions. If you find this code useful, let me know.

dataset <- diamonds

ui <- fluidPage(
  title = "Diamonds Explorer",
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
