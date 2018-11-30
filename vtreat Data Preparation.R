install.packages("vtreat")
library("vtreat")
library("readr")

# read training set from data file
train <- read_csv("C:/Users/User/Desktop/ROM/data_train.csv")

# create a copy of training set
data <- train

vars <- setdiff(colnames(data),c('memId'))
# apply vtreat cross validation to develop treatments
cfe <- vtreat::mkCrossFrameCExperiment(data, vars, 'NotDropped', '1')
# store treatment plan
treatments <- cfe$treatments
# store treatment summary
treatmentSummary <- treatments$scoreFrame
# get treated trained data set
dTrainTreated <- cfe$crossFrame
dTrainTreated$memId <- data$memId

# export treated set to csv
write.csv(dTrainTreated, file = "C:/Users/User/Desktop/ROM/dTrainTreated.csv")

# read test set from data file
test <- read_csv("C:/Users/User/Desktop/ROM/data_test.csv")
dTestTreated <- vtreat::prepare(treatments,test)
dTestTreated$memId <- test$memId
# export treated test set to csv
write.csv(dTestTreated, file = "C:/Users/User/Desktop/ROM/dTestTreated.csv")
