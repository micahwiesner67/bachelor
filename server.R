server <- function(input, output) {
  raw_scores <- read.csv("Book1.csv")
  point_values <- read.csv("PointValues.csv", stringsAsFactors = FALSE)
  roster <- data.frame(Team1=c("Player.1","Player.2"),
                       Team2=c("Player.4","Player.3"))
  point_values <- clean_point_values_function(point_values)
  names(raw_scores)<-gsub(".", "_", names(raw_scores), fixed=TRUE)
  raw_scores[is.na(raw_scores)] <- 0
  teams <- names(roster)
  scores <- get_player_scores(scores, raw_scores, point_values)
  scoreboard <- get_scoreboard(scores)
  standings <- get_standings(scoreboard, roster, teams)
  
  output$table <- renderTable({
    filter(scoreboard, Week %in% input$week)
  })
  
  output$table2 <- renderTable({
    standings
  })
  
  output$rosters <- renderTable({
    select(roster, input$team)
  })
}
