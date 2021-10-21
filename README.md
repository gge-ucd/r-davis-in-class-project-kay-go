Kay Garlick-Ott
she/her
Behavioral ecology and conservation

dir.create("scripts")
getwd()
letters

#creating a vector and then calling vector number 2
eg_vector <- c(1, 5, 8)
eg_vector
eg_vector[c(2)]
#adding a number
eg_vector = c(eg_vector, 18)
eg_vector

#reverse
eg_vector[c(4,3,2,1)]

#create a vector with a set of arbitrary strings

my_string <- "cat"
my_string <- c("cat", "dog", "horse", "parrot")
my_string

#what kind of string is this?
class(my_string)

#dataframe - special kind of object in R
#calling help on what is a dataframe
?data.frame()
data.frame(my_string)
#combine them
data.frame(c(my_string, my_string))
#put them in two columns?
data.frame(first_column = my_string, second_column = my_string)
data.frame(first_column = c(my_string, 'pig'), second_column = c(my_string, 'gull'))

#make a list
?list()
test.list <- list('first string entry into list')
str(test.list)

#it's a list, with the first item in the list being "first string enetry into list"

(testy.list <- list('dog', 'cat', 'horse', 'parrot', 'pig'))
testy.list[[1]][2] <- 'malamute'
testy.list

#[[]] are header numbers, [] fall within that

#adding a data frame to a list
data.fr <- data.frame(c('hello', 'hello'))
testy.list[[1]][3] <- data.fr
testy.list

10/7/2021

# Challenges with subsetting

surveys_200 <- surveys[200,]
surveys_200

# duplicate head
surveyshead <- surveys[-(7:nrow(surveys)),]
surveyshead

#loading tidyverse (how to)
#install.packages("tidyverse")
#library(tidyverse)

# %>% allows you to group functions at once, sends results from one line to the next.


#NOTES 10/14/2021

#1. keep only observations before 1995
surveys <- read_csv("data/portal_data_joined.csv")
surveys_base <- filter(surveys,year < 1995)
#don't even need to add the $ because it knows where year is already!
#2. keep year, sex, weight
surveys_base <- select(surveys_base,year,sex,weight)
str(surveys_base)
#3. Try going from 1 to 2 without the intermediate step?
surveys_base <- select(filter(surveys,year<1995),year,sex,weight)
str(surveys_base)
#can also pipe: surveys_base <- filter(surveys, year<1995) %>% select(year,sex,weight)
#can also pipe: surveys_base <- surveys %>% filter(year<1995) %>% select(year,sex,weight)
#can also nest: surveys_base <- filter(select(surveys,year,sex,weight),year<1995)
#4. Mutate function! Tidyverse's way of making a new column or changing the values of an existing column. Next task: Create a new data frame from the surveys data that meets the following criteria: (a) contains only the species_id column (b) and a new column called hindfoot_half containing values that are half the hindfoot_length values. (c) In this hindfoot_half column, there are no NAs and all values are less than 30. Name this data frame surveys_hindfoot_half.
surveys <- read_csv("data/portal_data_joined.csv")
surveys
surveys_hindfoot_half <- surveys %>% filter(!is.na(hindfoot_length)) %>% mutate(hindfoot_half = hindfoot_length/2) %>% select(species_id, hindfoot_half) %>% filter(hindfoot_half < 30) %>% head()
surveys_hindfoot_half
#note the language tidyverse uses to do each of these steps; to visualize piping, can add in a ., before each stage.
#groupby and summarize, dataframes have subgroups
#Use group_by() and summarize() to find the mean, min, and max hindfoot length
#for each species (using species_id).
surveys
#hindfoot_metrics <- surveys %>% group_by(species_id) %>% summarize(max_hindfoot = max(hindfoot_length, na.rm = TRUE)) %>% summarize(min_hindfoot = min(hindfoot_length, na.rm = TRUE)) %>% summarize(mean_hindfoot = mean(hindfoot_length, na.rm = TRUE))
hindfoot_metrics
#can't run the above because piping eliminates groups of numbers that you'd want to be using for the next pipe. be cognizant of the numbers you're putting into the next dataframe.
#elegant way of doing this:
surveys_hindfoot_half %>% group_by(species_id) %>%
  mutate(hindfoot_length = hindfoot_half * 2) %>%
  summarize(avg_length = mean(hindfoot_length),min(hindfoot_length),max(hindfoot_length)) %>%
  head()
#mutate.if function will allow you to mutate if numeric, etc.

#Notes from Week 5 videos



