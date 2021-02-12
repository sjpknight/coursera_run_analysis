## CodeBook
Author = Simon Knight
Date = 2021-02-12

# Data Source
Available via URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
Further info about the dataset here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

Files included in the original data:
* 'features_info.txt'= feature vector variables
* 'features.txt' = titles of all 561 features found in the test and training feature data sets
* 'activity_labels.txt' = activity labels and links to activity names
* 'X_train.txt' = training set with 7,352 observations
* 'y_train.txt' = activity labels for the 7,352 feature observations in the 'X_train.txt' file
* 'subject_train.txt' = subject ID's for the 7,352 feature observations in the 'X_train.txt' file
* 'X_test.txt' = test set for feature data with 2,947 observations
* 'y_test.txt' = activity labels for the 2,947 feature observations in the 'X_test.txt' file
* 'subject_test.txt' = subject ID's for the 2,947 feature observations in the 'X_test.txt' file

# Transformations and Other Useful Information

The run_analysis.R" script executes the following steps:

1. Loads the zipped data files from the link and put it in a directory named "HAR" (creating the dir if required). Then unzips the zip file.
2. Reads the files into data frames and combines them into a single object
3. Filters the data for only the features that contain "mean()" and "std()" using dplyr:select()
4. Adjusts the data frame columns to make them more readable
5. Splits the data by subject/activity and calculates mean across all the variables - putting the result into a run.data.final data frame
6. Writes the finished data to a txt file and cleans up all redundant objects from the environment

