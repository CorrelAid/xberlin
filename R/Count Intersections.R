#Load bike lane Data
rad <- sf::st_read("C:\\YourPathtoData\\Radverkehrsanlagen.geojson",options = "ENCODING=WINDOWS-1252")
names(rad)[names(rad) == 'SORVT_TYP'] <- 'type'
names(rad)[names(rad) == 'LAENGE'] <- 'length'
names(rad)[names(rad) == 'STST_STR'] <- 'street'
names(rad)[names(rad) == 'STOR_NAME'] <- 'district'
names(rad)[names(rad) == 'ORTSTL'] <- 'district2'
names(rad)[names(rad) == 'RVA_TYP'] <- 'category'

#Renaming & Categorisation
rad <-
    rad %>% 
    mutate(
      street = str_replace(street, "ÃŸ", "ß"),
      street = str_replace(street, "Ã¶", "ö"),
      street = str_replace(street, "Ã¼", "ü"),
      agg = case_when(
        str_detect(type, "Z 295") ~ "Cycle lane",
        str_detect(type, "Z 340") ~ "Advisory cycle lane",
        str_detect(type, "Geh-/|Gehweg") ~ "Cycle path on sidewalk",
        type == "Radweg, baulich getrennt" ~ "Cycle path",
        TRUE ~ "Unknown"
      ),
      sub = case_when(
        str_detect(type, "Bussonderfahrstreifen") ~ "bus lane",
        type == "Geh-/Radweg, durch Markierung unterschieden" ~ "marked",
        type == "Geh-/Radweg, baulich unterschieden" ~ "marked",
        type == "Geh-/Radweg, ohne Trennung" ~ "no separation",
        type == "Gehweg, mit Radverkehr frei" ~ "shared with pedestrians",
        str_detect(type, "Radfahrerfurt|Knotenpunkt") ~ "crossing",
        str_detect(type, "ohne ruh.Verkehr") ~ "no parking",
        str_detect(type, "ruh.Verkehr mit Begrenzung") ~ "parking separated",
        str_detect(type, "ruh.Verkehr ohne Begrenzung") ~ "parking",
        TRUE ~ "none"
      ),
      binary = case_when(
        str_detect(category, "Radwege") ~ "1",
        str_detect(category, "Radfahrstreifen") ~ "1",
        str_detect(category, "Schutzstreifen") ~ "0",
        str_detect(category, "Bussonderfahrstreifen") ~ "0"
      )
    )

rad_1 = st_as_sf(rad)
rad_1 <- st_as_sf(x = rad_1,
                         crs = "+datum=WGS84 +unit=m")
rad_2 <- st_as_sf(rad_1) %>% st_transform(3068)

#Create 7 meter buffer
rad_2 <- st_buffer(rad_2, 7)

#Load accident data
shape <- read_sf(dsn = "C:\\YourPathtoData\\Unfallorte2019_LinRef.shp")
uberlin19<-subset(shape, ULAND ==11)
bike19<-subset(uberlin19,IstRad==1)
bikeberlin = st_as_sf(x = bike19,
                         crs = "+datum=WGS84 +unit=m")%>% st_transform(3068)
bikeberlin<-st_zm(bikeberlin)

#Count intersections
inter = st_intersection(bikeberlin, rad_2)