## READ IN DATA #### --> uncomment below if not running compilation script
# source("scripts/inaugural_meeting_2016-10-05_cleaning.R")


## LOAD PACKAGES ####
# [none currently needed]

## ORGANIZE DATA ####
data_responders_figs = data_responders

data_responses_figs = data_responses %>%
  # Make a column that repeats the number of responses to later get percentages
  mutate(num_responses = max(response_number)) %>%
  # Remove parenthetical information so easier to read on plot
  mutate(possible_topics = gsub(" \\(.*\\)", "", possible_topics)) %>%
  # Group by to get total number of times each topic requested
  group_by(possible_topics, num_responses) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  # Calculate percentage of people who wanted a given topic
  mutate(percentage = (count / num_responses) * 100) %>%
  # Arrange in descending order to see most desired topics
  arrange(desc(percentage))


## MAKE FIGURES ####
# Topic preferences
topic_pref.plot = ggplot(data_responses_figs, aes(x = reorder(possible_topics, -percentage),
                                y = percentage, fill = reorder(possible_topics, -percentage))) +
  # Make barplot
  geom_bar(stat = "identity") +
  # Extend axis from 0 to 100
  ylim(0, 100) +
  # Change colors to colorbrewer
  scale_fill_brewer(palette = "Set2") +
  # Add x-axis label
  xlab("Possible topics") +
  # Add y-axis label
  ylab("Percentage of people\nwho responded") +
  # Remove legend title
  labs(fill = "") +
  # Change number of legend columns
  guides(fill = guide_legend(ncol = 2)) +
  # Use classic theme
  theme_classic() +
  # Add other changes, text size, axis lines, legend position
  theme(text = element_text(size = 16),
        axis.line.x = element_line(), axis.line.y = element_line(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        legend.position = "top")

pdf("figures/topic_pref.pdf")
topic_pref.plot
dev.off()







