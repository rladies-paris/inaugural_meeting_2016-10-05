## READ IN DATA ####
source("scripts/inaugural_meeting_2016-10-05_cleaning.R")


## ORGANIZE DATA ####
data_responders_figs = data_responders

data_responses_figs = data_responses %>%
  # Make a column that repeats the number of responses to later get percentages
  mutate(num_responses = max(response_number)) %>%
  # Group by to get total number of times each topic requested
  group_by(possible_topics, num_responses) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  # Calculate percentage of people who wanted a given topic
  mutate(percentage = (count / num_responses) * 100) %>%
  # Arrange in descending order to see most desired topics
  arrange(desc(percentage))


## MAKE FIGURES ####
# Skill levels of responses
# [to do]

# Topic preferences
topic_pref.plot = ggplot(data_responses_figs, aes(x = reorder(possible_topics, -percentage),
                                y = percentage, fill = reorder(possible_topics, -percentage))) +
  geom_bar(stat = "identity") +
  ylim(0, 100) +
  xlab("Possible topics") +
  ylab("Percentage of people\nwho responded") +
  labs(fill = "") +
  guides(fill = guide_legend(ncol = 2)) +
  theme_classic() +
  theme(text = element_text(size = 16),
        axis.line.x = element_line(), axis.line.y = element_line(),
        axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        legend.position = "top")

pdf("figures/topic_pref.pdf")
topic_pref.plot
dev.off()







