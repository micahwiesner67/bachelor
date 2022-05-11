shinyUI(fluidPage(
  theme = bs_theme(version = 5, bootswatch = "simplex"),
  
  # good options for bootswatch --> 
  # journal, cerulean, lux, "quartz" (colorful), 
  # sandstone, simplex
  # spacelab, united, "vapor" (colorful), yeti
  
  # notes: I like having black buttons on the map
  
  # the following changes the page title in the browser
  tags$head(HTML("<title> Isaacs Title </title>")),
  
  titlePanel(shiny::fluidRow(column(
                               br(),
                               p("Go forth and find the freshest bachelor",
                                 style = "text-align: center; color:black; background-color:lavender; 
                                 padding:5px; border-radius:5px; font-size: 25px"),
                               width = 8)
                             )
             ),
  mainPanel(
    HTML("")
  )
)
)