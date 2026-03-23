## `scripts/01_data_cleaning.R`
library(tidyverse)
library(lubridate)

# Load raw dataset
service_requests <- read_csv("service_requests_raw.csv")

# Convert date fields
service_requests <- service_requests %>%
  mutate(
    date_received = ymd(date_received),
    date_completed = ymd(date_completed)
  )

# Check missing values
colSums(is.na(service_requests))

# Remove records with missing completion date
service_requests <- service_requests %>%
  filter(!is.na(date_completed))

# Check duplicate rows
sum(duplicated(service_requests))

# Validate completion time
service_requests <- service_requests %>%
  mutate(
    calc_days = as.numeric(date_completed - date_received),
    days_to_complete = calc_days
  )

# Remove negative completion times
service_requests_clean <- service_requests %>%
  filter(days_to_complete >= 0)
# Save clean data
write_csv(service_requests_clean, "service_requests_clean.csv")


