# download data and unzip
sourceURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
HARdir = "./data/HAR"
if(!file.exists(HARdir)) {dir.create(HARdir)}
download.file(sourceURL, destfile="./data/HAR/data.zip")
unzip("./data/HAR/data.zip", exdir="./data/HAR")

# read in the X test data
x.test <- read.csv("./data/HAR/UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
# read in the test labels
y.test <- read.csv("./data/HAR/UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
# read in the test subject data
subject.test <- read.csv("./data/HAR/UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
# merge the test data into a single DF
test <- data.frame(subject.test, y.test, x.test)

# read in the X training data
x.train <- read.csv("./data/HAR/UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
# read in the training labels
y.train <- read.csv("./data/HAR/UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
# read in the training subject data
subject.train <- read.csv("./data/HAR/UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
# merge test training data into a single DF
train <- data.frame(subject.train, y.train, x.train)

# combine test & train data
run.data <- rbind(train, test)

# read in the measurement labels data
features <- read.csv("./data/HAR/UCI HAR Dataset/features.txt", sep="", header=FALSE)
# convert the feature names into a vector
feature.names <- as.vector(features[, 2])
# update run.data with meaningful column names and apply feature.names 
colnames(run.data) <- c("subject_id", "activity_labels", feature.names)

# select only columns containing mean or standard deviations 
# exclude columns with freq or angle in name
run.data <- dplyr::select(run.data, contains("subject"), contains("label"),
                   contains("mean"), contains("std"), -contains("freq"),
                   -contains("angle"))

# read in the activity labels data
activity.labels <- read.csv("./data/HAR/UCI HAR Dataset/activity_labels.txt", 
                            sep="", header=FALSE)

# replace  activity codes in the trimmed down run.data with labels 
# from activity labels dataset.
run.data$activity_labels <- as.character(activity.labels[
  match(run.data$activity_labels, activity.labels$V1), 'V2'])

# tidy up the column names
names(run.data) <- gsub("Acc", "Acceleration", names(run.data))
names(run.data) <- gsub("^t", "Time", names(run.data))
names(run.data) <- gsub("^f", "Frequency", names(run.data))
names(run.data) <- gsub("BodyBody", "Body", names(run.data))
names(run.data) <- gsub("mean", "Mean", names(run.data))
names(run.data) <- gsub("std", "Std", names(run.data))
names(run.data) <- gsub("Freq", "Frequency", names(run.data))
names(run.data) <- gsub("Mag", "Magnitude", names(run.data))

# create 2nd data set with average of each variable
run.data.final <- plyr::ddply(run.data, c("subject_id", "activity_labels"), plyr::numcolwise(mean))

# dump results to text file 
write.table(run.data.final, file = "run_data_final.txt")

# clean-up
remove(subject.test, x.test, y.test, subject.train, x.train, y.train, test, train, activity.labels, features, run.data)