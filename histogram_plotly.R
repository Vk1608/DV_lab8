library(shiny)
library(plotly)

ui <- fluidPage(
  titlePanel("Histogram of Iris Dataset"),
  sidebarLayout(
    sidebarPanel(
      h2("Sepal length"),
      sliderInput("bins_sl",
                  "Bin Size for sepal length:",
                  min = 1,
                  max = 50,
                  value = 30),
      selectInput("color_sl", "Color for sepal length", 
                  choices = c("blue", "red", "green", "orange")),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      
      h2("Sepal width"),
      sliderInput("bins_sw",
                  "Bin Size for sepal width:",
                  min = 1,
                  max = 50,
                  value = 25),
      selectInput("color_sw", "Color for sepal width", 
                  choices = c("red", "blue", "green", "orange")),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      
      h2("Petal Length"),
      sliderInput("bins_pl",
                  "Bin size for petal length:",
                  min = 1,
                  max = 50,
                  value = 20),
      selectInput("color_pl", "Color for petal length", 
                  choices = c("green", "red", "blue", "orange")),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      br(),
      
      h2("Petal Width"),
      sliderInput("bins_pw",
                  "Bin size for petal width:",
                  min = 1,
                  max = 50,
                  value = 15),
      selectInput("color_pw", "Color for petal width", 
                  choices = c("orange", "red", "green", "blue")),
    ),
    mainPanel(
      plotlyOutput("plot_sl"),
      br(),
      plotlyOutput("plot_sw"),
      br(),
      plotlyOutput("plot_pl"),
      br(),
      plotlyOutput("plot_pw")
    )
  )
)

server <- function(input, output) {
  
  output$plot_sl <- renderPlotly({
    plot_ly(iris, x = ~Sepal.Length, type = 'histogram', nbinsx = input$bins_sl, color = I(input$color_sl)) %>%
      layout(title = 'Histogram of Sepal Length', xaxis = list(title = 'Sepal Length'), yaxis = list(title = 'Frequency')) %>%
      layout(dragmode = 'pan', hovermode = 'closest')
  })
  
  output$plot_sw <- renderPlotly({
    plot_ly(iris, x = ~Sepal.Width, type = 'histogram', nbinsx = input$bins_sw, color = I(input$color_sw)) %>%
      layout(title = 'Histogram of Sepal Width', xaxis = list(title = 'Sepal Width'), yaxis = list(title = 'Frequency')) %>%
      layout(dragmode = 'pan', hovermode = 'closest')
  })
  
  output$plot_pl <- renderPlotly({
    plot_ly(iris, x = ~Petal.Length, type = 'histogram', nbinsx = input$bins_pl, color = I(input$color_pl)) %>%
      layout(title = 'Histogram of Petal Length', xaxis = list(title = 'Petal Length'), yaxis = list(title = 'Frequency')) %>%
      layout(dragmode = 'pan', hovermode = 'closest')
  })
  
  output$plot_pw <- renderPlotly({
    plot_ly(iris, x = ~Petal.Width, type = 'histogram', nbinsx = input$bins_pw, color = I(input$color_pw)) %>%
      layout(title = 'Histogram of Petal Width', xaxis = list(title = 'Petal Width'), yaxis = list(title = 'Frequency')) %>%
      layout(dragmode = 'pan', hovermode ='closest')
  })
}

shinyApp(ui, server)