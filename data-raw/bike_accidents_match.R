## code to prepare `bike_accidents` dataset goes here

## change TZ to have English labels for month and weekday
Sys.setlocale("LC_TIME", "C")

## load accident data and keep only bike accidents in Berlin
bike_accidents_19 <- 
  sf::read_sf(dsn = "data-raw/Unfallorte2019/Shapefile/Unfallorte2019_LinRef.shp") %>% 
  dplyr::filter(ULAND == 11, IstRad == 1) %>% 
  sf::st_transform(crs = 3068) %>%  
  sf::st_zm(drop = TRUE)

## add buffer to each line to match accidents to bike lanes
bike_lanes_buffer <- sf::st_buffer(bike_lanes, 4, endCapStyle = 'FLAT') 
inter <- sf::st_intersection(bike_lanes_buffer, bike_accidents_19)
  
## add categories for road accidents
bike_accidents_road <-
  bike_accidents_19 %>% 
  dplyr::filter(!(OBJECTID %in% inter$OBJECTID)) %>% 
  dplyr::mutate(
    sub = "none",
    cat = "road",
    mandatory = "not applicable"
  )

## full dataset with accidents matched to bike lanes and roads 
bike_accidents <-
  inter %>% 
  dplyr::select(OBJECTID:STRZUSTAND, cat, mandatory) %>% 
  dplyr::bind_rows(bike_accidents_road) %>% 
  sf::st_transform(crs = 25832) %>% 
  sf::st_transform(crs = sf::st_crs(bike_lanes)) %>%
  dplyr::mutate(cat = as.character(cat)) %>% 
  dplyr::mutate(
    cat = factor(
      cat, 
      levels = c("Bike path", "On Sidewalk", "Mandatory bike lane", "Advisory bike lane", "Bus lane", "road"), 
      labels = c("Bike path", "On Sidewalk", "Mandatory bike lane", "Advisory bike lane", "Bus lane", "Road only")
    ),
    opponent = dplyr::case_when(
      IstPKW == 1 ~ "Car", 
      IstFuss == 1 ~ "Pedestrian", 
      IstKrad == 1 ~ "Motorcycle", 
      IstGkfz == 1 ~ "Lorry", 
      IstSonstig == 1 ~ "Other", 
      TRUE ~ "Bike"
    ),
    opponent_agg = dplyr::case_when(
      opponent %in% c("Car", "Lorry", "Other") ~ "Cars",
      opponent == "Bike" ~ "Bikes",
      opponent == "Pedestrian" ~ "Pedestrians",
      opponent == "Motorcycle" ~ "Motorcycles"
    ),
    opponent_agg = factor(opponent_agg, levels = c("Pedestrians", "Bikes", "Motorcycles", "Cars")),
    UMONAT = lubridate::month(as.numeric(UMONAT), label = T, abbr = F),
    UWOCHENTAG = lubridate::wday(as.numeric(UWOCHENTAG), label = T, abbr = F),
    USTUNDE = as.numeric(USTUNDE),
    ULICHTVERH = dplyr::case_when(ULICHTVERH == 0 ~ "Daylight", 
                                  ULICHTVERH == 1 ~ "Twilight",
                                  ULICHTVERH == 2 ~ "Darkness"),
    ULICHTVERH = factor(ULICHTVERH, levels = c("Daylight", "Twilight", "Darkness")),
    USTUNDE = ifelse(USTUNDE > 12, paste(USTUNDE - 12, "pm"), paste(USTUNDE, "am")),
    STRZUSTAND = dplyr::case_when(
      STRZUSTAND == 0 ~ "Dry",
      STRZUSTAND == 1 ~ "Wet",
      STRZUSTAND == 2 ~ "Icy"
    )
  )
  
## clean duplicates: there are 4 true duplicates 
## (i.e. accidents falling into two bike lane categories)
## -> we randomly pick one of each duplicated accidents
# duplicates <- 
#   bike_accidents %>% 
#   group_by(OBJECTID) %>% 
#   count(OBJECTID) %>% 
#   filter(n > 1) %>% 
#   pull(OBJECTID)

bike_accidents <-
  bike_accidents %>% 
  dplyr::group_by(OBJECTID) %>% 
  dplyr::slice(1)  %>% 
  dplyr::select(
    ID = OBJECTID, 
    Year = UJAHR,
    Month = UMONAT,
    Weekday = UWOCHENTAG,
    Hour = USTUNDE,
    Light = ULICHTVERH,
    Condition = STRZUSTAND,
    Opponent = opponent,
    Opponent_agg = opponent_agg,
    Category = cat,
    Obligation = mandatory
  ) %>% 
  dplyr::ungroup()

usethis::use_data(bike_accidents, overwrite = TRUE)
