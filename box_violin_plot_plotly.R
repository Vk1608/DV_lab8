library(shiny)
library(plotly)

data(iris)

ui <- fluidPage(
  titlePanel("Box Plot for different Species in a single plot"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("plottype", "Select plot type - box plot/violin plot",
                   choices = list("Box Plot", "Violin Plot"),
                   selected = "Violin Plot"),
      selectInput("yaxis", "Y-axis", names(iris)[-5]),
      checkboxGroupInput("species", "Filter out Species",
                         choices = unique(as.character(iris$Species)),
                         selected = c(unique(as.character(iris$Species))))
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server <- function(input, output) {
  
  # Create a reactive subset of iris dataset based on selected species
  iris_subset <- reactive({
    iris %>%
      filter(Species %in% input$species)
  })
  # iris_subset <- iris[iris$Species %in% input$species, ]
  
  output$plot <- renderPlotly({
    plot_ly(iris_subset(), x = ~Species, y = ~get(input$yaxis),
            type = ifelse(input$plottype == 'Box Plot', 'box', 'violin'),
            name = input$plottype) %>%
      layout(title = ifelse(input$plottype == 'Box Plot', "Box Plot for Multiple Species",
                            "Violin Plot for Multiple Species"),
             xaxis = list(title = "Species"),
             yaxis = list(title = ~input$yaxis))
  })
  
}

shinyApp(ui = ui, server = server)