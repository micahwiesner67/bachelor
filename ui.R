ui <- dashboardPage(
  dashboardHeader(title = "The Bachelor Season 26 Fantasy Leagues"),
  dashboardSidebar(
    menuItem("Weekly Scores", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Standings", tabName = "standings", icon = icon("th")),
    menuItem("Rosters", tabName = "rosters", icon = icon("th")),
    menuItem("Player Charts", tabName = "scores_by_week", icon = icon("th")),
    menuItem("Select Your League", tabName = "choose_league", icon = icon("th"))
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
              plotOutput("scoreboard_chart"),
              tableOutput("scoreboard")
            )
          )
        ),
        tabItem(tabName='scores_by_week',
                fluidRow(
                  box(
                    title = "Scores by week",
                    selectInput(
                      inputId = "player",
                      label = "Choose a player",
                      choices = list("Player 1","Player 2"),
                      selected = NULL,
                      multiple = FALSE,
                      selectize = TRUE,
                      width = NULL,
                      size = NULL
                    ),
                    plotOutput("scores_by_week")
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
              tableOutput("standings")
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
        ),
        tabItem(tabName='choose_league',
          fluidRow(
            box(
              title = "Select your league",
              selectInput(
                inputId = "league",
                label = "Choose your league",
                choices = list("League1","League2"),
                selected = NULL,
                multiple = FALSE,
                selectize = TRUE,
                width = NULL,
                size = NULL
              ),
              tableOutput("league")
            )
          )
        )
    )
  )
)
