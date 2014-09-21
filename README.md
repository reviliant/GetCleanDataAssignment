Getting Clean And tidy DataSet
=====================================

Author
-------------------------------------
Abhishek Guha Thakurta (abhigt.jumech@gmail.com)

Purpose
-------------------------------------
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

1) a tidy data set as described below, 
2) a link to a Github repository with your script for performing the analysis, and
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data 
collected from the accelerometers from the Samsung Galaxy S smartphone.


Data Set
-------------------------------------
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Files in the Repository
-------------------------------------
README.md
CodeBook.md
run_analysis.R

Objectives of creating run_analysis.R
-------------------------------------

1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Assumptions
-------------------------------------
activity_labels.txt
features.txt
test\subject_test.txt
test\X_test.txt
test\y_test.txt
train\subject_train.txt
train\X_train.txt
train\y_train.txt

are present within the directory passed in the argument of GetTidyData(<directory>) function.

Code WalkThrough run_analysis.R
-------------------------------------

The R file consists of three functions:

getTidyData (directory) --> 

1.Takes directory/folder as parameter.
2. Reads and Loads activity_labels.txt and features.txt
3. Loads appropriate mean and standard deviation columns from features.txt
4. Calls two functions getTestData and getTrainingData by passing arguments(mean_std_cols,actvty_data_set)
4. Compiles complete tidy dataset
5. Calculates the mean per subject per activity level/name
6. Writes the clean dataset to a file in proper desired format

getTestData(mean_std_cols,actvty_data_set) -->

1. Reads and loads subject_test.txt,X_test.txt and y_test.txt.
2. Combines y_test dataset and activity_name dataset; and loads it into y_test dataset
3. Combines subject_test,X_test and y_test datasets
4. Filters variables based upon the mean_std_cols in features dataset.
5. Change the column names as per the features dataset
6. Returns a clean test dataset

getTrainingData(mean_std_cols,actvty_data_set) -->

1. Reads and loads subject_train.txt.txt,X_train.txt and y_train.txt.
2. Combines y_train dataset and activity_name dataset; and loads it into y_train dataset
3. Combines subject_train,X_train and y_train datasets
4. Filters variables based upon the mean_std_cols in features dataset.
5. Change the column names as per the features dataset
6. Returns a clean training dataset

