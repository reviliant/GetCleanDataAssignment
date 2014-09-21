getTidyData <- function(directory) { 
  
  #Setting the current WD to the current working directory
  setwd(directory) 
  
  #Reading and loading Acivity Labels from activity_labels.txt and renaming columns of the dataset
  actvty_data_set <- read.table("activity_labels.txt",col.names=c("Actvty_Level","Actvty_Name"))
  
  #Reading and loading Acivity Labels from features.txt
  features_dataset <- read.table("features.txt")

  ##Searching for all the attributes within features.txt which are meant for the calculation of 
  #mean and standard deviation
  mean_std_cols <- features_dataset[grep("mean\\(\\)|std\\(\\)", features_dataset$V2), ]
  
  ##Retrieving tidy dataset for test data Call function getTestData. The arguments are:
  #1) The mean and standard deviation columns from features.txt
  #2)The activity dataset containing the activity levels and names
  complete.tidy.tst.dataset <- getTestData(mean_std_cols,actvty_data_set)
  
  #Retrieving tidy dataset for training data Call function getTrainingData arguments are:
  #1) The mean and standard deviation columns from features.txt
  #2)The activity dataset containing the activity levels and names
  complete.tidy.trn.dataset <- getTrainingData(mean_std_cols,actvty_data_set)
  
  #Combining tidy dataset of test and training data
  complete.tidy.dataset <- rbind(complete.tidy.tst.dataset,complete.tidy.trn.dataset)
  
  #Using aggregate function to creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  complete.tidy.dataset <- aggregate(complete.tidy.dataset[, -1:-3],
                                     by=list(Subject = complete.tidy.dataset$Subject, 
                                             Actvty_Level = complete.tidy.dataset$Actvty_Level,
                                             Actvty_Name = complete.tidy.dataset$Actvty_Name),
                                     mean)
  
  #Dimension of the dataset using dim (180,69)
  dim(complete.tidy.dataset)
  
  #Test Printing out the first 10 rows and first 5 columns of the dataset using head function
  head(complete.tidy.dataset[,1:5],10)
  
  #Write the clean tidy dataset to a text file
  write.table(format(complete.tidy.dataset,justify=c("centre")),file = "complete_tidy_dataset.txt",row.names = FALSE)
  

}

## Function to return a tidy Test DataSet
getTestData <- function(mnStd.dtset,actvt.dtset) { 
  
  #Reading and loading data from subject_test.txt and renaming the column as Subjects
  tst_subjects <- read.table("test/subject_test.txt", col.names="Subjects")
  
  #Reading and loading data from X_test
  tst_X_dataset <- read.table("test/X_test.txt")
  
  #Reading and loading data from y_test.txt and renaming the column as Actvty_Level
  tst_Y_dataset <- read.table("test/y_test.txt",col.names="Actvty_Level")
  
  #Combining y_test.txt with acitivity dataset to inlcude Activity names 
  tst_Y_dataset <- cbind(tst_Y_dataset,actvt.dtset[match(tst_Y_dataset$Actvty_Level,actvt.dtset$Actvty_Level),])[,c(1,3)]
  
  #Combining the subject,X and y datasets
  tst_data <- cbind(tst_subjects,tst_Y_dataset,tst_X_dataset)
  
  #Filtering the requisite mean and standard deviations columns referencing the features dataset
  clean_tst_data <- tst_data[,c(1:3,mnStd.dtset$V1+3)] 
  
  #Renaming the variable names to abide by "Appropriately labels the data set with descriptive variable names." 
  colnames(clean_tst_data) <- c("Subject","Actvty_Level","Actvty_Name",as.character(mnStd.dtset$V2))
  
  #Returning Clean Test Data
  return(clean_tst_data)
}

## Function to return a tidy Training DataSet
getTrainingData <- function(mnStd.dtset,actvt.dtset) { 
  
  #Reading and loading data from subject_train.txt and renaming the column as Subjects
  trn_subjects <- read.table("train/subject_train.txt", col.names="Subjects")
  
  #Reading and loading data from X_train
  trn_X_dataset <- read.table("train/X_train.txt")
  
  #Reading and loading data from y_train.txt and renaming the column as Actvty_Level
  trn_Y_dataset <- read.table("train/y_train.txt",col.names="Actvty_Level")
  
  #Combining y_test.txt with acitivity dataset to inlcude Activity names 
  trn_Y_dataset <- cbind(trn_Y_dataset,actvt.dtset[match(trn_Y_dataset$Actvty_Level,actvt.dtset$Actvty_Level),])[,c(1,3)]
  
  #Combining the subject,X and y datasets
  trn_data <- cbind(trn_subjects,trn_Y_dataset,trn_X_dataset)
  
  #Filtering the requisite mean and standard deviations columns referencing the features dataset
  clean_trn_data <- trn_data[,c(1:3,mnStd.dtset$V1+3)] 
  
  #Renaming the variable names to abide by "Appropriately labels the data set with descriptive variable names." 
  colnames(clean_trn_data) <- c("Subject","Actvty_Level","Actvty_Name",as.character(mnStd.dtset$V2))
  
  #Returning Clean DataSet
  return(clean_trn_data)
}
