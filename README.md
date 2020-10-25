# GettingAndCleaningDataAssignment

#Contents

This repository consists of 4 files

CodeBook.md : This markdown document provides variable names
README.md : This markdown document explains the steps taken in this assignment to produce the tidy data set
run_analysis.R : This is the .R script used to transform the given data into a tidy data set.
tidyset.txt : This is the tidy data set produced from the .R script

To run the R script one must have the following files in their working directory

/train/X_train.txt
/test/X_test.txt
features.txt
/test/y_test.txt
/train/y_train.txt
/test/subject_test.txt
/train/subject_train.txt

You must also have the dplyr package installed

Once you have the unzipped folder as the working directory you can run the given R script which will create a tidy data set in a file named tidyset.txt

#Descsription of Steps

Step 1
Load train and test data sets into separate dataframes
Load feature list, format to tidy variable names
Use this vector to rename the columns of both data frames
Step 2
Out of 561 columns of the data frames only the ones with mean and standard deviation are used (68 in number).
meanFreq() columns are not used as they are derived columns.
Step 3
Load activity labels and bind to the test and train dataframes.
Labels are replaced by more descriptive names.
Step 4
Subjects are now loaded and binded to the test and train data frames.
Step 5
Merge both data frames together
Step 6
dplyr package is used to group merged data frame by subject and activity and written to tidyset.txt in the working directory.
