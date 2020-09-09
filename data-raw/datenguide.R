## code to prepare `datenguide` dataset goes here

reticulate::source_python("data-raw/get_data_datenguidepy.py")

datenguide <- 
  df %>% 
  ## remove duplicated rows
  unique() %>% 
  ## clean city names
  dplyr::mutate(
    name = stringr::str_remove(name, ", Stadt|, Kreisfreie Stadt|, Landeshauptstadt"),
    name = stringr::str_remove(name, ", Stadtkreis")
  ) %>% 
  tidyr::pivot_longer(
    cols = BEV016:VER056,
    names_to = "stat",
    values_to = "value"
  ) %>% 
  dplyr::filter(!is.nan(value)) %>% 
  dplyr::mutate(
    stat_long = dplyr::case_when(
      stat == 'BEV016' ~ "Einwohner", 
      stat == 'AI0201' ~ "Bevölkerungsdichte (Einwohner je qkm)", 
      stat == 'AI0113' ~ "Siedlungs- und Verkehrsfläche je Einwohner", 
      stat == 'AI1301' ~ "Pkw je 1.000 Einwohner", 
      stat == 'AI1302' ~ "Straßenverkehrsunfälle je 10.000 Einwohner", 
      stat == 'AI1303' ~ "Straßenverkehrsunfälle je 10.000 Kfz", 
      stat == 'AI1304' ~ "Getötete bei Straßenverkehrsunfällen je 100.000 Einwohner", 
      stat == 'AI1305' ~ "Verletzte bei Straßenverkehrsunfällen je 100.000 Einwohner", 
      stat == 'VER001' ~ "Unfälle (insgesamt)", 
      stat == 'VER002' ~ "Unfälle mit Personenschaden", 
      stat == 'VER005' ~ "Schwerwiegende Unfälle mit Sachschäden i.e.S.", 
      stat == 'VER056' ~ "Schwerwiegende Unfälle mit Sachschaden"
    ),
    stat_eng = dplyr::case_when(
      stat == 'BEV016' ~ "Inhabitants", 
      stat == 'AI0201' ~ "Population density (inhabitants per sq km)", 
      stat == 'AI0113' ~ "Settlement and traffic area per inhabitant", 
      stat == 'AI1301' ~ "Cars per 1,000 inhabitants", 
      stat == 'AI1302' ~ "Road traffic accidents per 10,000 inhabitants", 
      stat == 'AI1303' ~ "Road traffic accidents per 10,000 vehicles", 
      stat == 'AI1304' ~ "Fatalities in road traffic accidents per 100,000 inhabitants", 
      stat == 'AI1305' ~ "Persons injured in road traffic accidents per 100,000 inhabitants", 
      stat == 'VER001' ~ "Accidents (total)", 
      stat == 'VER002' ~ "Accidents with personal injury", 
      stat == 'VER005' ~ "Serious accidents with material damage in the narrow sense", 
      stat == 'VER056' ~ "Serious accidents with material damage"
    )
  )  %>% 
  #dplyr::filter(stat %in% c("AI1302", "AI1303", "AI1305", "AI1304", "VER001", "VER002")) %>% 
  tidyr::pivot_wider(
    id_cols = c(name, id, year), 
    names_from = stat, 
    values_from = value
  )

## years to fill
years <-
  datenguide %>% 
  tidyr::expand(tidyr::nesting(name), tidyr::full_seq(year, 1))

datenguide <-
  datenguide %>% 
  dplyr::full_join(years, by = c("year" = "tidyr::full_seq(year, 1)", "name" = "name")) %>% 
  #dplyr::arrange(-BEV016) %>%  ## sort by population
  dplyr::arrange(-AI0201) %>%  ## sort by density
  #dplyr::arrange(-AI1301) %>%  ## sort by cars per 1,000 inhabitants
  dplyr::mutate(name = forcats::fct_inorder(name)) %>% 
  dplyr::select(
    name, year,
    `per 10,000 inhabitants` = AI1302,
    `per 10,000 cars` = AI1303,
    `total` = VER002
  ) %>%
  dplyr::mutate(year = as.character(year)) %>% 
  dplyr::arrange(year)
  

usethis::use_data(datenguide, overwrite = TRUE)

