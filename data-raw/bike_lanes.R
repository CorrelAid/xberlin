## code to prepare `bike_lanes` dataset goes here

link <- "https://tsb-opendata.s3.eu-central-1.amazonaws.com/radverkehrsanlagen/Radverkehrsanlagen.geojson.zip"
temp <- tempfile()
download.file(link, temp)
bike_lanes <- geojsonsf::geojson_sf(unz(temp, "Radverkehrsanlagen.geojson"))
unlink(temp)

bike_lanes <-
  bike_lanes %>% 
  dplyr::select(
    street = STST_STR,
    category = RVA_TYP,
    type = SORVT_TYP,
    length = LAENGE,
    district = STOR_NAME,
    district_sub = ORTSTL
  ) %>% 
  dplyr::filter(!category == "") %>%
  dplyr::mutate(
    street = stringr::str_replace(street, "ÃŸ", "ß"),
    street = stringr::str_replace(street, "Ã¶", "ö"),
    street = stringr::str_replace(street, "Ã¼", "ü"),
    district = stringr::str_replace(district, "ÃŸ", "ß"),
    district = stringr::str_replace(district, "Ã¶", "ö"),
    district = stringr::str_replace(district, "Ã¼", "ü"),
    district_sub = stringr::str_replace(district_sub, "ÃŸ", "ß"),
    district_sub = stringr::str_replace(district_sub, "Ã¶", "ö"),
    district_sub = stringr::str_replace(district_sub, "Ã¼", "ü"),
    ## broad categories
    cat = dplyr::case_when(
      type == "Bussonderfahrstreifen Z 340" ~ "bus_lane", 
      type == "Bussonderfahrstreifen Z 295" ~ "bus_lane", 
      type == "Geh-/Radweg, baulich unterschieden" ~ "sidewalk", 
      type == "Geh-/Radweg, durch Markierung unterschieden" ~ "sidewalk", 
      type == "Geh-/Radweg, ohne Trennung" ~ "sidewalk",
      type == "Gehweg, mit Radverkehr frei" ~ "sidewalk", 
      type == "Radfahrerfurt Z 340" ~ "advisory_bike_lane",
      type == "Radfahrstreifen Z 295, ohne ruh.Verkehr" ~ "mandatory_bike_lane", 
      type == "Radfahrstreifen Z 295, ruh.Verkehr mit Begrenzung" ~ "mandatory_bike_lane", 
      type == "Radfahrstreifen Z 295, ruh.Verkehr ohne Begrenzung" ~ "mandatory_bike_lane", 
      type == "Radverkehrsanlage Z 340 im/am Knotenpunktsbereich" ~ "mandatory_bike_lane", 
      type == "Radweg, baulich getrennt" ~ "bike_path", 
      type == "Schutzstreifen Z 340 ohne ruhenden Verkehr" ~ "advisory_bike_lane",
      type == "Schutzstreifen Z 340, mit ruh.Verkehr mit Begrenzung" ~ "advisory_bike_lane", 
      type == "Schutzstreifen Z 340, mit ruh.Verkehr ohne Begrenzung" ~ "advisory_bike_lane"
    ),
    ## mandatory or advisory?
    mandatory = dplyr::case_when(
      stringr::str_detect(category, "Radwege") ~ "mandatory",
      stringr::str_detect(category, "Radfahrstreifen") ~ "mandatory", 
      stringr::str_detect(category, "Schutzstreifen") ~ "advisory",  
      stringr::str_detect(category, "Bussonderfahrstreifen") ~ "advisory",
      stringr::str_detect(type, "advisory") ~ "advisory",
      stringr::str_detect(type, "mandatory") ~ "mandatory"
    )
  ) %>% 
  sf::st_transform(crs = "+proj=geocent +datum=WGS84 +no_defs") %>%  
  sf::st_transform(3068) %>% 
  dplyr::mutate(cat = factor(cat, 
                             levels = c("bike_path", "sidewalk", "mandatory_bike_lane", "advisory_bike_lane", "bus_lane"), 
                             labels = c("Bike path", "On Sidewalk", "Mandatory bike lane", "Advisory bike lane", "Bus lane")))

usethis::use_data(bike_lanes, overwrite = TRUE)
