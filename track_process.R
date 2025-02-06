library(sf)
library(tidyverse)

layer_names <- st_layers("C:/Users/ljb38/Downloads/My Checklists - eBird.kml") %>% 
  as.data.frame() %>% 
  select(name) %>% 
  filter(!str_detect(name, "Points")) %>% 
  as.vector() %>% 
  unlist()

patch_tracks <- list()

for (i in 1:length(layer_names)) {
  patch_tracks[[i]] <- read_sf("C:/Users/ljb38/Downloads/My Checklists - eBird.kml", layer = layer_names[i])
  
  print(i)
}

patch_tracks_sf <- patch_tracks %>% 
  bind_rows %>% 
  mutate(checklist_id = layer_names)

write_sf(patch_tracks_sf, "GitHub/Patch-2024/data/raw/patch_tracks.gpkg")
