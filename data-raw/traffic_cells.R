## code to prepare `traffic_cells` dataset goes here

## District names and id's to merge with traffic cells
district_id <-
  geojsonsf::geojson_sf("https://tsb-opendata.s3.eu-central-1.amazonaws.com/bezirksgrenzen/bezirksgrenzen.geojson") %>% 
  dplyr::group_by(Gemeinde_name) %>% 
  dplyr::summarize(Gemeinde_schluessel = unique(as.numeric(Gemeinde_schluessel))) %>% 
  dplyr::mutate(
    Gemeinde_name = stringr::str_replace(Gemeinde_name, "ÃŸ", "ß"),
    Gemeinde_name = stringr::str_replace(Gemeinde_name, "Ã¶", "ö"),
    Gemeinde_name = stringr::str_replace(Gemeinde_name, "Ã¼", "ü")
  )

traffic_cells <- 
  ## Verkehrszellen
  #sf::st_read("https://tsb-opendata.s3.eu-central-1.amazonaws.com/verkehrszellen/verkehrszellen.geojson") %>% 
  ## Teilverkehrszellen
  sf::st_read("https://tsb-opendata.s3.eu-central-1.amazonaws.com/teil_verkehrszellen/teil_verkehrszellen.geojson") %>% 
  sf::st_join(district_id, by = c("BERLIN_BEZ" = "Gemeinde_schluessel")) %>% 
  sf::st_transform(crs = 3068) %>% 
  sf::st_make_valid() %>% 
  dplyr::group_by(spatial_name) %>% 
  dplyr::slice(1)
 
usethis::use_data(traffic_cells, overwrite = TRUE)
