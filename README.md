Coursera Getting and Cleaning Data - Course Project
=============================

## About the raw Data

The features (561 of them) are unlabeled and can be found in the x_test.txt. The activity labels are in the y_test.txt file. The test subjects are in the subject_test.txt file. Those files can be downloaded from the following address: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Before start, I have to point the fact that the repository doesn't have the uncompressed data, so the first step should be to download and uncompress the data from the address above.

## Project Files

* run_analysis.R This file contains the data processing functions.
* CodeBook.md The codebook file, the glossary of features and additional info is stored here.
* README.md The project information 

## Instructions

First load the R script file into the workspace

`source("run_analysis.R")`

Now in order to execute the the script you should execute the following commands inside the R console, and also uncompress the zip dataset file, if the data folder is named different from "UCI HAR Dataset" then you need to pass the folder name as an argument to the runAnalysis function if not write the following code:

`runAnalysis()`

By default the script will try to locate the folder with name "UCI HAR Dataset" in the same directory as the script:

`runAnalysis(directory = './UCI HAR Dataset')`

However it's possible to pass the directory parameter in order to locate the exact path of the data directory, for example:

`runAnalysis("/home/gustav/UCI HAR Dataset")`

The script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

## Analysis Steps

The steps taken for the analysis:

* The first step was the merge of the different datasets in the train and test directories.
* The next one was the replacement of the variable names using the feature.txt file.
* The third was to add the variables subject and activity and also replace the activity values for the correspondent literal ones.
* The fourth was to reshape the data set in order to extract only measurements related to the mean and standard deviation of each measure and also add more descriptive names to the variables.
* The final step was to create a second tidy data set file with the average of each variable for each activity and each subject.

## About the tidy data

The script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can be found in this repository.
