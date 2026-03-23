library(tidyverse)
library(ggplot2)

service_requests_clean <- read_csv("service_requests_clean.csv")

# Plot 1: completion time distribution
completion_time_plot <- ggplot(service_requests_clean, aes(days_to_complete + 1)) +
  geom_histogram(bins = 50, fill = "steelblue", color = "white") +
  scale_x_log10() +
  labs(
    title = "Distribution of Service Request Completion Times",
    x = "Completion Time (days, log scale)",
    y = "Number of Requests"
  )
completion_time_plot
# Plot 2: completion time by category
completion_time_by_category_plot <- ggplot(service_requests_clean, aes(category, days_to_complete + 1)) +
  geom_boxplot(fill = "lightblue") +
  scale_y_log10() +
  coord_flip() +
  labs(
    title = "Completion Time by Service Category",
    x = "Service Category",
    y = "Completion Time (days, log scale)"
  )
completion_time_by_category_plot
# Plot 3: request volume by category
request_volume_plot <- service_requests_clean %>%
  count(category) %>%
  ggplot(aes(reorder(category, n), n)) +
  geom_col(fill = "darkgreen") +
  coord_flip() +
  labs(
    title = "Service Request Volume by Category",
    x = "Service Category",
    y = "Number of Requests"
  )
request_volume_plot