
###################
#d3 pairs
#https://cran.r-project.org/web/packages/pairsD3/README.html
#parallel coordinates in d3
###################
library(dplyr)
library(tidyr)
library(ggmap)
df <- read.csv("CrimeData2.csv", nrows=2450) %>% select(State:Arson) %>% 
        mutate(State = tolower(State), city_state = paste(City, State, sep=","))
new_df <- data.frame(c())
for(index in 1:2450){
        new_df <- rbind(new_df,geocode(df$city_state[index]))
}
df$longitude <- new_df$lon
df$latitude <- new_df$lat
write.csv(df, 'df1.csv')



df2 <- read.csv("CrimeData2.csv", skip = 2490,nrows=2500, header = FALSE) 
names(df2) <- names(df)

df2_p <- df2 %>% select(State:Arson) %>% 
        mutate(State = tolower(State), city_state = paste(City, State, sep=","))
########################
########################
########################
df2 <- read.csv("CrimeData2.csv", skip = 4851,nrows=2400, header = FALSE) 
names(df2) <- c(names(df),"NA1","NA")
df2 <- df2 %>% select(State:Arson) %>% 
        mutate(State = tolower(State), city_state = paste(City, State, sep=","))
new_df <- data.frame(c())
for(index in 1:2400){
        new_df <- rbind(new_df,geocode(df2$city_state[index]))
}
df2$longitude <- new_df$lon
df2$latitude <- new_df$lat
write.csv(df2, "df_w_loc2.csv")

############################
############################
############################
#D3 visualization in R

require(pairsD3)
pairsD3(df[,4:8],group=df[,1])


function(string){
      location <- geocode(string)
      return(location)
}

