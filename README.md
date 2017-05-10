---
title: "README"
author: Valerie Amoroso, Juan Pablo Oberhauser
date: "5/1/2017"
output: pdf_document
---

##Contributors:

Valerie Amoroso vlamoroso@usfca.edu
Pablo Oberhauser joberhauser@usfca.edu

**Packages Required**
The following packages must be installed before running this code:
- dplyr
- pairsD3
- leaflet
- shiny

**Dataset:**

Our dataset includes crime data for 9259 cities across the United States.  The variable included are State, City, Population, Violent Crime, Murder Manslaughter, Rape, Robbery, Aggravated Assault, Property crime, Burglary, Larceny theft, Motor Vehicle theft, Arson. We have pulled the latitude and longitude for each city in the data set to allow us to plot the crimes on a map. We also have a second set of crime data representing crime rates for each variable above across the US over a 20 year period. 



The static prototype is below. It consists of three screens. The main screen is a map visualizer that allows for bubble plot visualization over the map of the United States. There is a large menu on the side that also includes a bar plot of the distribution of the selected variable. the menu allows for filtering of states and to change the visualization from a raw number visualization to a per capita visualization. 
![alt text](https://github.com/usfviz/backyardigans-/blob/master/project-prototype/sc_3.png)



The second screen is a simple data explorer that simply allows for exploration of the raw data with filtering.
![alt text](https://github.com/usfviz/backyardigans-/blob/master/project-prototype/sc_2.png)


Finally there is a plot that explores the relationships between all of the numeric variables.


![alt text](https://github.com/usfviz/backyardigans-/blob/master/project-prototype/sc_1.png)

