# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Load the FAERS dataset for 2019
faers_data <- read_csv("path_to_faers_2019.csv")

# Filter data for Tramal
tramal_data <- faers_data %>%
  filter(DRUGNAME == "TRAMAL")

# Count the occurrences of each adverse effect
tramal_effects <- tramal_data %>%
  count(PT, sort = TRUE)

# Get the top 10 adverse effects
top_10_tramal_effects <- tramal_effects %>%
  top_n(10, wt = n)

# Create a bar plot for the top 10 adverse effects
ggplot(top_10_tramal_effects, aes(x = reorder(PT, n), y = n)) +
  geom_bar(stat = "identity", fill = "blue") +
  coord_flip() +
  labs(title = "Top 10 Adverse Effects of Tramal in 2019",
       x = "Adverse Effect",
       y = "Number of Reports")
