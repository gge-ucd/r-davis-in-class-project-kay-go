#10/26/2021

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
#ASSIGNMENT PART 1
#Column for genus and column named after every plot type
#Each plot type column contains the mean hindfoot length of animals in that plot type and genus
#Every row has a genus and then mean hindfoot length value for every plot type
#Sorted by values in the Control plot type column

summary(surveys)
unique(surveys$plot_type)

#keep columns genus, hindfoot length, plot type
#mutate column hindfoot_length to represent averages
#group by genus
surveys_1 <- select(surveys, genus, hindfoot_length, plot_type) %>% 
    filter(!is.na(genus)) %>% filter(!is.na(plot_type)) %>% filter(!is.na(hindfoot_length)) %>% 
    group_by(genus, plot_type) %>% summarize(hindfoot_length_avg = mean(hindfoot_length))
surveys_1
#pivot so that each column is a plot type, values represent mean hindfoot length and genus are the rows
surveys_wide <- surveys_1 %>% pivot_wider(names_from = "plot_type", values_from = "hindfoot_length_avg")
surveys_wide
#arrange so descending by control
surveys_final <- arrange(surveys_wide, desc(Control))
surveys_final

#ASSIGNMENT PART 2
#Using the original, calculate a new weight category variable called weight_cat
#Define rodent weight into three categories, where small
#is less than or equal to the 1st quartile of weight distribution, 
#"medium is between but not inclusive the 1st and third quartile
#and large is any weight greater than or equal to the 3rd quartile. 
#Compare what happens to the weight values of NA depending on how you specify your arguments

library(tidyverse)
surveys
summary(surveys$weight)

#softcoding for weight classes similar to challenge problem last week
surveys_2 <- surveys %>% filter(!is.na(weight)) %>% mutate(weight_cat = case_when(weight <= summary(surveys$weight)[2] ~ "small", weight > summary(surveys$weight)[2] & weight < summary(surveys$weight)[5] ~ "medium", weight >= summary(surveys$weight)[5] ~ "large"))
surveys_2
