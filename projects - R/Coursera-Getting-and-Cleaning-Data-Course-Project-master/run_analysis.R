###################################################
# Getting and Cleaning Data Course Project
###################################################
path <- file.path(getwd(), "data/UCI HAR Dataset/")
pathTest <- file.path(path,"test")
pathTrain <- file.path(path,"train")

# Loading the features column names
path_features <- file.path(path, "features.txt")
feature_name <- read.table(path_features)[,2]


#Reading test data
pathTest_X <- file.path(pathTest, "X_test.txt")
pathTest_y <- file.path(pathTest, "y_test.txt")
pathSub_Test <- file.path(pathTest, "subject_test.txt")
testData_X <- read.table(pathTest_X)
testData_y <- read.table(pathTest_y)
testData_Subject <- read.table(pathSub_Test)

# Setting column name
names(testData_X) = feature_name

#Reading training data
pathTrain_X <- file.path(pathTrain, "X_train.txt")
pathTrain_y <- file.path(pathTrain, "y_train.txt")
pathSub_Train <- file.path(pathTrain, "subject_train.txt")
trainData_X <- read.table(pathTrain_X)
trainData_y <- read.table(pathTrain_y)
trainData_Subject <- read.table(pathSub_Train)

# Setting column name
names(trainData_X) = feature_name



# Binding similer data together
data_Activity <- rbind(testData_y,trainData_y)
data_Feature <- rbind(testData_X,trainData_X)
data_Sub <- rbind(testData_Subject,trainData_Subject)

###################################################
# 4. Appropriately labels the data set with descriptive variable names.
###################################################

names(data_Activity) <- "activity"
names(data_Sub) <- "Subject"

###################################################
# 1. Merges the training and the test sets to create one data set.
###################################################
tempCombine <- cbind(data_Activity,data_Sub) 
combined_Data <- cbind(tempCombine,data_Feature)


###################################################
# 2. For extracting only the measurements on the mean and standard deviation for each measurement.
###################################################
extract_features <- feature_name[grep("mean\\(\\)|std\\(\\)", feature_name)]

selected_Names <- c(as.character(extract_features), "Subject", "activity" )
Data <- subset(combined_Data, select = selected_Names)


###################################################
# 3. Uses descriptive activity names to name the activities in the data set
###################################################

# Loading the activites detail
activities_title <- file.path(path, "activity_labels.txt")
feature_name <- read.table(activities_title)

# replacing descriptive activity names 
Data$activity <- feature_name[Data$activity, 2]

###################################################
# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
###################################################
library(plyr);

tidy_Data <- aggregate(. ~ Subject + activity, Data, mean)

tidy_Data <- tidy_Data[order(tidy_Data$Subject,tidy_Data$activity),]

write.table(tidy_Data, file = "./data/tidydata.txt", row.name=FALSE)

