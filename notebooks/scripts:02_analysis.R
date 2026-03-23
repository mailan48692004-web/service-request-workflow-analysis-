library(tidyverse)

service_requests_clean <- read_csv("service_requests_clean.csv")

# Summary statistics for completion time
completion_time_summary <- service_requests_clean %>%
  summarise(
    min_days = min(days_to_complete, na.rm = TRUE),
    median_days = median(days_to_complete, na.rm = TRUE),
    mean_days = mean(days_to_complete, na.rm = TRUE),
    p75_days = quantile(days_to_complete, 0.75, na.rm = TRUE),
    p90_days = quantile(days_to_complete, 0.90, na.rm = TRUE),
    p95_days = quantile(days_to_complete, 0.95, na.rm = TRUE),
    p99_days = quantile(days_to_complete, 0.99, na.rm = TRUE),
    max_days = max(days_to_complete, na.rm = TRUE)
  )

# Category-level KPIs
category_kpis <- service_requests_clean %>%
  group_by(category) %>%
  summarise(
    request_count = n(),
    median_days = median(days_to_complete, na.rm = TRUE),
    p90_days = quantile(days_to_complete, 0.90, na.rm = TRUE),
    p95_days = quantile(days_to_complete, 0.95, na.rm = TRUE)
  ) %>%
  arrange(desc(request_count))

# Review longest-running requests
top_longest_requests <- service_requests_clean %>%
  arrange(desc(days_to_complete)) %>%
  select(request_status, date_received, date_completed, suburb, category, service_desc, days_to_complete) %>%
  head(10)

# Long-running requests by completion date
long_running_requests_by_date <- service_requests_clean %>%
  filter(days_to_complete > 300) %>%
  count(date_completed)


