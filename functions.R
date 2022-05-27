clean_point_values_function <- function(my_dataframe){
  my_dataframe %>% 
    mutate(Event = gsub(" ", "_", Event)) 
}

clean_raw_data <- function(raw_scores){
  names(raw_scores)<-gsub(".", "_", names(raw_scores), fixed=TRUE)
  raw_scores[is.na(raw_scores)] <- 0
  return(raw_scores)
}

get_player_scores <- function(raw_scores, point_values){
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

get_all_player_totals <- function(scoreboard){
  scoreboard$Player <- gsub(" ",".", scoreboard$Player)
  all_player_totals <- aggregate(total ~ Player, data=scoreboard, sum)
  return(all_player_totals)
}


get_scoreboard <- function(scores){
  scoreboard <- select(scores,c("Player","Week","total"))
  return(scoreboard)
}
players <- c("Jojo","Emily","Cheese","Lauren","Amanda","Olivia",
            "Sarah", "Becca")

#get_player_trends <- (scoreboard) {
##  player_trends <- scoreboard
#  for p in players{
#    for i in (2:5){
#      player_trends <- filter(player_trends, Week == i)
#    }
#  }
    
#}
