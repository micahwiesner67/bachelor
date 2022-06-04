ui <- navbarPage(title ="Bachelor Fantasy Leagues",id="navbarID",
                 tags$head(tags$style(HTML("table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {
                                  background-color: #9c4242 !important;
                                  }
                                  "))),
                 tags$style(HTML(".dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_processing,.dataTables_wrapper .dataTables_paginate .paginate_button, .dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
            color: #fcfafa !important;
        }")),

  theme = shinytheme("superhero"),

    tabPanel("Scoring Details",
              fluidRow(box(scoring_description)),
             fluidRow(
              box(title = "Point Values",
              tableOutput("point_value_table")))),                 
    tabPanel("Standings and Rosters",
             fluidRow(box(roster_description)),
             fluidRow(
              box(
                title = "Select your league",
                selectInput(
                   inputId = "league",
                   label = "Choose your league",
                   choices = list("Eastern Conference","Western Conference","The GOR All Stars"),
                   selected = NULL,
                   multiple = FALSE,
                   selectize = TRUE,
                   width = NULL,
                   size = NULL),
                 tableOutput("league"))),
             fluidRow(box(
                 title = "UPDATE",
                 actionButton(
                   inputId = "update_league",
                   label = "Update"
                 ))),
            fluidRow(
                column(3,
                  box(title = "Rosters",
                  DT::dataTableOutput("rosters"))),
                column(3,
                  box(title = "Standings",
                  tableOutput("standings"))),
                column(6,
                  box(title = "Standings Chart",
                  plotOutput("standingsChart")))
              )),
    tabPanel("Weekly Charts",
             fluidRow(box(weekly_scores_description)),
             fluidRow(
              column(7,
                  box(
                  title = "Weekly Scores",
                  selectInput(
                     inputId = "week",
                     label = "Choose a week",
                     choices = list(1,2,3,4,5,6,7),
                     selected = NULL,
                     multiple = FALSE,
                     selectize = TRUE,
                     width = NULL,
                     size = NULL
                   ),
                   plotOutput("scoreboard_chart"))),
                column(5,
                   dataTableOutput("all_player_totals")
                 )
               )),             
    tabPanel("Individual Player Trends",
            fluidRow(box("These are the RULES")),
            fluidRow(
               box(
                 title = "Player Scores by Week",
                 selectInput(
                   inputId = "player",
                   label = "Choose a player",
                   choices = player_list,
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
    tabPanel("Full Season Charts",
             fluidRow(
               box(
                 title = "Season Long Performance",
                 selectInput(
                   inputId = "chart_type",
                   label = "Choose a chart type to display",
                   choices = c("Season Total","Individual Weeks"),
                   selected = NULL,
                   multiple = FALSE,
                   selectize = TRUE,
                   width = NULL,
                   size = NULL
                 ),
                 plotOutput("scoreboard")
             ))),
    tabPanel("Full Scoreboard",
             fluidRow(
               box(
                 #title = "full scoreboard table",
                 dataTableOutput("DT_scoreboard")
               ))))
    