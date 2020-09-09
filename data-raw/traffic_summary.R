## code to prepare `traffic_summary` dataset goes here

inter <- sf::st_intersection(traffic_cells, bike_accidents)

accidents_per_cell <-
  inter %>% 
  dplyr::mutate(
    is_road = ifelse(Category == "Road only", 1, 0),
    is_bike = ifelse(Category != "Road only", 1, 0)
  ) %>% 
  dplyr::group_by(NAME) %>% 
  dplyr::summarize(
    total = dplyr::n(),
    road = sum(is_road),
    bike = sum(is_bike)
  ) %>% 
  dplyr::mutate(
    ## labels for popup vars in tmap
    n_bike = factor(bike),
    n_road = factor(road),
    n_total = factor(total),
    perc_bike = glue::glue("{format(bike / total * 100, digits = 2)}%"),
    perc_road = glue::glue("{format(road / total * 100, digits = 2)}%"),
    ## dont color zero polygons
    bike = ifelse(bike == 0, NA, bike),
    road = ifelse(road == 0, NA, road)
  )

traffic_summary <-
  traffic_cells %>% 
  sf::st_join(accidents_per_cell, by = "NAME") %>% 
  dplyr::select(spatial_name, NAME.x, I_LOR_PRR, Gemeinde_name, bike, road,
                total, perc_bike, perc_road, n_bike, n_road, n_total)

usethis::use_data(traffic_summary, overwrite = TRUE)
