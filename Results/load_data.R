library(mongolite)
library(tidyverse)
library(dplyr)
library(irr)
library(jsonlite)
library(ggpubr)
library(stringi)
library(qdap)
library(cld2)
library(plyr)
library(e1071)
library("xlsx")
library(PMCMRplus)

#import MongoDB collection into R
db <- mongo(
  collection = "final1",
  db = "analysis",
  url = "mongodb://localhost:27017/",
  verbose = FALSE,
  options = ssl_options()
)

#count observations
db$count()

# put environment into proper dataset - makes it easy to get an overview of nested table
df <- db$find('{}')

#take a quick look into the dataset
#glimpse(df)

# Flatten table
datacomplete <- df %>% flatten()


#Remove noise
datacomplete1<-datacomplete[!(datacomplete$finalannotationcontentcategory=="Noise"),]


# select only important columns from full dataset and save into a new data frame
# my_data <- as_tibble(datacomplete)
final_data <- datacomplete1 %>% select(retweet_count, favorite_count, app_name, country_code, country, content_category = finalannotationcontentcategory, sentiment = finalannotationsentiment, gender = finalannotationgender, created_at, text = full_text, replies)

#final_data