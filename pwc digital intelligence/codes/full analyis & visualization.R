# Load necessary libraries
library(dplyr)
library(ggplot2)
library(readr)

# Load the FAERS dataset for 2019
faers_data <- read_csv("path_to_faers_2019.csv")

# Step 1: Tramal Analysis
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
ggsave("tramal_adverse_effects.png")

# Step 2: Lyrica Analysis
# Filter data for Lyrica
lyrica_data <- faers_data %>%
  filter(DRUGNAME == "LYRICA")

# Count the occurrences of each adverse effect
lyrica_effects <- lyrica_data %>%
  count(PT, sort = TRUE)

# Get the top 10 adverse effects
top_10_lyrica_effects <- lyrica_effects %>%
  top_n(10, wt = n)

# Create a bar plot for the top 10 adverse effects
ggplot(top_10_lyrica_effects, aes(x = reorder(PT, n), y = n)) +
  geom_bar(stat = "identity", fill = "red") +
  coord_flip() +
  labs(title = "Top 10 Adverse Effects of Lyrica in 2019",
       x = "Adverse Effect",
       y = "Number of Reports")
ggsave("lyrica_adverse_effects.png")

# Compare top adverse effects for both drugs
tramal_lyrica_comparison <- merge(top_10_tramal_effects, top_10_lyrica_effects, by = "PT", all = TRUE)
names(tramal_lyrica_comparison) <- c("Adverse_Effect", "Tramal_Count", "Lyrica_Count")
tramal_lyrica_comparison[is.na(tramal_lyrica_comparison)] <- 0

# Create a comparison plot
ggplot(tramal_lyrica_comparison, aes(x = reorder(Adverse_Effect, Tramal_Count), y = Tramal_Count, fill = "Tramal")) +
  geom_bar(stat = "identity") +
  geom_bar(aes(y = Lyrica_Count, fill = "Lyrica"), position = "dodge") +
  coord_flip() +
  labs(title = "Comparison of Adverse Effects: Tramal vs Lyrica",
       x = "Adverse Effect",
       y = "Number of Reports",
       fill = "Drug")
ggsave("comparison_adverse_effects.png")
