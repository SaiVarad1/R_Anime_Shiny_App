library(tidyverse)
library(dplyr)
library(tidygraph)
library(shiny)


#anime_df <- read_csv("https://uwmadison.box.com/shared/static/qvx22j224mmxo6zyqdhzt11ugh9xm10l.csv")# share box inactive
anime_df <- read_csv("anime.csv")

anime_df <- anime_df %>%
  
  mutate(episodes = as.numeric(episodes)) %>%
  
  mutate(
    genre=gsub("(^\\w+).*", "\\1", genre)
    
  ) %>%
  na.omit()


bar <- function(anime_df_subset, selected_) {
  anime_df_subset %>%
    filter(genre %in% selected_) %>%
    ggplot(aes(x = genre, y = episodes, fill=type)) +
    geom_bar(stat = "summary", fun = "mean") +
    labs(x = "Genre", y = "Average Number of Episodes", title = "Genre vs Episodes, colored by Type of Media")
}

boxplot <- function(anime_df_subset, selected_) {
  anime_df_subset %>%
    filter(genre %in% selected_) %>%
    ggplot(aes(x = genre, y = ratings, fill = genre)) +
    geom_boxplot() +
    scale_fill_brewer(palette = "Set1") +
    labs(x = "Genre", y = "Rating", title = "Anime Ratings Across Genres") +
    theme_minimal()
}

scatterplot <- function(anime_df_subset, selected_) {
  anime_df_subset %>%
    filter(genre %in% selected_) %>%
    ggplot(aes(x = log(members), y = log(episodes), color = genre)) +
    geom_point() +
    labs(x = "Log Number of Members", y = "Log Number of Episodes", title = "Fan Members vs Episodes, colored by Type of Media")
}

ui <- fluidPage(
  fluidRow(
    column(4, plotOutput("bar")),
    column(4, plotOutput("boxplot")),
    column(4, plotOutput("scatterplot"))
  ),
  fluidRow(
    column(12, selectInput("dropdown", "Select a Genre for all three plots", choices = unique(anime_df$genre), multiple = TRUE))
  ),
  fluidRow(
    column(12, radioButtons("radio", "Select Type of Media for Scatterplot to depict", choices = c("TV", "Movie", "OVA")))
  ),
  dataTableOutput("table")
)

server <- function(input, output) {
  selected <- reactiveVal(rep(1, nrow(anime_df)))
  selected_genre <- reactiveVal(NULL)
  
  
  anime_df_subset <- reactive({
    anime_df %>%
      na.omit() %>%
      mutate(selected = as.integer(genre %in% input$dropdown))
  })
  
  scatterplot_data <- reactive({
    anime_df_subset() %>%
      filter(type == input$radio)
  })
  
  output$bar <- renderPlot(bar(anime_df_subset(),input$dropdown))
  
  output$boxplot <- renderPlot({
    anime_df_subset() %>%
      filter(selected == 1) %>%
      ggplot(aes(x = genre, y = rating, fill = genre)) +
      geom_boxplot() +
      scale_fill_brewer(palette = "Set1") +
      labs(x = "Genre", y = "Rating", title = "Anime Ratings Across Genres")
  })
  
  output$scatterplot <- renderPlot({
    scatterplot(scatterplot_data(), input$dropdown)
  })
  
  output$table <- renderDataTable({
    anime_df_subset() %>%
      filter(selected == 1)
  })
}

shinyApp(ui = ui, server = server)