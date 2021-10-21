#1
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)
#2
filter(surveys, weight > 30, weight < 60) %>% print(n=6)
#3
biggest_critters <- select(surveys, species_id, sex, weight) %>% filter(!is.na(weight)) %>% filter(!is.na(sex)) %>% group_by(sex, species_id) %>% mutate(weight_max = max(weight))
biggest_critters
#already removed NAs?
arrange(biggest_critters, "weight_max")
#4
tally(biggest_critters)
#5
surveys_avg_weight <- filter(surveys, !is.na(weight)) %>% mutate(weight_avg = mean(weight)) %>% select(species_id, sex, weight, weight_avg)
surveys_avg_weight
#6
final_surveys <- surveys_avg_weight %>% mutate(above_average = ifelse(surveys_avg_weight$weight_avg > mean(weight), "above", "below"))