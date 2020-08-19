# CorrelAid X Challenge Berlin

Link to LC notepad: https://pad.correlaid.org/CMrNZoCISn6_8UoI7fFStA?both#

> **Deadline: 10.09.2020**
> **Weekly meetings on Tuesday evening**
> **Next meeting: August 18th, 5:30 pm)**

---

## Next Steps

### ✦ Collect accident data for several cities with `datenguidepy`
* **Main goal: Comparison of accidents (maybe also traffic?) of different large cities**
* Problem: `datenguidepy` provides these stats but each combination of stat and city has to be queried. To work efficiently and visulaize the data all together, we need all relvant stats for chosen cities in one dataframe.
* Task: Create one final dataset with all 6 cities and several statistics in one dataframe (script and data file, e.g. as Rds, on GitHub)
    * Stats: accidents with injuries per x cars/x inhabitants and year
    * Cities: 5 largest cities with regard to population besides Berlin in Germany: Berlin, Hamburg, Munich, Cologne, Frankfurt (Main) and Stuttgart)

***&rarr; Saleh, with the help of Cédric if needed***

#

### ✦ Visualize accident data for several cities
* **Main goal: Comparison of accidents (maybe also traffic?) of different large cities**
* Task: Visualizations of summary stats as comparison between cities and years (script and report/images on GitHub)

***&rarr; Saleh & Cédric***

#

### ✦ Find traffic data to estimates rates
* **Main goal: Comparison of accidents per x road users for different areas/bike lane types**
* Problem: Unfallatlas provides absolute numbers—however, if we want to compare different bike lane types we need somehow to acocunt for the traffic (#accidents / #cyclist). We have some traffic data on motorised vehicles from 2014 ([link](https://data.technologiestiftung-berlin.de/dataset/verkehrsmengen)) but more detailed data on all types of road users would be good
* Task: Search for other traffic data for Berlin, in the best case recent and including bikes

***&rarr; Andreas & Cédric, with feedback from others***

#

### ✦ Merge geodata with roads *(only if suitable traffic data available)*
* **Main goal: Comparison of accidents per x road users for different areas/bike lane types**
* Problem: The Unfallatlas data contains geolocations (lat/long) while the bike lane data is based on roads
* Task: Match the geolocations to the (closest) road and extract number of acidents per road, area, and bike lane type.

***&rarr; Andreas, with the help of Cédric if needed***

#

### ✦ Visualize accidents (absolute or relative)
* **Main goal: Comparison of accidents per x road users for different areas/bike lane types**
* Task: Depending on the suitable traffic data we either
    * show simply bike lane types and absolute numbers of accidents (thus no need to match geolocations to rads) + hotspots + (number of accidents per district?)
    * show relative risk of bike accidents + additional charts comparing relative rik per bike lane type, district, ...  
    * Match the geolocations to the (closest) road and extract number of acidents per road, area, and bike lane type.

***&rarr; Andreas & Cédric***

---

### Potential Topics:

* Comparison of accidents before and after bike lane improvement for selected roads
    * Potential Problems:
        * External effects (account for rush hour, season, etc.)
        * Data - enough after improvement available? &rarr; Andreas

* Tool to find direction with lowest risk and highest proportion of bike lanes
    * Potential Problems:
        * too ambitious?

* Hot spot analysis (which factors play a role? Rush hour, road type, bike lane type, distance to city centre, public transport stations/hubs, ...)
    * Potential Problems:
        * Data - enough information for proper analysis
        * Otherwise maybe only descriptive/informative :/

---

## Data

* [`datenguidepy`](https://github.com/CorrelAid/datenguide-python) the dataset XY for comparison of big cities Germany-wide (or just Brandenburg?)
* [Unfallatlas data](https://unfallatlas.statistikportal.de/_opendata2020.html) for detailled Berlin data
* [Unfallschwerpunkte ('accident hotspots') by Berlin Police](https://www.berlin.de/polizei/_assets/aufgaben/anlagen-verkehrssicherheit/pkverkehrssicherheitslage2018.pdf) ![](https://i.imgur.com/E6G95RS.png)
* [Traffic data for motorised vehicles](https://data.technologiestiftung-berlin.de/dataset/verkehrsmengen) from 2014
* [Reports on bike accidents by Berlin Police](https://www.berlin.de/polizei/_assets/aufgaben/anlagen-verkehrssicherheit/radfahrer2018.pdf) ([all reports under section "Radfahrer"](https://www.berlin.de/polizei/aufgaben/verkehrssicherheit/verkehrsunfallstatistik/))
* [Improved bike lanes in Berlin by InfraVelo](https://www.infravelo.de/projektarten/gruenbeschichtungen/) with before-after pictures
* [FixMyBerlin Survey Data (21,000 participants about risk perception of different bike lane setups)](https://fixmyberlin.de/research/subjektive-sicherheit#datensatz-der-ergebnisse)

## Resources

**Scripts:**

* [Explorative Python script by Lara](https://github.com/laraschmitt/xberlin/blob/master/exploratory_regionalstatistics.py)
* [Explorative R script](https://github.com/CorrelAid/xberlin/blob/master/R/1_data.Rmd) providing a [searchable table of all stats](https://correlaid.github.io/xberlin/1_data.html)

**Resources general:**

* [A collection of (all?!) Berlin's spatial units](https://lab.technologiestiftung-berlin.de/projects/spatial-units/en/) including districts, district areas, LORs, traffic cells, corridors, and ZIP code areas
* [BerlinOpenData](https://daten.berlin.de/) for a range of (potentially) interesting data about Berlin

**Resources accidents and bike lanes:**
* [Unfallatlas by Destatis](https://unfallatlas.statistikportal.de/)
* [CartoDB Berlin Map by Stefan Wehrmeyer](https://stefanwehrmeyer.carto.com/viz/4fc39e13-8dbb-4d3f-a181-b2918861b6de/public_map)
* [FixMyBerlin Survey Data (21,000 participants about risk perception of different bike lane setups)](https://fixmyberlin.de/research/subjektive-sicherheit#datensatz-der-ergebnisse)
* [Reports on accidents by Berlin Police](https://www.berlin.de/polizei/aufgaben/verkehrssicherheit/verkehrsunfallstatistik/)


**Other reports, studies, visualizations on accidents and bike Lanes:**
* [Tagesspiegel article on FixMyBike survey with some nice visualizations](https://interaktiv.tagesspiegel.de/lab/strassencheck-ergbnisse-diese-strassen-will-berlin/)
* [Tagesspiegel article from 2018 on bike lane quality](https://interaktiv.morgenpost.de/radwege-in-berlin/)

---

---
---

## Meetings

### Meeting July 21st

* Data via [datenguidepy](https://github.com/CorrelAid/datenguide-python)

#### Next steps

* Have a look at the data
* Think about possible projects/topics
* Make yourself familiar with Python usage/data import etc.

#

### Meeting July 28th


&rarr; Participants: Andreas, Cédric, Michael & Saleh

**Ideas:**

* Urban agriculture *(Saleh)*
* Green spaces (#/area) in Berlin *(Michael)*
* Bike lanes and car accidents *(Andreas)*
* Living versus non-living space & rental prices *(Cédric)*
* (Movement of young people to Berlin (East/West))

In general
* East/West comparison
* Comparison Germany-wide

**Next steps:**

* **Explore the datasets in more detail via `datenguidepy`** (own Rmd script, Jupyter notebook, Laras or Cédric's scripts...)
* **Search for additional resources** (one requirement—or a "nice-to-have"—acoording to the rules are external data)
* **Check news, articles, studies on that topic** for...
  + interesting findings/patterns/stories in other cities
  + detailed reports for Berlin on the same topic (might either help or let's us discard the idea)

#

### Meeting August 4th

&rarr; Participants: Andreas, Cédric, Lara & Saleh

* Only Berlin-level data available for most (all?!) stats
    + need for external data
    + and/or comparison to Brandenburg (Gemeinden available) or other cities

* Urban agriculture *(Saleh)*
    + not yet any detaileld data or trends but many stats
    + Saleh continues as a side project/plan B

* Bike lanes and car accidents *(Andreas)*
    + unfortunately only data up to 2018
    + maybe something like [Unfallatlas by Destatis](https://unfallatlas.statistikportal.de/) or [CartoDB Berlin Map by Stefan Wehrmeyer](https://stefanwehrmeyer.carto.com/viz/4fc39e13-8dbb-4d3f-a181-b2918861b6de/public_map)
    + maybe combine with survey data on bike lane design by [FixMyBerlin](https://fixmyberlin.de/research/subjektive-sicherheit#datensatz-der-ergebnisse)

* Living versus non-living space & rental prices *(Cédric)*
    + only Berlin-level data, often not many years and/or stable trends

* Green spaces (#/area) in Berlin *(Michael)*
    + not present

* **&rarr; Team decision to focus on bike accidents/lanes in Berlin**
    + Unfallatlas with additional insights/information
    + Ideas:
        + combine with survey data?
        + square mile representation of high/low risk areas?
        + maybe combine with public transport information?
        + check different street types, districts etc.
    + Tools:
        + interactive app? &rarr; Shiny/Leaflet/Plotly
        + Static maps (square mile bubbles) &rarr;[mnaybe inspired by Alberto López](https://www.lucasinfografia.com/Little-Boy-Fat-Man)
    + Data:
        + Overview charts and/or comparison with other cities via datenguidepy
        + Detailed maps of accidents via data from destatis ("Unfallatlas")

![](https://payload.cargocollective.com/1/9/310126/10266518/AtomicBOMBs_1000.png)

**Next Steps:**
* Discuss how we maybe could include survey dats *(Cédric & Lara + everyone interested, mainly on Slack)*
* Explore data sources *(Andreas)*
* Check first stats: bike accidents (we only focus on bikes now right?) per district, road type, time, .... (summaries not maps) *(Cédric + anyone who is interested)*
* Explore urban agriculture data *(Saleh)*

#

### Meeting August 11th

&rarr; Participants: Andreas, Cédric & Saleh

#### Main Idea:
* Accidents of cyclist in relation to bike lane types
    * Part 1: Overall comparison between cities Germany wide to include `datenguidepy`
    * Part 2: Static or interactive map of bike lane type and accidents + hotspots

#### General Updates:
* Still to fix some issues with Python and detailled data
* Do we really need to digitalize the reports from the Berlin Police Department? &rarr; Let's try to use the Unfallatlas data first
* Please upload all scripts and output on GitHub and actively engage in discussions on Slack

#### Open questions:
* Discuss main topic - what do we answer with our analysis and vis?
* Static or interactive? (depends mostly on time left)
* Do we need more data?

#### Next Steps:
* Explore data availability of bike accidents per year for different cities (largest cities in Germany and/or Brandenburg) with `datenguidepy` ***&rarr; Saleh***
* Visualize the findings (e.g. bar chart or slope chart of cases per x inhabitants per city over time) ***&rarr; Saleh*** *(if you need help/have no time don't hesitate to let us know)*
* Import and investigate Unfallatlas data ***&rarr; Cédric***
* Visualize temporal and spatial patterns ***&rarr; Cédric***
* Explore data availability and mergeability for before-after bike lane improvement (main focus: Unfallatlas - if not: PDF? Other BerlinOpenData Portal? other?) ***&rarr; Andreas*** *(if you need help/some discussion don't hesitate to let us know)*
* Digitalize data of bike lane quality before/after plus filtered data for these streets/areas ***&rarr; Andreas***

#

### Meeting August 18th

&rarr; 5:30 pm via Zoom

&rarr; Participants: Andreas, Cédric & Saleh

#### Main Idea (same as before):
* Accidents of cyclist in relation to bike lane types
    * Part 1: Overall comparison between cities Germany wide to include `datenguidepy`
    * Part 2: Static or interactive map of bike lane type and accidents + hotspots

#### General Updates:
* Andreas:
    * Shiny map showing bike lane types in Berlin works locally but problems on server ![](https://i.imgur.com/0O6fR9T.jpg)
    * Still searching for a way/someone to digitalize the Police reports &rarr; very coarse so we decided for now to NOT use this source anyway
    * To say anything about how good or bad specific bike lane types are we need to acocunt for several factors &rarr; actually time of the day and year may not be a problem since we have the same data quality for all areas butg wse should definitely account for traffic
    * So far we only have traffic daat for motorised vehicles from 2014; some including bikes (and maybe even pedestriants) would be nice!
    * If we find proper treaffic data, we need to find the road for each geolocation in the Unfallatlas data to match the accident with the bike lane type
    * If we can't accoutn for traffic we anyway can only show aboslute nubmers and no details are probably needed (only for interaoctive so people can filter by different bike lane type?)
* Cédric:
    * Unfallatlas data available for everyone on GitHub, first visulaizations of trends ![](https://i.imgur.com/38PhYEZ.png)![](https://i.imgur.com/UtlMgL1.png)![](https://i.imgur.com/IAnIrMh.png)
    * For Berlin, there are unfortunately only 2 years (2018 and 2019) with roughly 5.000 accidents involving bikes per year
* Saleh:
    * Problems with saving csv solved &rarr; still would be cool to get reticulate to work so we can access the data directly from the `datenguidypy` package!
    * First example visualizatiosn for Saarland on GitHub ![](https://i.imgur.com/XEpkqF5.png) ![](https://i.imgur.com/aX3ZA8J.png) ![](https://i.imgur.com/ZYj4tqS.png)
    * We need data for largest cities not federal states &rarr; decided to use 5 largest cities by population to compare with Berlin; this includes 6 different federal states in different directions of Germany as well as the two most populated cities (Munich and Berlin) ([Wiki link](https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population))![](https://i.imgur.com/UxMNXwU.png)

* also see next stepsd on top!

#

### Mext Meeting: August 18th

&rarr; 6 pm via Zoom
