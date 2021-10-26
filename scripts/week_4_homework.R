#1
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
#reading in dot leaves blanks in this particular data set, so be careful about which one to use.
str(surveys)
#2
filter(surveys, weight > 30, weight < 60) %>% print(n=6)
#3
#when to use group_by, when to use summarize?
#biggest_critters <- select(surveys, species_id, sex, weight) %>% filter(!is.na(weight)) %>% filter(!is.na(sex)) %>% group_by(sex, species_id) %>% mutate(weight_max = max(weight))
#for the !is.na command, can do filter(!is.na(weight) & !is.na(sex) & !is.na(species)), as in, can use "&"s to extend the phrase.
#run this into summarize(), rather than use mutate, use summarize
#oops, should've used species not species_id
biggest_critters <- select(surveys, species, sex, weight) %>% filter(!is.na(weight)) %>% filter(!is.na(sex)) %>% group_by(sex, species) %>%  summarize(maximum_weight = max(weight))
biggest_critters
#already removed NAs?
arrange(biggest_critters, "weight_max")
#4
#not just filtering out NAs, inspecting data frame to see where they are
surveys %>% filter(is.na(hindfoot_length)) %>% group_by(species) %>% tally()
#n is a count, will take the previous group_by and count them
#can make summary table by doing #summarize(n(), mean(weight, na.rm = T)), whereas tally() is a sort of deadend.
#get all of the NAs in hindfoot, count them
tally(biggest_critters)
#5
surveys_avg_weight <- filter(surveys, !is.na(weight)) %>% mutate(weight_avg = mean(weight)) %>% select(species, sex, weight, weight_avg)
surveys_avg_weight
#6
final_surveys <- surveys_avg_weight %>% mutate(above_average = ifelse(surveys_avg_weight$weight_avg > mean(weight), "above", "below"))
