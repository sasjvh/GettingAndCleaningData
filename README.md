# Getting and Cleaning Data Course Project
The goal of this project is to prepare tidy data that can be used for later analysis.

## Raw Data
The data are collected from Samsung Galaxy S smartphone accelerometers. A full description is available at the UCI Machine Learning Repository:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Script
The project contains a single script called run_analysis.R

### Assumptions
The script assumes that the dplyr package is installed

### What the Script Does
* Download and extract the raw data to the working directory
* Extracts only the measurements on the mean and standard deviation for each measurement
* Merges the training and the test sets to create one data set
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject which is written to summarydata.txt in the working directory
