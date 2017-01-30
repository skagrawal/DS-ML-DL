##Getting and Cleaning Data Course Project

A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

R script called run_analysis.R do the following. 

A.	Merges the training and the test sets to create one data set.

B.	Extracts only the measurements on the mean and standard deviation for each measurement. 

C.	Uses descriptive activity names to name the activities in the data set

D.	Appropriately labels the data set with descriptive variable names. 

E.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The run_analysis.R script performs the following steps - 

a)	Set the path variables to load the data.

b)	Read X_train.txt, y_train.txt and subject_train.txt from the “./data/UCI HAR Dataset/test/" folder and store them in trainData_X, trainData_y and trainData_Subject variables respectively.

c)	Read X_test.txt, y_test.txt and subject_test.txt from the “./data/UCI HAR Dataset/test/" folder and store them in testData_X, testData_y and trainData_Subject variables respectively.

d)	Read the features.txt and store it’s second column in feature_name.

e)	testData_X and trainData_X are the feature variables.

f)	Set this name of all the features using feature_name both for test and training data.

g)	Bind the test and train data using rbind.

h)	Give the column name for activity and subject columns.

i)	Merge all the data using cbind, into one single data frame, combined_Data

j)	Extract the features, which have mean and std in their name.

k)	Make a subset of  combined_Data using above extracted set of features, Data.

l)	Use descriptive activity names to name the activities in the data set from the file activity_labels.txt.

m)	Create a independent tidy data set with the average of each variable for each activity and each subject using aggregate function of plyr package.

n)	In the last write the tidy data into a text file for submission using function write.table.
