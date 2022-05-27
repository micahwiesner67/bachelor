server <- function(input, output) {
  a <- data.frame(Isaac = c('Jojo','Lauren'),
                  Jessica = c('Sarah','Emily'))
  b <- data.frame(Baskin = c('Becca','Sarah'),
                  Terlip = c('Olivia','Cheese'))
  c <- data.frame(Micah = c('Amanda','Lauren'),
                  Gabi = c('Becca','Jojo'))
  
  all_rosters <- list("Easterly Bean League" = a, "Westerly Beans" = b, "The Lost League" = c)
  player_list <- list("Jojo","Emily","Sarah")
  raw_scores <- read.csv("Book1.csv")
  point_values <- read.csv("PointValues.csv", stringsAsFactors = FALSE)
  point_values <- clean_point_values_function(point_values)
  raw_scores <- clean_raw_data(raw_scores)
  #player_trends <- get_player_trends(scoreboard)
  scores <- get_player_scores(raw_scores, point_values)
  scoreboard <- get_scoreboard(scores)
  player_totals <- get_all_player_totals(scoreboard)
  
  roster <- eventReactive(input$update_league,{
    league_name <- input$league
    roster <- all_rosters[[league_name]]
  })

  output$scoreboard <- renderPlot({
    #df <- filter(scoreboard, Player == input$player_line)
    ggplot(data = scoreboard, aes(x = Week, y = total, group = Player, colour=factor(Player))) +
      geom_line()
  })
  
  output$scoreboard_chart <- renderPlot({
    data2 <- filter(scoreboard, Week %in% input$week)
    barplot(data2$total,xlab="Players",ylab="Weekly Score")
  })
  
  output$scores_by_week <- renderPlot({
    chart_data <- filter(scoreboard, Player == input$player)
    plot(chart_data$total,type = "o", xlab="Weeks",ylab="Scores")
  })
  
  output$standings <- renderTable({
    teams <- names(roster())
    standings <- get_standings(scoreboard, roster(), teams)
    standings
  })
  
  output$rosters <- renderTable({
    roster <- roster()
    roster
  })
  
  output$point_value_table <- renderTable({
    point_values
  })
  
  output$all_player_totals <- renderTable({
    player_totals
  })
  
}
