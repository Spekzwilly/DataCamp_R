library(dplyr)

ucb_admission_counts <- ucb_admit %>%
  count(Dept, Gender, Admit)

perc_admited_by_dept <- ucb_admission_counts %>%
  group_by(Dept, Gender) %>%
  mutate(prop = n / sum(n)) %>%
  filter(Gender == "Male", Admit == "Admitted")

perc_admited_by_dept

