# CorrelAid X Challenge Berlin

Link to LC notepad: https://pad.correlaid.org/CMrNZoCISn6_8UoI7fFStA?both#

> **Deadline: 10.09.2020**
> **Weekly meetings on Tuesday evening**
> **Next meeting: August 18th, 5:30 pm)**

---

## Next Steps

### @all:
* Discuss main topic - what do we answer with our analysis and vis?
* Static or interactive? (depends mostly on time left)

#

### @Saleh:
* Explore data availabilty of bike accidents per year for different cities (largest cities in Germany and/or Brandenburg) with `datenguidepy`
* Visualize the findings (e.g. bar chart or slope chart of cases per x inhabitants per city over time) *(if you need help/have no time don't hesitate to let us know)*

&rarr; *best case:* several cities with several and recent years overlapping

#### Product next week:
1) Summary data for several cities and years (script and data files, e.g. as Rds, on GitHub)
1) Visualizations of summary stats for several cities and years (script and report/images on GitHub)

#

### @Cédric:
* Import and investigate Unfallatlas data
* Visualize temporal and spatial patterns

&rarr; *best case:* many data points across several timeperiods (daytime, weekday/end, months, years) and areas

#### Product ASAP:
* Unfallatlas data for Berlin (script + data, e.g. as Rds, on GitHub)

#### Product next week:
1) Unfallatlas data for Berlin (script + data, e.g. as Rds, on GitHub)
1) Visualizations for Berlin (script + report/images on GitHub)


#

### @Andreas:
* Explore data availability and mergeability for before-after bike lane improvement (main focus: Unfallatlas - if not: PDF? Other BerlinOpenData Portal? other?) *(if you need help/some discussion don't hesitate to let us know)*

&rarr; *best case:* several bike accidents available for several lanes before and after the improvement

#### Product next week:
1) Report possible or not - what's needed to make it work?
1) Digitalized data of bike lane quality before/after plus filtered data for these streets/areas

##### h5

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
* [Improved bike lanes in Berlin by InfraVelo](https://www.infravelo.de/projektarten/gruenbeschichtungen/) with before-after pictures
* [FixMyBerlin Survey Data (21,000 participants about risk perception of different bike lane setups)](https://fixmyberlin.de/research/subjektive-sicherheit#datensatz-der-ergebnisse)

## Ideas

*

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

* see "Next Steps" on top for now

#

### Meeting August 18th

&rarr; 5:30 pm via Zoom: Link TBA
