

library(tidyverse)
library(sf)
library(readr) 
library(dplyr) 


london_sf <- read_sf("data/london_boroughs")

education_data <- read_csv("data/age-when-completed-education.csv")

london_school_leavers_sf <- london_sf %>% 
  left_join(education_data,
            by = c("lad11nm" = "area")) %>% 
  filter(age_group == "16 or under")
ggplot()+
  geom_sf(data= london_school_leavers_sf, aes(fill= value,
                                              shape=" City of London"),
          color= "white",
          size= 0.2)+
  scale_fill_viridis_c(labels= scales::number_format(big.mark = ","),
                       name= "School Leavers\n under 16",
                       na.value = "pink")+
  guides(shape=guide_legend(override.aes = list(fill="pink"),
                            title = NULL))+
  theme_void()

