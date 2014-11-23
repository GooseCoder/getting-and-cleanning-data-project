# mergeDataSets function merges the train and test data sets
mergeDataSets <- function(directory = './UCI HAR Dataset') {
    if (!file.exists(directory)){
        stop(paste("The data folder doesn't exists:", directory))
    }
    # setting up the file paths
    testPath = paste(directory, "/test/X_test.txt", sep="")
    trainPath = paste(directory, "/train/X_train.txt", sep="")
    # reading the data into data tables
    testDataSet  <- read.table(testPath, header=FALSE)
    trainDataSet  <- read.table(trainPath, header=FALSE)
    # merge train and test set
    dataSet  <- rbind(testDataSet,trainDataSet);
    dataSet
}

## applying the correct variable names
applyFeatures  <- function(data, directory="./UCI HAR Dataset") {
    # getting the colnames from the features.txt
    colNames  <- read.table(paste(directory, "/features.txt", sep=""), header=FALSE)
    colnames(data)  <- colNames$V2
    data
}

## retrieving only the mean and standard deviation related variables
retrieveStdMeanData <- function(data, directory="./UCI HAR Dataset") {
    stdMeanColNames <- grep(".*std\\(\\)|.*mean\\(\\)", colnames(data))
    totalColNames <- c(1, 2, stdMeanColNames)
    stdMeanData  <-  data[,totalColNames]
    #correcting labels of the data set
    colNames <- colnames(stdMeanData)
    colNames <- gsub('\\,',"",  colNames)
    colNames <- gsub('\\(|\\)',"", colNames)    
    colnames(stdMeanData) <- colNames
    stdMeanData
}

## retrieve the activities variable
retrieveActivities <- function(directory="./UCI HAR Dataset") {
    testPath <- paste(directory, "/test/y_test.txt", sep="")
    trainPath <- paste(directory, "/train/y_train.txt", sep ="")
    labelsPath <- paste(directory, "/activity_labels.txt", sep="")
    activity <- rbind(read.table(testPath, header=FALSE),read.table(trainPath, header=FALSE) )    
    as.numeric(c(activity$V1))
}

## retrieve the subject varaible
retrieveSubjects <- function(directory="./UCI HAR Dataset") {
    testPath = paste(directory, "/test/subject_test.txt", sep="")
    trainPath <- paste(directory, "/train/subject_train.txt", sep ="")
    subject  <- rbind(read.table(trainPath, header=FALSE),read.table(testPath, header=FALSE) )    
    as.numeric(c(subject$V1))
}

## add activity and subject extracted variables to the dataset
addActivitiesAndSubjects <- function(data, directory="./UCI HAR Dataset") {
    activity = retrieveActivities(directory)
    subject = retrieveSubjects(directory)
    cbind(activity, subject, data)
}

## place the correct labels for tha activity variable
processActivityLabels <- function(data, directory = './UCI HAR Dataset') {
    activitylabels <- read.table(paste(directory,"/activity_labels.txt",sep=""), col.names=c("level", "label"))
    data$activity <- factor(data$activity, levels=activitylabels$level, labels=activitylabels$label)
    data
}

## applying the mean function to each of the variables extracted
retrieveTidyData <- function(data) {
    ddply(data, .(subject, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
}

## Main function in charge to process the current data set into the tidy data set required
runAnalysis <- function(directory = './UCI HAR Dataset') {
    ## calling each of the functions required to process the dataset
    dataSet <- mergeDataSets(directory)
    dataSetWithFeatures <- applyFeatures(dataSet, directory)
    dataSetWithActSub <- addActivitiesAndSubjects(dataSetWithFeatures, directory)
    dataSetLabeled <- processActivityLabels(dataSetWithActSub, directory)
    dataSetFilteredStdMean <- retrieveStdMeanData(dataSetLabeled, directory)
    tidyData <- retrieveTidyData(dataSetFilteredStdMean)    
    #writing to the file tidy.txt
    write.table(tidyData, "tidy.txt", row.names=FALSE)
    #retrieving the dataset
    tidyData
}

