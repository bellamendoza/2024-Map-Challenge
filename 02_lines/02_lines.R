# Load the necessary libraries
library(rnaturalearth)
library(ggplot2)
library(sf)
library(dplyr)

# Import Packages
library(tigris)
library(ggplot2)
library(ggtext)
library(RColorBrewer)
library(viridis)
library(showtext)
library(paletteer)
library(extrafont)
library(sf) 

# Load Google font
font_add_google("IBM Plex Mono", "ibm-plex-mono")
showtext_auto()  # Enable showtext


# Load US states shapefile
us_states <- tigris::states(cb = TRUE)

# Identify the unique states from Shakira's data (assuming there's a 'state' column)
shakira_states <- unique(shakira_data$state)  # Get unique visited states

# Create a new column in the us_states data frame to indicate visited states
us_states <- us_states %>%
  mutate(visited = ifelse(NAME %in% shakira_states, "Yes", "No"))

# Define colors for visited and non-visited states
color_mapping <- c("Yes" = "#ff0571", "No" = "#8f003e")

# Plot the U.S. map with points and connecting lines
ggplot(data = us_states) +
  geom_sf(aes(fill = visited), color = "#fff9ed", size = 0.3) +  # Fill based on visited status
  scale_fill_manual(values = color_mapping, name = "Visited", labels = c("No", "Yes")) +  # Color states
  geom_sf(data = points_sf, aes(fill = name), shape = 21, color = "black", fill="#fc9003",  size = 2, stroke = 0.5) +  # Adjusted points
  geom_sf(data = line_sf, color = "#fc9003", size = 1) +  # Thicker line for visibility
  
  # Label each point with dynamic repulsion and correct ordering
  geom_label_repel(data = points_sf, aes(x = st_coordinates(geometry)[, 1],
                                         y = st_coordinates(geometry)[, 2],
                                         label = index), 
                   fill = "#fff9ed", color = "black", size = 8, max.overlaps = 12, segment.color = "#fc9003") + 
  
  coord_sf(xlim = c(-125, -65), ylim = c(25, 50), label_axes = "----", label_graticule = "----") +  # Updated settings
  labs(title = "Shakira's Las Mujeres Ya No Lloran Tour", subtitle = "02 Lines | BMZA | Data source: Ticketmaster", fill = "Fruit Type") +
  theme_minimal() +
  theme(
    plot.title = element_textbox_simple(
      family = "ibm-plex-mono", color = "#8f003e", face='bold', padding = margin(20, 10, 5, 10),  # Adjust padding
      margin = margin(b = 2), size=46),
    plot.subtitle = element_textbox_simple(
      family = "ibm-plex-mono", color="#8f003e",
      padding = margin(5, 10, 10, 10),  # Adjust padding to match title
      margin = margin(t = 0, b=2),  # Avoid top margin to keep close to title
      size = 22
    ),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_blank(),  # Remove axis labels
    axis.ticks = element_blank(),  # Remove axis ticks
    plot.background = element_rect(fill = "#fff9ed", color = "#fff9ed"),
    # Legend element
    legend.background = element_rect(fill = "black", color = "black"),
    legend.title = element_text(color = "#fff9ed", face = "bold", size = 16, family = "ibm-plex-mono"),
    legend.text = element_text(size = 14, family = "ibm-plex-mono", color = "#fff9ed"),
    legend.position = c(.85, .25),
    panel.border = element_blank(),
    legend.key.size = unit(0.3, "cm"),
    legend.spacing.y = unit(0.54, "cm")
  )

# Save the plot
ggsave("/Users/isabellamendoza/Desktop/2024-Map-Challenge/02_lines/shakira_tour.png")


