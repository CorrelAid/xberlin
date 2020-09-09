import os
    
#from datenguidepy.query_helper import get_regions, get_statistics, get_availability_summary
from datenguidepy import Query
import pandas as pd
import matplotlib.pyplot as plt

## python info-stats
#print(r[(r['name']=='Berlin')])
#print(r[r['name'].str.contains("Berlin|Hamburg|München|Köln|Frankfurt|Stuttgart|Düsseldorf|Dortmund|Essen|Leipzig|Bremen|Dresden")])
#stats_names = get_statistics()

# Availability
#availability = get_availability_summary()
#print(availability.shape)

## Query Statistics Accidents + some info on cities (pop, dens, cars)
q = Query.region(['11000', '14612', '14713', '02000', '04011', '05111', '05113', '05315', '05913', '06412', '08111', '09162'])

#stat = q.add_field("VER056")
#stat.get_info()

q.add_field('BEV016')  ## Einwohner
q.add_field('AI0201')  ## Bevölkerungsdichte (Einwohner je qkm)
q.add_field('AI0113')	 ## Siedlungs- und Verkehrsfläche je Einwohner
q.add_field('AI1301')  ## Pkw je 1.000 Einwohner
q.add_field('AI1302')  ## Straßenverkehrsunfälle je 10.000 Einwohner
q.add_field('AI1303')  ## Straßenverkehrsunfälle je 10.000 Kfz
q.add_field('AI1304')  ## Getötete bei Straßenverkehrsunfällen je 100.000 EW
q.add_field('AI1305')  ## Verletzte bei Straßenverkehrsunfällen je 100.000EW
q.add_field('VER001')  ## Unfälle (insgesamt)
q.add_field('VER002')  ## Unfälle mit Personenschaden
q.add_field('VER005')  ## Schwerwiegende Unfälle mit Sachschäden i.e.S.
q.add_field('VER056')  ## Schwerwiegende Unfälle mit Sachschaden

# get the results as a Pandas DataFrame
df = q.results(add_units=True)

# extract relevant columns
df = df[['name', 'id', 'year', 'BEV016', 'AI0201', 'AI0113', 'AI1301', 'AI1302', 'AI1303', 'AI1304', 'AI1305', 'VER001', 'VER002', 'VER005', 'VER056']]
