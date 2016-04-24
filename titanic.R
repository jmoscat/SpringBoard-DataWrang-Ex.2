library(dplyr)
library(tidyr)
input <- read.csv("titanic_original.csv", header = TRUE, sep = ",", stringsAsFactors=FALSE)
data_titanic <- tbl_df(input)

#Missing value in embarked
data_titanic <- data_titanic %>% mutate(embarked = replace (embarked, embarked=="", "S"))

#2. Age
#Replacing NA in age with average age of the whole sample
data_titanic  <- data_titanic %>% mutate(age= replace(age, is.na(age), mean(age, na.rm=TRUE)))
#Replacing NA in age following a different approach. Given that the mean of age of male (30.6) is slightly different that mean age of female(28.7),
#replacing NA with the mean of the corresponding gender. 
mean_male = mean(filter(data_titanic,sex=="male")$age, na.rm=TRUE)
mean_female = mean(filter(data_titanic,sex=="female")$age, na.rm=TRUE)

data_titanic <- data_titanic %>% mutate(age = ifelse(sex=="male",replace(age,is.na(age),mean_male),ifelse(sex=="female",replace(age,is.na(age),mean_female),0)))


#3. Boat
data_titanic <- data_titanic %>% mutate(boat=replace(boat, boat=="","-"))

#4. Cabin
data_titanic <- data_titanic %>% mutate(has_cabin_number = ifelse(cabin == "",1,0))



