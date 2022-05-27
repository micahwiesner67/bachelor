clean_point_values_function <- function(my_dataframe){
  my_dataframe %>% 
    mutate(Event = gsub(" ", "_", Event)) 
}

clean_raw_data <- function(raw_data){
  names(raw_scores)<-gsub(".", "_", names(raw_scores), fixed=TRUE)
  raw_scores[is.na(raw_scores)] <- 0
  return(raw_scores)
}

get_player_scores <- function(scores, raw_scores, point_values){
  scores <- raw_scores
  for(i in 1:26){
    scores[, point_values$Event[i]] <- point_values$X[i] * raw_scores[, point_values$Event[i]]
  scores$total <- rowSums(scores[,point_values$Event])
  return(scores)
    }
}

get_standings<- function(scoreboard, roster, teams){
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
  return(standings)
}

get_scoreboard <- function(scores){
  scoreboard <- select(scores,c("Player","Week","total"))
  return(scoreboard)
}

