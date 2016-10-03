## LOAD PACKAGES ####
library(tidyverse)


## READ IN DATA ####
data = read.table("data/data.txt", header=T, sep="\t") # data is as of 4:52 on Oct. 3, 2016


## CLEAN DATA ####
# Clean up data
data_clean = data %>%
  # Rename crazy column names
  rename(r_level = What.is.your.level.in.R.) %>%
  rename(possible_topics = What.would.you.like.to.to.see.at.R.Ladies.Paris.) %>%
  # Add a counter for person who gave response
  mutate(response_number = row_number()) %>%
  # Remove extra undesired comma in responses
  mutate(possible_topics = gsub("Markdown, Shiny", "Markdown Shiny", possible_topics))

# Make df with one row per responder (same as data_clean)
data_responders = data_clean

# Make df that expands topics column
data_responses = data_clean %>%
  # Make column values into lists
  mutate(possible_topics = strsplit(as.character(possible_topics), ", ")) %>% 
  # Unnest list to create separate rows for each response
  unnest(possible_topics)





