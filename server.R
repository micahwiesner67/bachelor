server <- function(input, output) {
  all_rosters <- get_all_rosters()
  raw_scores <- read.csv("Book1.csv")
  raw_scores <- clean_raw_data(raw_scores)
  point_values_full <- read.csv("PointValues for Table.csv", stringsAsFactors = FALSE)
  point_values <- read.csv("PointValues.csv", stringsAsFactors = FALSE)
  point_values <- clean_point_values_function(point_values)
  raw_scores_for_dt <- get_raw_scores_for_dt(raw_scores)
  scores <- get_player_scores(raw_scores, point_values)
  scores <- calculate_rose_number_points(scores)
  scoreboard <- get_scoreboard(scores)
  player_totals <- get_all_player_totals(scoreboard)
  
  scoreboard %<>% 
    group_by(Player) %>% 
    mutate(rolling_total = 
             cumsum(total))
  
  roster <- eventReactive(input$update_league,{
    league_name <- input$league
    roster <- all_rosters[[league_name]]
  })
  
  standings <- eventReactive(input$update_league,{
    league_name <- input$league
    roster <- all_rosters[[league_name]]
    teams <- names(roster())
    standings <- get_standings(scoreboard, roster(), teams)
  })
  
  x <- reactive(input$chart_type)
  output$scoreboard <- renderPlot({
    if (x() == "Individual Weeks"){
      plot_data <- select(scoreboard, c(Player, Week,total))
      plot_data$label <- NA
      plot_data$label[which(plot_data$Week == max(plot_data$Week))] <- plot_data$Player[which(plot_data$Week == max(plot_data$Week))]
    ggplot(data = plot_data, aes(x = Week, y = total,group=Player ,colour=factor(Player))) +
      geom_line()+geom_label_repel(aes(label=label), nudge_x=1,na.rm = TRUE)}+theme(legend.position="none")
    else{
      plot_data <- select(scoreboard, c(Player, Week,rolling_total))
      plot_data$label <- NA
      plot_data$label[which(plot_data$Week == max(plot_data$Week))] <- plot_data$Player[which(plot_data$Week == max(plot_data$Week))]
      ggplot(data = plot_data, aes(x = Week, y = rolling_total,group=Player ,colour=factor(Player))) +
        geom_line()+geom_label_repel(aes(label=label), nudge_x=1,na.rm = TRUE)}+theme(legend.position="none")
  }, width=900, height = 600)
  
  output$scoreboard_chart <- renderPlot({
    scoreboard <-  scoreboard[order(scoreboard$total),]
    data2 <- filter(scoreboard, Week %in% input$week)
    player_dropdown <- data2$Player
    coul <- brewer.pal(nrow(data2), "Set2") 
    barplot(data2$total,names.arg = player_dropdown,ylab="Weekly Score",col=coul,las=2,cex.names=.7)
  }, width = 550, height =550)
  
  output$standingsChart <- renderPlot({
    s <- as.matrix(standings())
    team_labels <- names(standings)
    barplot(s, xlab=team_labels, ylab="Total Weekly Score", col=c("royalblue"))
    },
    height = 500,
    width =500)
  
  output$standings <- renderTable({
    teams <- names(roster())
    standings <- get_standings(scoreboard, roster(), teams)
    standings
  })
  

  output$rosters <- DT::renderDataTable(
    DT::datatable({data <- player_images},
                   escape = FALSE,
                   rownames = FALSE,
                   options = list(initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'color': 'white'});",
                     "}"
                   ),
                  columnDefs = list(list(className = 'dt-center', targets = 0))),
                   selection = 'single'
    ))

  #output$rosters <- renderTable({
  #  roster <- roster()
  #  roster
  #})
  
  output$point_value_table <- renderTable(
    point_values_full,
    striped = TRUE,
    bordered = TRUE,
    spacing = c("m"),
    width = "500px",
    colnames = TRUE,
    digits = NULL,
    na = "NA",
    env = parent.frame(),
    quoted = FALSE,
    outputArgs = list()
  )
  
  output$all_player_totals <- DT::renderDataTable(DT::datatable({
    player_totals <- select(scoreboard, c("Player","Week","total"))
    player_totals <- filter(scoreboard, Week == input$week)
    player_totals <- dplyr::rename(player_totals,
      `Weekly Total`=total,
      `Season Total` = rolling_total
    )
    player_totals <- player_totals[order(-player_totals$`Weekly Total`),]
    merge(x = player_totals, y = player_images, by=c("Player"))},
    escape = FALSE,
    rownames = FALSE,
    options = list(initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'color': 'white'});",
      "}"
    ),columnDefs = list(list(className = 'dt-center', targets = 0))),
    selection = 'single'
  ))

  
  player_selected <- reactive(input$player)
  output$scores_by_week <- renderPlot({
    chart_data <- filter(scoreboard, Player == input$player)
    ggplot(data=chart_data,aes(x=Week,y=total,group=1))+geom_line(color="red")+geom_point()
  })
  
  output$DT_scoreboard <- DT::renderDataTable({
    datatable(raw_scores_for_dt, options = list(pageLength=25,
                                     paging=TRUE,
      initComplete = JS(
        "function(settings, json) {",
        "$(this.api().table().header()).css({'color': 'white'});",
        "}"
        )))})
  
}
