#Final Project
##started 12/2/2021

#Downloaded csvs to the R "data" folder
library(tidyverse)
library(dplyr)
flights_df <- read_csv("data/nyc_13_flights_small.csv")
planes_df <- read_csv("data/nyc_13_planes.csv")
weather_df <- read_csv("data/nyc_13_weather.csv")

#Q1: joining dataframes and plotting precip v departure delay

flights_weather_df <- left_join(flights_df, weather_df, by = "time_hour")
flights_planes_weather_df <- left_join(flights_weather_df, planes_df, by = "tailnum")
flights_planes_weather_df %>% group_by(precip, dep_delay) %>% ggplot(aes(x = precip, y = dep_delay)) + 
  geom_point(aes(color = dep_delay)) +
  geom_smooth(method = "lm", se = FALSE) +
  theme_bw() +
  xlab("Precipitation (in)") + ylab("Departure Delay") +
  ggsave("figures/final_q1.png")

#Q2: date v departure delay

library(lubridate)

date_dep_delay_df <- flights_planes_weather_df %>% 
  mutate(yrmoda = ymd(paste(year.y, month.y, day.y, sep = '-'))) %>%
  filter(month.x >= 9) %>% 
  group_by(yrmoda, dep_delay) %>% 
  mutate (dep_delay = mean(dep_delay)) %>% 
  ggplot(aes(x = yrmoda, y = dep_delay)) +
  geom_point(aes(color = carrier)) +
  theme_bw() +
  xlab("Date") + ylab("Departure Delay") +
  ggsave("figures/final_q2.png")

#Q3: create a dataframe, columns: date (ymd), mean_temp; rows: airports by code

mean_temp_by_origin <- flights_planes_weather_df %>% 
  filter(!is.na(temp)) %>% 
  mutate(date = ymd(paste(year.y, month.y, day.y, sep = '-'))) %>% 
  mutate(mean_temp = mean(temp)) %>% 
  group_by(origin.y, date) %>% 
  select(origin.y, date, mean_temp)
write_csv(mean_temp_by_origin, 'data/mean_temp_by_origin_kgo.csv')

#Q4: Make a function that can: (1) convert hours to minutes; 
##and (2) convert minutes to hours (i.e., it’s going to require some sort of conditional setting 
##in the function that determines which direction the conversion is going). 
##Use this function to convert departure delay (currently in minutes) to hours 
##and then generate a boxplot of departure delay times by carrier. 
##Save this function into a script called “customFunctions.R” in your scripts/code folder.

hour_min <- function(x){
  hm <- x*60
  return(hm)
}

hour_min(5)

min_hour <- function(x){
  mh <- x/60
  return(mh)
}

min_hour(60)


#conversion_function <- function(x, unit){ifelse(unit == 'hour', hour_min(x), min_hour(x))}
#conversion_function(6, 'hour')
#conversion_function(60, 'minute')


dep_delay_carrier <- flights_planes_weather_df %>%
  mutate(dep_delay_min = min_hour(dep_delay)) %>% 
  select(dep_delay_min, carrier) %>% 
  ggplot(aes(x = carrier, y = dep_delay_min)) +
  geom_point(aes(color = dep_delay_min)) +
  geom_boxplot() +
  theme_bw() +
  xlab("Carrier") + ylab("Departure Delay (min)") +
  scale_y_log10() +
  ggsave("figures/final_q4.png")

#Q5:Below is the plot we generated from the new data in Q4. 
##(Base code: ggplot(df, aes(x = dep_delay_hrs, y = carrier, fill = carrier)) + geom_boxplot()). 
##The goal is to visualize delays by carrier. 
##Do (at least) 5 things to improve this plot by changing, adding, or subtracting to this plot. 
##The sky’s the limit here, remember we often reduce data to more succinctly communicate things.

final_plot <- flights_planes_weather_df %>% 
  ggplot(aes(x = dep_delay, y = carrier, fill = carrier)) +
  geom_boxplot() + 
  theme_classic() + #1
  xlab("Departure Delay (hr)") + ylab("Carrier") + #2
  scale_x_log10() + #3
  theme(legend.position = "none") + #4
  scale_fill_viridis_d(option = "C") + #5 for accessibility
  ggsave("figures/final_q5.png")

