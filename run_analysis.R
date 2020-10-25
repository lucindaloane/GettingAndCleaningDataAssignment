# Instructions
# You should create one R script called run_analysis.R that does the following.

# Load test and train data into data tables
test <- read.table("./test/X_test.txt")
train <- read.table("./train/X_train.txt")
# Load feature names
featname  <- read.table("features.txt", colClasses = "character")
featvec <- tolower(featname$V2)
# Remove brackets and dashes from feature names
featvec <- gsub("\\()","",featvec)
featvec <- gsub("-","",featvec)
names(test) <- featvec
names(train) <- featvec
rm(featname,featvec)



# 2. Extracts only the measurements on the mean and standard deviation for each 
# measurement.
a <- grep("mean",names(test))
b <- grep("meanfreq",names(test))
c <- grep("angle",names(test))
x <- setdiff(a,b)
colselectmean <- setdiff(x,c)
colselectstd <- grep("std",names(test))
test <- test[,c(colselectmean,colselectstd)]

a <- grep("mean",names(train))
b <- grep("meanfreq",names(train))
c <- grep("angle",names(train))
x <- setdiff(a,b)
colselectmean <- setdiff(x,c)
colselectstd <- grep("std",names(train))
train <- train[,c(colselectmean,colselectstd)]
rm(a,b,x,c,colselectstd,colselectmean)



# 3. Uses descriptive activity names to name the activities in the data set

testact <- read.table("./test/y_test.txt")
trainact <- read.table("./train/y_train.txt")
names(testact) <- "activitylabel"
names(trainact) <- "activitylabel"
test <- cbind(test, testact)
train <- cbind(train, trainact)
rm(trainact,testact)


# 4. Appropriately labels the data set with descriptive variable names.
test$activitylabel <- sub("1","walking",test$activitylabel)
test$activitylabel <- sub("2","walking_upstairs",test$activitylabel)
test$activitylabel <- sub("3","walking_downstairs",test$activitylabel)
test$activitylabel <- sub("4","sitting",test$activitylabel)
test$activitylabel <- sub("5","standing",test$activitylabel)
test$activitylabel <- sub("6","laying",test$activitylabel)

train$activitylabel <- sub("1","walking",train$activitylabel)
train$activitylabel <- sub("2","walking_upstairs",train$activitylabel)
train$activitylabel <- sub("3","walking_downstairs",train$activitylabel)
train$activitylabel <- sub("4","sitting",train$activitylabel)
train$activitylabel <- sub("5","standing",train$activitylabel)
train$activitylabel <- sub("6","laying",train$activitylabel)

# Add subject column to both the datasets
testsub <- read.table("./test/subject_test.txt")
trainsub <- read.table("./train/subject_train.txt")
names(testsub) <- "subject"
names(trainsub) <- "subject"
test <- cbind(test, testsub)
train <- cbind(train, trainsub)
rm(trainsub,testsub)


# 1. Merges the training and the test sets to create one data set.
data <- rbind(test,train)
rm(test,train)


# 5. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.

library(plyr)
library(dplyr)

act <- data %>% 
  group_by(activitylabel,subject) %>% 
  summarise_each(funs(mean))

write.table(act, "./tidyset.txt", row.names = FALSE)
