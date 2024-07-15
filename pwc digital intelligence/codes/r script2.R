# Filter data for Lyrica
lyrica_data <- faers_data %>%
  filter(DRUGNAME == "LYRICA")

# Count the occurrences of each adverse effect for Lyrica
lyrica_effects <- lyrica_data %>%
  count(PT, sort = TRUE)

# Get the top 10 adverse effects for Lyrica
top_10_lyrica_effects <- lyrica_effects %>%
  top_n(10, wt = n)

# Create a bar plot for the top 10 adverse effects for Lyrica
ggplot(top_10_lyrica_effects, aes(x = reorder(PT, n), y = n)) +
  geom_bar(stat = "identity", fill = "red") +
  coord_flip() +
  labs(title = "Top 10 Adverse Effects of Lyrica in 2019",
       x = "Adverse Effect",
       y = "Number of Reports")

# Compare top adverse effects for both drugs
tramal_lyrica_comparison <- merge(top_10_tramal_effects, top_10_lyrica_effects, by = "PT", all = TRUE)
names(tramal_lyrica_comparison) <- c("Adverse_Effect", "Tramal_Count", "Lyrica_Count")
tramal_lyrica_comparison[is.na(tramal_lyrica_comparison)] <- 0
