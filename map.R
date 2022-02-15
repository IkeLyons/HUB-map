library(magrittr)
library(leaflet)
library(htmlwidgets)
library(readr)
geocoded_list <- read_csv("geocoded-list.csv")
data <- geocoded_list
getColor <- function(data) {
  sapply(data$followers, function(followers) {
    if(followers <= 1000) {
      "green"
    } else if(followers <= 10000) {
      "orange"
    } else {
      "red"
    } })
}

icons <- awesomeIcons(
  icon = 'ios-close',
  iconColor = 'black',
  library = 'ion',
  markerColor = getColor(data)
)

m <- leaflet(data = geocoded_list) %>% 
  addTiles() %>% 
  setView( lng = 2.349014, lat = 48.864716, zoom = 12 ) %>% 
  addAwesomeMarkers(label = ~name, popup = ~as.character(followers), icon=icons, group = "Follow Count") %>%
  addMarkers(clusterOptions = markerClusterOptions(), popup = ~as.character(followers), group = "Clusters") %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  addLayersControl(
    baseGroups = c("Follow Count", "Clusters"),
    options = layersControlOptions(collapsed = FALSE)
  )
m


saveWidget(m, file=paste0(getwd(), "/backgroundMapTile.html"))


