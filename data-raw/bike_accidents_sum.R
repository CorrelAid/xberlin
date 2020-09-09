## code to prepare `accidents` dataset goes here

## download shapefile if needed
if (!file.exists("data-raw/Unfallorte2019/Shapefile/Unfallorte2019_LinRef.shp")) {
  download.file(
    url = 'https://www.opengeodata.nrw.de/produkte/transport_verkehr/unfallatlas/Unfallorte2019_EPSG25832_Shape.zip',
    destfile = 'data-raw/Unfallorte2019.zip', 
    method = 'curl'
  )
  
  unzip('data-raw/Unfallorte2019.zip', exdir = 'data-raw/Unfallorte2019')
}

## load accident data and keep only bike accidents in Berlin
accidents <- 
  sf::read_sf(dsn = "data-raw/Unfallorte2019/Shapefile/Unfallorte2019_LinRef.shp") %>% 
  sf::st_drop_geometry() %>% 
  dplyr::filter(ULAND == 11) %>% 
  dplyr::mutate(UKREIS = as.numeric(UKREIS)) %>% 
  dplyr::mutate(dplyr::across(dplyr::starts_with("Ist"), as.numeric)) %>% 
  dplyr::left_join(district_id, by = c("UKREIS" = "Gemeinde_schluessel")) 

accidents_sum_all <-
  accidents %>%
  dplyr::group_by(Gemeinde_name) %>%
  dplyr::summarize(
    Bikes = sum(IstRad),
    Cars = sum(IstPKW) + sum(IstGkfz) + sum(IstSonstig),
    Motorcycles = sum(IstKrad),
    Pedestrians = sum(IstFuss)
  ) %>% 
  tidyr::pivot_longer(
    cols = c(Bikes, Cars, Pedestrians, Motorcycles),
    names_to = "type",
    values_to = "accidents"
  )

accidents_sum_bikes <-
  accidents %>%
  dplyr::filter(IstRad == 1) %>% 
  dplyr::group_by(Gemeinde_name) %>%
  dplyr::summarize(
    Bikes = sum(IstRad),
    Cars = sum(IstPKW) + sum(IstGkfz) + sum(IstSonstig),
    Motorcycles = sum(IstKrad),
    Pedestrians = sum(IstFuss)
  ) %>% 
  tidyr::pivot_longer(
    cols = c(Bikes, Cars, Pedestrians, Motorcycles),
    names_to = "type",
    values_to = "accidents"
  )  
  
usethis::use_data(accidents_sum_all, overwrite = TRUE)
usethis::use_data(accidents_sum_bikes, overwrite = TRUE)
