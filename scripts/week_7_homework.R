#11/11/2021

git --version

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")
gapminder_new <- gapminder %>% filter(year %in% c(2002, 2007)) %>% pivot_wider(id_cols = c(country, continent), names_from = year, values_from = pop) %>% 
  mutate(popDiff = `2007`-`2002`) %>% 
  filter(continent!= 'Oceania') %>% ggplot()

gapminder_bw <- gapminder_new + facet_wrap(~continent, scales = 'free') + 
  geom_bar(aes(x = reorder(country,popDiff),y = popDiff),stat = 'identity') + theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = 'Country', y = 'Change in population between 2002 to 2007') + scale_fill_viridis_d()


#when using column names that are numbers, have to put single quotes around them; use the ` on the same key as the ~.
#when using !=, these symbols need to be right next to each other.

#I'm not sure why scale_fill_viridis_d() isn't producing different colors?
