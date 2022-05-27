server <- function(input, output) {
  a <- data.frame(Team1 = c('Player.3','Player.4'),
                  Team2 = c('Player.4','Player.1'))
  b <- data.frame(Team1 = c('Player.1','Player.2'),
                  Team2 = c('Player.4','Player.3'))
  all_rosters <- list("League1" = a, "League2" = b)
  
  raw_scores <- read.csv("Book1.csv")
  point_values <- read.csv("PointValues.csv", stringsAsFactors = FALSE)
  point_values <- clean_point_values_function(point_values)
  raw_scores <- clean_raw_data(raw_data)
  #names(raw_scores)<-gsub(".", "_", names(raw_scores), fixed=TRUE)
  #raw_scores[is.na(raw_scores)] <- 0
  
  scores <- get_player_scores(scores, raw_scores, point_values)
  scoreboard <- get_scoreboard(scores)
  
  output$scoreboard <- renderTable({
    filter(scoreboard, Week %in% input$week)
  })
  
  output$scoreboard_chart <- renderPlot({
    data2 <- filter(scoreboard, Week %in% input$week)
    barplot(data2$total,xlab="Players",ylab="Weekly Score")
  })
  
  output$scores_by_week <- renderPlot({
    chart_data <- filter(scoreboard, Player == input$player)
    plot(chart_data$total,type = "o", xlab="Weeks",ylab="Scores")
    #plot(v,type,col,xlab,ylab)
  })
  
  output$standings <- renderTable({
    league_name <- input$league
    roster <- all_rosters[[league_name]]
    teams <- names(roster)
    standings <- get_standings(scoreboard, roster, teams)
    standings
  })
  
  output$rosters <- renderTable({
    league_name <- input$league
    roster <- all_rosters[[league_name]]
    select(roster, input$team)
  })
}
