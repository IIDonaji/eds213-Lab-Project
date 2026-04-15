# --- Exploring & Cleaning data ---
# --- Analytical question:---

# Which sites have the highest total invertebrate biomass, and does that correspond to higher shorebird abundance?

# --- Load Library's ---
library(tidyverse)
library(here)

# --- Load raw data ---
invert <- read_csv(here("data","raw","invertebrates.csv"))
shorebird <- read_csv(here("data","raw","shorebirds.csv"))


# ---  Exploration before cleaning ---
glimpse(invert)
glimpse(shorebird)

# Checking columns can be matched
colnames(invert)
colnames(shorebird)

# Missing values
colSums(is.na(invert))
colSums(is.na(shorebird))

# Unique sites - do they match across tables?
unique(invert$site)
unique(shorebird$site)
setdiff(invert$site, shorebird$site) # in invert but not shorebird
setdiff(shorebird$site, invert$site) # in shorebird but not invert

# Duplicates
invert |>
  janitor::get_dupes(site, transect, genus_species)

# Numeric column sanity check
summary(invert$abundance)
summary(invert$biomass)

# What does survey look like?
head(shorebird$survey)
unique(shorebird$survey)

# Any zero masquerading as absences?
table(is.na(shorebird$sanderling)) # spot check one species

# --- Clean Invertebrates ---
# Fix site name mismatch — standardize to the shorter version
invert_clean <- invert |>
  mutate(
    site = str_replace(site, "Santa Claus ", "Santa Claus Lane"),
    abundance = as.integer(abundance),
    biomass   = as.numeric(biomass)
  ) |>
  distinct()

# --- Shorebirds ---
shorebird_clean <- shorebird |>
  pivot_longer(cols = -c(site, survey), names_to = "species", values_to = "count")


# --- Sites lookup ---
sites <- tibble(
  site = sort(unique(c(invert_clean$site, shorebird_clean$site)))
)

# # Convert clean data to csv
write_csv(invert_clean, file.path(here("data", "processed", "invertebrates_clean.csv")))
write_csv(shorebird_clean, file.path(here("data", "processed", "shorebirds_clean.csv")))
