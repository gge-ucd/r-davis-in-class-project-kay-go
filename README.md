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

#Class 10/21/2021


#command + shift + m creates pipe
#really wide or really long tables sometimes not visualized well by tbbls, can just use the review command

#Conditional Statements, e.g. is it larger or smaller than the mean value?
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
surveys %>% filter(!is.na(weight)) %>% mutate(weight_cat = case_when(weight > mean(weight) ~ "big", weight < mean(weight) ~ "small")) %>% select(weight, weight_cat) %>% tail()
#if(){this}else{thenthis}
# - represents "then"
#less clunky than ifelse when there are multiple layers

#Conditional Statements challenge
data(iris)
summary(iris$Petal.Length)
str(iris)
is.na(iris)
str(summary(iris$Petal.Length))

iris %>% mutate(petal.length_cat = case_when(Petal.Length < summary(iris$Petal.Length)[2] ~ "small", Petal.Length > summary(iris$Petal.Length)[2] & Petal.Length < summary(iris$Petal.Length)[5] ~ "medium", Petal.Length > summary(iris$Petal.Length)[5] ~ "large"))
#wooh! watch out for your caseUNDERSCOREwhen

#other way to do this?
iris %>% mutate(length_cat = ifelse(Peta.Length <- 1.6, "small", ifelse(Petal.Length) >= 5.1, "large", "medium"))
#if first statement is true, small, then go to nested. if nest is true, go to large and if still not true, go to medium.

#Using the iris data frame (this is built in to R), create a new variable that categorizes petal length into three groups:

    small (less than or equal to the 1st quartile)
    medium (between the 1st and 3rd quartiles)
    large (greater than or equal to the 3rd quartile)

Hint: Explore the iris data using summary(iris$Petal.Length), to see the petal length distribution. Then use your function of choice: ifelse() or case_when() to make a new variable named petal.length.cat based on the conditions listed above. Note that in the iris data frame there are no NAs, so we don’t have to deal with them here.

#Join function. Taking two dataframes and comparing them. #Columns in common, compares. Finds match? Performs function.

surveys <- read_csv("data/portal_data_joined.csv")
tail <- read_csv("data/tail_length.csv") 
intersect(colnames(surveys), colnames(tail))
#above function tells us what they have in common
df_joined <- left_join(surveys, tail, by = "record_id")
str(df_joined)

#pivoting!
temp_df <- surveys %>% group_by(year,plot_id) %>% tally()
pivot_wider(temp_df, names_from = 'year', values_from = 'n') 

#grab names_from... spreading out year column, filling out rows with n
#don't need to use id_cols because there's only one kept
#need to call a new dataframe

