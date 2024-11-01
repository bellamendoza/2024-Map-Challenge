# Import packages
library(tigris)
library(ggplot2)
library(ggtext)
library(RColorBrewer)
library(viridis)
library(showtext)
library(paletteer)
library(extrafont)

# Plot map
ggplot() +
  xlim(-122.309, -122.209) +
  ylim(37.82, 37.91) +
  geom_sf(data = alameda_county, fill = "#173863", color = "#4cbced") +
  geom_sf(data = alameda_streets, color = "#4cbced", size = 0.1) +
  geom_sf(data = points_sf, aes(fill = Fruit.Type), shape = 22, color = "black", size = 3.5, stroke = 0.5) +
  labs(title = "Fruit Trees in <br>Berkeley, CA", subtitle = "01 Points | BMZA | Data source: Forage Berkeley", fill = "Fruit Type") +
  
  theme_minimal() +
  scale_fill_manual(values = c("#ff867d", "#ffc77d", "#ffeb0d", "#c6ff0d", "#51a614", "#ff7af6", "#ffb8fa", "#ff3849")) +
  guides(fill = guide_legend(override.aes = list(size = 3))) +
  theme(
    legend.position = c(.98, .71),
    legend.justification = c("right", "bottom"),
    
    # Title element
    plot.title = element_textbox_simple(
      family = "ibm-plex-mono", fill = "#173863", color = "#70d4ff",
      padding = margin(32, 10, 5, 10),  # Adjust padding
      margin = margin(b = 5),  # Remove extra space between title and subtitle
      size = 70, face = "bold",
      lineheight = 0.5
    ),
    
    # Subtitle elemen
    plot.subtitle = element_textbox_simple(
      family = "ibm-plex-mono", fill = "#173863", color = "#70d4ff",
      padding = margin(5, 10, 10, 10),  # Adjust padding to match title
      margin = margin(t = 0),  # Avoid top margin to keep close to title
      size = 30
    ),
    
    # Legend element
    legend.background = element_rect(fill = "#173863", color = "#173863"),
    legend.title = element_text(color = "#70d4ff", face = "bold", size = 34, family = "ibm-plex-mono"),
    legend.text = element_text(size = 30, family = "ibm-plex-mono", color = "#70d4ff"),
    panel.border = element_blank(),
    legend.key.size = unit(0.43, "cm"),
    legend.spacing.y = unit(0.54, "cm"),
    legend.margin = margin(10, 10, 10, 10),
    
    # Remove axis lines, labels, and ticks
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

# Save the plot
ggsave("berkeley_fruit_map.png", width = 6.3, height = 8.7, dpi = 300, bg = "#173863")
