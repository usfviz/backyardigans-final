
package_check <- require("dplyr")
if (package_check == FALSE) {
        install.packages('dplyr')
}
library("dplyr")

package_check <- require("pairsD3")
if (package_check == FALSE) {
        install.packages('pairsD3')
}

package_check <- require("dygraphs")
if (package_check == FALSE) {
        install.packages('dygraphs')
}
package_check <- require("leaflet")
if (package_check == FALSE) {
        install.packages('leaflet')
}


package_check <- require("shiny")
if (package_check == FALSE) {
        install.packages('shiny')
}


package_check <- require("tidyr")
if (package_check == FALSE) {
        install.packages('tidyr')
}

package_check <- require("RColorBrewer")
if (package_check == FALSE) {
        install.packages('RColorBrewer')
}

library(RColorBrewer)
library(ggplot2)
library(shiny)
library(leaflet)
require(leaflet)
library(dplyr)
library(tidyr)
library(pairsD3)
library(dygraphs)

df_v <- read.csv('CrimeData2.csv', stringsAsFactors = FALSE) %>% dplyr::select(-c(X, X.1, X.2))
indx <- c(FALSE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE)
df_v[indx] <- lapply(df_v[indx], function(x) as.integer(gsub(",", "", x)))
df_v[is.na(df_v)] <- 0
states <-  as.character(unique(df_v$State))
cities <- as.character(unique(df_v$City))
df_o <- read.csv("pablo_temp.csv",colClasses=c("NULL",rep(NA,16)))


df_20 <- read.csv("20_Year_Crime.csv", stringsAsFactors = FALSE)
indx2 <- c(FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE)
df_20[indx2] <- lapply(df_20[indx2], function(x) as.integer(gsub(",", "", x)))
df_20[is.na(df_20)] <- 0


get_rate <- function(x){
        (x/df_o$Population) * 1000
}

df <- df_o %>% dplyr::mutate_each(funs(get_rate(.)),-Population, -State,-City,-latitude, -longitude,-city_state)
        
library(dplyr) # >= 0.4.3.9000
iris %>% mutate_each(funs(mysum = sum(.)), -Species) %>% head()

summary_stats <- function(df_state){
        cnames <- colnames(df_v)
        population<-summary(df_state[,3])
        violent_crime <- summary(df_state[,4])
        murder_manslaughter <- summary(df_state[,5])
        rape <- summary(df_state[,6])
        robbery <- summary(df_state[,7])
        aggravated_assult <- summary(df_state[,8])
        property_crime <- summary(df_state[,9])
        burglary <- summary(df_state[,10])
        larcency_theft <- summary(df_state[,11])
        motor_vehicle_theft <- summary(df_state[,12])
        arson <- summary(df_state[,13])
        summary_table <- cbind(population, violent_crime, murder_manslaughter, rape, robbery,
                               aggravated_assult, property_crime, burglary, larcency_theft, 
                               motor_vehicle_theft, arson)
        
        return(summary_table)
}
