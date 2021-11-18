library(tidyverse)
library(lubridate)
library(dplyr)
mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
head(mloa)

mloa1 <- mloa %>% filter(rel_humid!=-99, temp_C_2m!=-999.9, windSpeed_m_s!=-99.9) %>% 
  mutate(datetime = ymd_hm(paste(year,month,day, hour24, min, sep = '-'))) %>% 
  mutate(datetimeLocal = with_tz(datetime, tzone = "Pacific/Honolulu"))

mloa2 <- mloa1 %>% mutate(localmonth = month(datetimeLocal), localhour = hour(datetimeLocal)) %>% 
  group_by(localmonth, localhour) %>% summarize(meantemp = mean(temp_C_2m)) %>% 
  ggplot(aes(x = localmonth, y = meantemp)) + geom_point(aes(color = localhour)) + 
  scale_color_viridis_c() + theme_classic() + xlab("Month") + ylab("Mean temperature (degrees C)")

mloa2

#?with_tz()
#?month()
  
#what is paste? mloa_sub %>% mutate(datetime = ymd(paste(year,month,day,sep = '-'))) %>% select(datetime); 
  #combines and you can indicate that you want '-' separating or "sep"
  #add in hour by adjusting ymd_h, add in minute by making it ymd_hm
                