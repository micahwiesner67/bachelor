ui <- dashboardPage(
  dashboardHeader(title = "The Bachelor Season 26 Fantasy Leagues"),
  dashboardSidebar(
    menuItem("Weekly Scores", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Standings", tabName = "standings", icon = icon("th")),
    menuItem("Rosters", tabName = "rosters", icon = icon("th"))
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
      tabItems(
        tabItem(tabName='dashboard',
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
          )
        ),
        tabItem(tabName='standings',
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
          )
        ),
        tabItem(tabName='rosters',
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
    )
)