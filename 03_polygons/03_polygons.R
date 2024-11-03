# Import packages
library(tigris)
library(ggplot2)
library(dplyr)
library(sf)
library(viridis)
library(dplyr)
library(tigris)
library(ggtext)
library(RColorBrewer)
library(viridis)
library(showtext)
library(paletteer)
library(extrafont)
library(sf) 

# Load Google font
font_add_google("IBM Plex Mono", "ibm-plex-mono")
showtext_auto()

# Load county boundaries
us_counties <- counties(cb = TRUE, class = "sf")%>%
  filter(STATEFP != "02")

# Load Latine population data
latino_data <- read.csv("latino_population.csv", colClasses = c("GEOID" = "character"))

# Calculate Latine population density
latino_data <- latino_data %>%
  mutate(latino_density = (latino_pop / total_pop) * 100)  # Calculate percentage of Latino population

# Merge geographic and demographic data
latino_map <- us_counties %>%
  left_join(latino_data, by = "GEOID")

# Plot map
ggplot(data = latino_map) +
  
  geom_sf(aes(fill = latino_density), color = "white", size = 0.1) +
  
  scale_fill_gradient(low = "#ffe9c9", high = "#fc9403", na.value = "#ebe9e6", name = "Latine Population Density") +
  labs(title = "Latines in the United States",
       subtitle = "03 Polygons | BMZA | Data source: 2020 Census ACS") +
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50))+
  theme_minimal() +
  theme(
    plot.title = element_textbox_simple(
      family = "ibm-plex-mono", color = "#fc9403", face='bold', padding = margin(20, 10, 5, 10),  # Adjust padding
      margin = margin(b = 2), size=38),
    plot.subtitle = element_textbox_simple(
      family = "ibm-plex-mono", color="#fc9403",
      padding = margin(5, 10, 10, 10),
      margin = margin(t = 0, b=2),  # Avoid top margin to keep close to title
      size = 22
    ),
    
    legend.position = c(0.2, 0.1),  # Move legend to bottom left
    legend.text = element_text(color = "orange", size = 12),  # Change text color and size
    legend.title = element_text(color = "orange", size = 14),
    legend.direction = "horizontal",
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()
  )

# Save map
ggsave("/Users/isabellamendoza/Desktop/2024-Map-Challenge/03_polygons/03_polygons.png", bg="white")