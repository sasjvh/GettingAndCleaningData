## Download the zip file with the data to the working directory
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "GetAndClean.zip")

## Extract the data from the zip file into the working directory
## This should create a folder titled 'UCI HAR Dataset' containing the downloaded data
unzip("GetAndClean.zip")

## Read the descriptive variable names and positions from the features.txt file
feature_varnames <- read.table("UCI HAR Dataset/features.txt",
                               colClasses = c("integer", "character"),
                               col.names = c("position", "varname"))

## Read the activity labels from the activity_labels.txt file
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",
                               colClasses = c("integer", "character"),
                               col.names = c("activityid", "activityname"))

## Modify feature_varnames to only include mean and std deviation variables
feature_varnames <- feature_varnames[grep("mean\\(\\)|std\\(\\)", feature_varnames$varname),]

## Clean up the varnames to remove special characters and make lowercase
feature_varnames$varname <- gsub("-|\\(|\\)", "", tolower(feature_varnames$varname))

## Function to read either test or train data, restrict to mean or std deviation variables only, add names
## and then combine with the subject and activity data for each respectively
read_data <- function(path, type) {
  ## Create the filename for the measurement data
  file_name <- paste(path, "X_", type, ".txt", sep = "")
  
  ## Read only mean and std dev variables
  measure_table <- read.table(file_name)[feature_varnames$position]
  
  ## Assign clean variable names
  names(measure_table) <- feature_varnames$varname
  
  ## Create filename for subject data
  file_name <- paste(path, "subject_", type, ".txt", sep = "")
  
  ## Read subject data
  subject_table <- read.table(file_name, colClasses = c("integer"), col.names = c("subjectid"))
  
  ## Create filename for activity data
  file_name <- paste(path, "y_", type, ".txt", sep = "")
  
  ## Read activity data
  activity_table <- read.table(file_name, colClasses = c("integer"), col.names = c("activityid"))
  
  ## Combine Subject, Activity and measurement data into a single table
  cbind(subject_table, activity_table, measure_table)
}

## Read the test data
test_data <- read_data("UCI HAR Dataset/test/", "test")

## Read the train data
train_data <- read_data("UCI HAR Dataset/train/", "train")

## Combine test and training data
full_data <- rbind(test_data, train_data)

## Assumption that dplyr package is installed - here we place it in the environment with a library statement
library(dplyr)

## Join in Activity Names
full_data <- inner_join(full_data, activity_labels, by = "activityid")