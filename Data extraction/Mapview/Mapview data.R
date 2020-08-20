#Open file
rad <- st_read("C:\\YourPathtofile\\Radverkehrsanlagen.geojson",options = "ENCODING=UTF-8")

#Translate
names(rad)[names(rad) == 'SORVT_TYP'] <- 'type'
names(rad)[names(rad) == 'LAENGE'] <- 'length'
names(rad)[names(rad) == 'STST_STR'] <- 'street'
names(rad)[names(rad) == 'STOR_NAME'] <- 'district'
names(rad)[names(rad) == 'ORTSTL'] <- 'district2'
names(rad)[names(rad) == 'RVA_TYP'] <- 'category'

rad$type <- gsub("Bussonderfahrstreifen Z 295", "bus lane", rad$type)
rad$type <- gsub("Bussonderfahrstreifen Z 340", "bus lane", rad$type)
rad$type <- gsub("Geh-/Radweg, durch Markierung unterschieden", "side walk and cycling infrastructure seperated by road markings", rad$type)
rad$type <- gsub("Geh-/Radweg, baulich unterschieden", "side walk and cycling infrastructure structurally separated", rad$type)
rad$type <- gsub("Geh-/Radweg, ohne Trennung", "side walk and cycling infrastructure combined", rad$type)
rad$type <- gsub("Gehweg, mit Radverkehr frei", "side walk also used by cyclists", rad$type)
rad$type <- gsub("Radfahrerfurt Z 340", "bicycle crossing ", rad$type)
rad$type <- gsub("Radfahrstreifen Z 295, ohne ruh.Verkehr", "bike lane separated from traffic", rad$type)
rad$type <- gsub("Radfahrstreifen Z 295, ruh.Verkehr mit Begrenzung", "bike lane separated from stationary traffic", rad$type)
rad$type <- gsub("Radfahrstreifen Z 295, ruh.Verkehr ohne Begrenzung", "bike lane not separated from stationary traffic", rad$type)
rad$type <- gsub("Radverkehrsanlage Z 340 im/am Knotenpunktsbereich", "cycling infrastructure at road junctions", rad$type)
rad$type <- gsub("Radweg, baulich getrennt", "structurally separated cycling infrastructure", rad$type)
rad$type <- gsub("Schutzstreifen Z 340 ohne ruhenden Verkehr", "advisory cycle lane/no stationary traffic", rad$type)
rad$type <- gsub("Schutzstreifen Z 340, mit ruh.Verkehr mit Begrenzung", "advisory cycle lane separated from stationary traffic", rad$type)
rad$type <- gsub("Schutzstreifen Z 340, mit ruh.Verkehr ohne Begrenzung", "advisory cycle lane not separated from stationary traffic", rad$type)

rad$category <- gsub("Bussonderfahrstreifen", "bus lane", rad$category)
rad$category <- gsub("Radfahrstreifen", "bike lane", rad$category)
rad$category <- gsub("Radwege", "Cycling infrastructure", rad$category)
rad$category <- gsub("Schutzstreifen", "advisory bike lane", rad$category)

#Create map
mapview(rad, zcol="type")