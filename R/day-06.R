# Rosemary Juarez
# 7/07/21
# daily exercise 6
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv'
covid = read_csv(url)
head(covid)
library(ggthemes)

## **Question #1 :**
covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarise(cases=sum(cases,na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state) -> top_states

covid %>%
  filter(state %in% top_states)%>%
  group_by(state, date) %>%
  summarise(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases, color = state)) +
  geom_line(size = 2) + facet_wrap(~state) +
  labs(title = "6 states with the most current cases",
       x = "date", y = "cases") +
  ggthemes::theme_solarized()
ggsave(gg, file = "img/6Q1plot.png")

## **Question #2**

covid %>%
  group_by(date) %>%
  summarise(cases = sum(cases))

