# CorrelAid X Challenge Berlin

A shiny app to explore acidents in Germany as well as bike lane types and bike accidents Berlin.

Created for the CorrelAidX Challenge 2020 *“Analysing and visualising German regional statistics with datenguidepy”* by Cédric Scherer, Andreas Neumann, Saleh Hamed & Steffen Reinhold as contribution by CorrelAidX Berlin.

### View the app online

[Link to shinyapps.io](https://cedric-scherer.shinyapps.io/xberlin/)

(The app might or might not work depending on how many people have recently visited the page. Sorry, we are very limited in memory unfortunately. If the app doesn't load, please try it again at a later point or install the package as explained below.)


### Run the app as package in `R`

In your R console, run the following. Make sure the `{devtools}` package is installed as well (if not, run `install.packages("devtools")`.

```
devtools::install_github("CorrelAid/xberlin")
xberlin::run_app(launch.browser = .rs.invokeShinyWindowExternal)
```

### Previews

#### Slide 1: Title Page

<img src="./inst/app/www/preview/slide_1.png" width="80%" />

#### Slide 3: Comparison of Accidents with personal injury in Major Cities in Germany

<img src="./inst/app/www/preview/slide_3_1.png" width="80%" />
<img src="./inst/app/www/preview/slide_3_2.png" width="80%" />
<img src="./inst/app/www/preview/slide_3_3.png" width="80%" />
<img src="./inst/app/www/preview/slide_3_4.png" width="80%" />
<img src="./inst/app/www/preview/slide_3_5.png" width="80%" />

#### Slide 4: Accidents with personal injury in Berlin in 2019 per District and Road User

<img src="./inst/app/www/preview/slide_4_1.png" width="80%" />
<img src="./inst/app/www/preview/slide_4_2.png" width="80%" />
<img src="./inst/app/www/preview/slide_4_3.png" width="80%" />

#### Slide 5: Berlin Map of Bike Accidents with personal injury and Bicycle Infrastructure

<img src="./inst/app/www/preview/slide_5_1.png" width="80%" />
<img src="./inst/app/www/preview/slide_5_2.png" width="80%" />
<img src="./inst/app/www/preview/slide_5_3.png" width="80%" />
<img src="./inst/app/www/preview/slide_5_4.png" width="80%" />

#### Slide 6: Bike Accidents with personal injury per Bike Infrastructure and Opponent

<img src="./inst/app/www/preview/slide_6_1.png" width="80%" />
<img src="./inst/app/www/preview/slide_6_2.png" width="80%" />
<img src="./inst/app/www/preview/slide_6_3.png" width="80%" />

#### Slide 7: Berlin Map of Bike Accidents with personal injury per Traffic Cell

<img src="./inst/app/www/preview/slide_7_1.png" width="80%" />
<img src="./inst/app/www/preview/slide_7_2.png" width="80%" />
<img src="./inst/app/www/preview/slide_7_3.png" width="80%" />

#### Slide 9: About the Project

<img src="./inst/app/www/preview/slide_9.png" width="80%" />
