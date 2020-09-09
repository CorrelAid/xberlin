## code to prepare `streets` dataset goes here

streets <- 
  sf::st_read("data-raw/berlin-latest-free.shp/gis_osm_roads_free_1.shp") %>% 
  dplyr::filter(!fclass %in% c("service", "bridleway", "footway", "path", "pedestrian", "steps", "unknown")) %>% 
  dplyr::mutate(class = ifelse(fclass == "cycleway", "bike", "car"))
 
usethis::use_data(streets, overwrite = TRUE)
