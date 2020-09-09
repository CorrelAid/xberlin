## code to prepare `districts` dataset goes here

districts <- 
  geojsonsf::geojson_sf("https://tsb-opendata.s3.eu-central-1.amazonaws.com/bezirksgrenzen/bezirksgrenzen.geojson") %>% 
  dplyr::mutate(area = sf::st_area(.))

districts$area <- units::set_units(districts$area, km^2)

districts <-
  districts %>% 
  dplyr::mutate(area = units::drop_units(area)) %>% 
  dplyr::mutate(
    area = glue::glue("{as.character(format(area, digits = 3))} km\u00B2"),
    Gemeinde_name = stringr::str_replace(Gemeinde_name, "Ã¶", "ö")
  )
  
usethis::use_data(districts, overwrite = TRUE)
