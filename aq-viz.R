# Looking at air quality readings 
# Jeff Oliver
# jcoliver@arizona.edu
# 2023-03-19

library(dplyr)
library(ggplot2)
library(lubridate)

airq <- read.csv(file = "data/airquality-2018-2023.csv")

# Make time stamp easier to deal with
airq$time_stamp <- gsub(pattern = "T",
                        replacement = " ",
                        x = airq$time_stamp)
airq$time_stamp <- gsub(pattern = "Z",
                        replacement = "",
                        x = airq$time_stamp)

airq$date_time <- as.POSIXct(airq$time_stamp,
                                  tz = "MST",
                                  format = "%Y-%m-%d %H:%M:%S")
# head(airq)
airq$year <- lubridate::year(airq$date_time)

ggplot(data = airq, mapping = aes(x = date_time,
                                  y = `pm2.5_alt`)) +
  geom_line() + 
  facet_wrap(~ year, scales = "free_x", ncol = 1)

# Find 10 highest peaks
airq %>% 
  arrange(desc(pm2.5_alt)) %>%
  slice_head(n = 10) %>%
  select(time_stamp, pm2.5_alt)
