library(readxl)
library(dplyr)
library(data.table)
library(tidyverse)


# set wd
setwd("C:/Users/patrick.herget/OneDrive - Autovista Group Ltd/Desktop/Data Science/Data Detective Course/Week 1")


# load data
projects <- read.csv("projects.csv")
outcomes <- read.csv("outcomes.csv")

# check data types

str(projects)

# variable transformation

projects$school_ncesid <- as.factor(projects$school_ncesid)
projects$school_zip <- as.factor(projects$school_zip)
projects$date_posted <- as.Date(projects$date_posted,"%Y-%m-%d")


# How many projects are in the data? 
n_distinct(projects$projectid) # 664098

# How many teachers are in the data?
n_distinct(projects$teacher_acctid) #249555

# How many school are in the data? 
n_distinct(projects$schoolid) #57004

# How many different resources are required?
n_distinct(projects$resource_type) #7

# How many years of data do we have? 
as.numeric(round((max(projects$date_posted) - min(projects$date_posted))/365,0)) # 12 years


# How has total fundinf developed over time and how has the optional support changed over time?
projects$Year_posted <- format(projects$date_posted, format="%Y")

Total_Price_Development <- projects %>% 
  group_by(Year_posted) %>%
  summarise(`Total Price Excl Opt. Support` = median(total_price_excluding_optional_support),
            `Total Price Incl Opt. Support` = median(total_price_including_optional_support)) %>%
  mutate(`Optional Support` =`Total Price Incl Opt. Support` - `Total Price Excl Opt. Support`)
            
                                                        
# How many different cities, states, districts, counties are in the data set?

n_distinct(projects$school_city) #9007
n_distinct(projects$school_state) #52 
n_distinct(projects$school_district) #9247
n_distinct(projects$school_county) #1703

# What subjects do we have in the data set? 

unique(projects$primary_focus_subject)



