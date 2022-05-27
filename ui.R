
ui <- dashboardPage(
  dashboardHeader(title = "The Bachelor Season 26 Fantasy Leagues"),
  dashboardSidebar(
    menuItem("Rules and Scoring", tabName = "rules", icon = icon("th")),
    menuItem("Weekly Scores", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Standings", tabName = "standings", icon = icon("th")),
    menuItem("Rosters", tabName = "rosters", icon = icon("th")),
    menuItem("Player Charts", tabName = "scores_by_week", icon = icon("th"))
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        title = "Select your league",
        selectInput(
          inputId = "league",
          label = "Choose your league",
          choices = list("Easterly Bean League","Westerly Beans","The Lost League"),
          selected = NULL,
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL
        ),
        tableOutput("league")
      )
    ),
    fluidRow(
      box(
        title = "UPDATE",
        actionButton(
          inputId = "update_league",
          label = "Update"
        )
      )
    ),
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
              tableOutput("all_player_totals")
            )
          ),
          fluidRow(
            box(
              title = "Player scores by Week",
              selectInput(
                inputId = "player_line",
                label = "Choose a player",
                choices = list("Jojo","Emily","Becca","Olivia","Lauren"),
                selected = NULL,
                multiple = FALSE,
                selectize = TRUE,
                width = NULL,
                size = NULL
              ),
              plotOutput("scoreboard")
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
                      choices = list("Jojo","Emily","Sarah"),
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
              tableOutput("standings")
            )
          )
        ),
        tabItem(tabName='rosters',
          fluidRow(
            box(title = "Rosters",
              tableOutput("rosters")
          )
        )),
        tabItem(tabName='rules',
          fluidRow(
            box(title = "Point Values",
            tableOutput("point_value_table")
            )
        )
    )
  )
)
)