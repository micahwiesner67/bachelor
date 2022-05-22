clean_points_function <- function(my_dataframe){
  my_dataframe %>% 
    mutate(Event = gsub(" ", "_", Event)) 
}
