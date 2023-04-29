library(plotly)
library(shiny)
library(datasets)

ui <- fluidPage(
  titlePanel("Scatter Plots of Iris Dataset"),
  fluidRow(
    column(width = 3,
           selectInput("xaxis", "X-axis", names(iris)[-5]),
           selectInput("yaxis", "Y-axis", names(iris)[-5]),
           checkboxGroupInput("species", "Filter out Species",
                       choices = unique(as.character(iris$Species)),
                       selected = c(unique(as.character(iris$Species))))),
    column(width = 3,
           sliderInput("setosa_size", "point size for setosa", min = 1, max = 10, value = 4),
           radioButtons("setosa_shape", "point shape for Setosa",
                        choices = list("circle", "square", "diamond"),
                        selected = "circle"),
           radioButtons("setosa_color", "Color for Setosa",
                        choices = list("Red", "Green", "Blue"),
                        selected = "Red")),
    column(width = 3, 
           sliderInput("versicolor_size", "point size for versicolor", min = 1, max = 10, value = 5),
           radioButtons("versicolor_shape", "point shape for Versicolor",
                        choices = list("circle", "square", "diamond"),
                        selected = "square"),
           radioButtons("versicolor_color", "Color for Versicolor",
                        choices = list("Red", "Green", "Blue"),
                        selected = "Green")),
    column(width = 3, 
           sliderInput("virginica_size", "point size for verginica", min = 1, max = 10, value = 6),
           radioButtons("virginica_shape", "point shape for Virginica",
                        choices = list("circle", "square", "diamond"),
                        selected = "diamond"),
           radioButtons("virginica_color", "Color for Virginica",
                        choices = list("Red", "Green", "Blue"),
                        selected = "Blue"))
  ),
  fluidRow(
    column(width = 6,
           plotlyOutput("scatterplot"))
  )
)

server <- function(input, output) {
  
  output$scatterplot <- renderPlotly({
    iris_subset <- iris[iris$Species %in% input$species, ]
    
    plot_ly(iris_subset, x = ~get(input$xaxis), y = ~get(input$yaxis),
            color = ~Species,
            colors = c(input$setosa_color, input$versicolor_color, input$virginica_color),
            type = 'scatter',
            mode = 'markers',
            marker = list(size = ifelse(iris_subset$Species == 'setosa', input$setosa_size,
                                        ifelse(iris_subset$Species == 'versicolor', input$versicolor_size,
                                               input$virginica_size)),
            symbol = ifelse(iris_subset$Species == 'setosa', input$setosa_shape,
                                          ifelse(iris_subset$Species == 'versicolor', input$versicolor_shape,
                                                 input$virginica_shape)))) %>%
      layout(title = "Scatter Plot for Iris dataset",
             xaxis = list(title = input$xaxis),
             yaxis = list(title = input$yaxis))
  })
}

shinyApp(ui, server)