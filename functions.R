get_all_rosters <- function(){
  a <- data.frame(Baskin = c('Tammy Ly','Hannah Anne','Sarah Coffin'),
                  Terlip = c('Mykenna Dorn','Victoria Paul','Kelley Flanagan'))
  b <- data.frame(Isaac = c('Victoria Fuller','Hannah Anne','Madison Prewett'),
                  Jessica = c('Mykenna Dorn','Sarah Coffin','Kelley Flanagan'))                                                                           
  c <- data.frame(Clues = c('Madison Prewett','Victoria Fuller','Tammy Ly'),
                  PaceCase = c('Hannah Anne','Kelsey Weir','Natasha Parker'))
all_rosters <- list("Eastern Conference" = a, "Western Conference" = b, "The GOR All Stars" = c)
return(all_rosters)
}

clean_point_values_function <- function(my_dataframe){
  my_dataframe %>% 
    mutate(Event = gsub(" ", "_", Event)) 
}

calculate_rose_number_points <- function(scores){
  temp_df <- data.frame()
  for (i in 1:7){
    weekly_df <- filter(scores, Week == i)
    num_players <- nrow(weekly_df)
    weekly_df$Rose_Ceremony_Order <- num_players - weekly_df$Rose_Ceremony_Order + 1
    weekly_df$Rose_Ceremony_Order <- ifelse(weekly_df$Rose_Ceremony_Order == num_players+1, 0,weekly_df$Rose_Ceremony_Order)
    temp_df <- rbind(temp_df, weekly_df)}
 return(temp_df)
}

get_raw_scores_for_dt <- function(raw_scores){
  raw_scores_for_dt <- raw_scores
  names(raw_scores_for_dt) <- gsub("_", " ", names(raw_scores_for_dt), fixed=TRUE)
  return(raw_scores_for_dt)
  }

clean_raw_data <- function(raw_scores){
  names(raw_scores)<-gsub(".", "_", names(raw_scores), fixed=TRUE)
  raw_scores[is.na(raw_scores)] <- 0
  return(raw_scores)
}

get_player_scores <- function(raw_scores, point_values){
  scores <- raw_scores
  for(i in 1:nrow(point_values)){
    scores[, point_values$Event[i]] <- point_values$Points[i] * raw_scores[, point_values$Event[i]]
    scores$total <- rowSums(scores[,point_values$Event])}
  return(scores)
}

get_standings<- function(scoreboard, roster, teams){
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

scoring_description <- "Welcome to my Fantasy Bachelor site! This is a season long game,
where you will draft your players in the begining of the season, and score points based on their performance week by week.
All Scores are awarded based soley on what is 
presented in the show itself. If we as the audience are led to 
believe a player had sex before fanatsy suites, for example, that player gets those points. Check out the other tabs 
for charts and graphs of all of the player data. Details on how points are awarded are found below."

roster_description <- "See which players are on which team (aka rosters) on the left. 
                        Current standings are shown on the right. When selecting 
                        which league you want to view remember to hit UPDATE to
                        change the current league."
weekly_scores_description <- "See how the players stacked up against one another
                              on a week to week basis. This tab will only show scores for individual
                              weeks. See the All Player Charts tab for full season stats."

player_list <-c("Hannah Anne","Madison Prewett","Kelsey Weir",
                "Kelley Flanagan","Natasha Parker","Mykenna Dorn",   
                "Syndey Hightower" ,"Tammy Ly","Victoria Paul",   
"Lexi Buchanan","Shiann Lewis" ,"Deandra Kanu","Kiarra Norman",
"Savannah Mullins", "Alayah Benavidez",
"Alexa Caves","Jasmine Nguyen","Sarah Coffin",    
"Courtney Perry","Lauren Jones","Payton Moran",    
"Avonlea Elkins","Eunice Cho","Jade Gillliland", 
"Jenna Serano","Katrina Badowski" ,"Kylie Ramos","Maurissa Gunn",
"Megan Hops","Victoria Fuller")     

test_df <- data.frame(Baskin = c('Tammy Ly'),
                      Pics = c('<img src="download" height="52"></img>'))

player_images <- read.csv("player_images.csv")
