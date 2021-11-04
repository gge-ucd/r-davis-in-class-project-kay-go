#11/4/2021
library(tidyverse)

#1
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
gapminder_1 <- gapminder %>% group_by(continent, year) %>% summarize(lifeExpavg = mean(lifeExp)) %>% 
      ggplot() + geom_point(aes(x = year, y = lifeExpavg, color = continent))
gapminder_1

#2

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +  
  scale_x_log10() +
  theme_bw()

#geom smooth adds some sort of trend line
#scale_x_log10 log transforms the data to increase the resolution of each point.

#3

#had to peak here. definitely not an intuitive solution (to create a vector and then filter it into the dataframe), but really cool...
country_subset <- c("Brazil", "China", "El Salvador", "Niger", "United States")
gapminder %>% 
  filter(country %in% country_subset) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter(alpha = 0.3, color = "blue")+
  theme_minimal() +
  ggtitle("Life Expectancy of Five Countries") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Country") + ylab("Life Expectancy")

#looked into the %in% function, which appears to "match" functions; 
#can also be used to compare vectors e.g. vector_1 %in% vector_2 will produce True or False answers