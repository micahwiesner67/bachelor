server <- function(input, output) {
  players <- c("Player.1","Player.2","Player.3","Player.4")
  data <- read.csv("Book1.csv")
  points <- read.csv("PointValues.csv", stringsAsFactors = FALSE)
  roster <- data.frame(Team1=c("Player.1","Player.2"),
                       Team2=c("Player.4","Player.3"))
  teams <- names(roster)
  points$Event<-gsub(" ", "_", points$Event)
  names(data)<-gsub(".", "_", names(data), fixed=TRUE)
  data[is.na(data)] <- 0
  scores <- data
  for(i in 1:26){
    scores[, points$Event[i]] <- points$X[i] * data[, points$Event[i]]
  }
  scores$total <- rowSums(scores[,points$Event])
  scoreboard <- select(scores,c("Player","Week","total"))
  output$table <- renderTable({
    filter(scoreboard, Week %in% input$week)
  })
  scoreboard$Player <- gsub(" ",".", scoreboard$Player)
  player_total <- aggregate(total ~ Player, data=scoreboard, sum)
  standings <- roster
  for (team in teams){
    sum = 0
    for (row in 1:nrow(roster)) {
      player <- roster[row, team]
      score  <- filter(player_total, Player == player)
      score <- score$total
      sum = sum + score
      standings[1,team] = sum
      standings <- standings[1,]
    }
  }
  output$table2 <- renderTable({
    standings
  })
  output$rosters <- renderTable({
    select(roster, input$team)
  })
}
