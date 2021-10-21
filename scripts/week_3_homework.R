#install.packages("tidyverse")
#import dataframe
surveys <- read.csv("data/portal_data_joined.csv")
#inspect dataframe
colnames(surveys)
head(surveys)
#rows 1 through 60, columns 6, 9 and 13, which correspond with species_id, weight, and plot_type
surveys_base <- surveys[1:60,c(6,9,13)]
str(surveys_base)
class("species_id")
class("plot_type")
?factor
species_id_fac <- factor(surveys_base$species_id)
is.factor(species_id_fac)
plot_type_fac <- factor(surveys_base$plot_type)
is.factor(plot_type_fac)
#factors are numbers and they have an order... still trying to figure out what they mean
#helps to think of the factor process as giving characters numerical values for the purpose of ordering them
#like if all of your values in an Excel column were jumbled up. This would be a way that you could assign numbers to each character and then order them however you want (using further functions)
surveys_base <- surveys_base[complete.cases(surveys_base),]
#10/14/2021: the above function goes row by row
#could have done this? surveys_base_nonas <- na.omit(surveys_base) - no, because you need to specify rows where NA are in it
#could have done this? surveys_base_nonas <- na.omit(surveys_base$weight) - no, because you input a vector and system doesn't know it's part of a dataframe. The output is a vector. (Will output what you put in)
#what about removing NAs via !is.na(surveys_base$weight) then using pipe function to pipe it into main function.
#surveys_base %>% !is.na(surveys_base$weight) - yes! piping puts the vector back into the whole dataframe. This would be equivalent to doing surveys_base[!is.na(surveys_base$weight),] - this ), means give me back all of the columns

surveys_base
#had to peek on this last step here (above), because initially I tried to do na.omit, as I did on last week's homework.
#my understanding is that na.omit removes nas across an entire dataframe (and creates a new one without?) whereas complete.cases goes row by row
#how come I don't have to specify the column in the above function complete.cases(surveys_base),?
challenge_base <- surveys_base[(surveys_base[,2]>150),]
challenge_base
#still not sure I understand why the comma matters


