rm(list = ls()) # removes all variables stored previously
library(Hmisc)  # import

data <- read.csv("C:/Users/pc user/Downloads/COVID19_line_list_data.csv")
describe(data)  # Uses Hmisc command

# Cleaned up data
data$death_dummy <- as.integer(data$death != 0)

# Death rate
sum(data$death_dummy)/nrow(data)

#AGE
#Claim: people who die are 
dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)
mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

# Is this statistically significant?
t.test(alive$age, dead$age, alternative ="two.sided", conf.level = 0.99)
# normally, if p-value < 0.05, we reject null hypothesis
# here, p-value ~ 0, so we reject null hypothesis and 
# conclude that this is statistically significant.

# Gender
# claim: gender has no effect
men = subset(data, gender == "male")
women = subset(data, gender == 'female')
mean(men$death_dummy, na.rm = TRUE)
mean(women$death_dummy, na.rm = TRUE)

# Is this statistically significant?
t.test(men$death_dummy, women$death_dummy, alternative = "two.sided", conf.level = 0.99)
# 99% CI, men have from 0.8% to 8.8% higher chance of dying
# p-value = 0.002 < 0.05, hence significant.
