# setup ----
library(tidyverse)
options(scipen = 999)

# load data ----
library(readxl)
strauss <- read_xlsx(path = "1_data/Strauss.xlsx", sheet = "2010")
tara <- read_xlsx(path = "1_data/Tara.xlsx", sheet = "2010")
tnuva <- read_xlsx(path = "1_data/Tnuva.xlsx", sheet = "2010")

# rename to english
names(strauss) <- c("date", "cat", "q_k", "revenue", "vc", "fc")
names(tara) <- c("date", "cat", "q_k", "revenue", "vc", "fc")
names(tnuva) <- c("date", "cat", "q_k", "revenue", "vc", "fc")

# fix dates
strauss$date <- parse_date(strauss$date, format = "%.%m%.%Y")
tara$date <- parse_date(tara$date, format = "%Y-%m-%d")
tnuva$date <- parse_date(tnuva$date, format = "%.%m%.%Y")

# bind rows 
strauss$firm <- "strauss"
tara$firm <- "tara"
tnuva$firm <- "tnuva"

df <- bind_rows(strauss, tara, tnuva)

# total market share ----
total_rev <- df %>% group_by(firm) %>% summarise(total_revenue = sum(revenue))
total_rev <- total_rev %>% mutate(ms = total_revenue / sum(total_revenue))
total_rev

# market share for each month ----
month_rev <- df %>% group_by(firm, date) %>%
  summarise(month_revenue = sum(revenue))

month_rev <- month_rev %>% group_by(date) %>%
  mutate(month_ms = month_revenue / sum(month_revenue))

# plot stage by stage:
# 1. plot the data
plot_ms <- ggplot(month_rev, aes(x = date, y = month_ms, fill = firm)) + geom_col()

# 2. add text labels
plot_ms <- 
  plot_ms +
  geom_text(aes(label = scales::label_percent(accuracy = 1)(month_ms)),
            position = position_stack(vjust = 0.5))

# 3. change the y axis
plot_ms <- plot_ms + scale_y_continuous(label = scales::label_percent())

# 4. add titles
plot_ms + labs(
  title = "monthly market share",
  subtitle = "all products",
  x = NULL,
  y = "נתח שוק מצטבר"
  )


# market share in milk ----
unique(df$cat)

# filter only milk
milk <- df %>% filter(str_detect(cat, pattern = "חלב")) %>%
  filter(!str_detect(cat, pattern = "מעדני"))

# calculate milk MS for each category: 
milk_ms <- milk %>% group_by(date, cat) %>% mutate(cat_ms = revenue / sum(revenue))

ggplot(milk_ms, aes(x = date, y = cat_ms, fill = firm)) + geom_col() +
         facet_wrap(~ cat)

# data for April is missing: 
milk_ms %>% filter(!(date == "2010-04-01" & (cat == "חלב בשקית" | cat == "חלב קרטון"))) %>%
  ggplot(aes(x = date, y = cat_ms, fill = firm)) + geom_col() +
  facet_wrap(~ cat)

  


