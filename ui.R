ui <- dashboardPage(
  dashboardHeader(title = "The Bachelor Season 26 Fantasy Leagues"),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        title = "Weekly Scores",
        selectInput(
          inputId = "week",
          label = "Choose a week",
          choices = list(1,2,3),
          selected = NULL,
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        ),
        tableOutput("table")
      )
    ),
    fluidRow(
      box(
        title = "Standings",
        selectInput(
          inputId = "week2",
          label = "Choose a league",
          choices = list("League 1","League 2","League 3"),
          selected = NULL,
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        ),
        tableOutput("table2")
      )
    ),
    fluidRow(
      box(
        title = "Rosters",
        selectInput(
          inputId = "team",
          label = "Choose a league",
          choices = list("Team1","Team2"),
          selected = NULL,
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        ),
        tableOutput("rosters")
      )
    )
  )
)
