library(magrittr)
library(leaflet)
library(htmlwidgets)
library(readr)
geocoded_list <- read_csv("geocoded-list.csv")

m <- leaflet(data = geocoded_list) %>% 
  addTiles() %>% 
  setView( lng = 2.349014, lat = 48.864716, zoom = 12 ) %>% 
  addMarkers(label = ~name, clusterOptions = markerClusterOptions()) %>%
  addProviderTiles(providers$CartoDB.Positron)
m


saveWidget(m, file=paste0( getwd(),width="1000px", "/backgroundMapTile.html"))


