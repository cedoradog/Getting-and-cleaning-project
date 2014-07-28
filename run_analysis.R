#Created by Camilo Dorado
#Created on July 25th/2014
#Last modification on July 27th/2014

library(plyr)
library(reshape2)

#Set the working directory
#setwd("d:/.../DataScience/GettingData")

#We will assume that unzipped data directory "UCI HAR Dataset" are at the 
#working directory, where the results will be written.
#Create a directory "data"
#if(!file.exists("UCI HAR Dataset")) {
#  dir.create("UCI HAR Dataset")}

#Download the data and report the download info
urlAddress <- "https://d396qusza40orc.cloudfront.net/
              getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(featureFileAdress, destfile = featureFile)
dateExecution <- date()

cat(c("Human Activity Recognition Using Smartphones Dataset", 
      "\nDistributed by: Smartlab - Non Linear Complex Systems Laboratory",
      "\nProcessed on:", dateExecution, 
      "\nSource:", urlAddress,
      "\nCodebook:", 
      "http://archive.ics.uci.edu/ml/datasets/
      Human+Activity+Recognition+Using+Smartphones"))

#Take the address of every needed file
activityLabelsFile <- "./UCI HAR Dataset/activity_labels.txt"
featureLabelsFile <- "./UCI HAR Dataset/features.txt"
subjectTestFile <- "./UCI HAR Dataset/test/subject_test.txt"
subjectTrainFile <- "./UCI HAR Dataset/train/subject_train.txt"
activitiesTestFile <- "./UCI HAR Dataset/test/y_test.txt"
activitiesTrainFile <- "./UCI HAR Dataset/train/y_train.txt"
featuresTestFile <- "./UCI HAR Dataset/test/X_test.txt"
featuresTrainFile <- "./UCI HAR Dataset/train/X_train.txt"

#In features files, each col is 16 chars width. First one has an additional space.
widths = c(17, rep(16, 560))

#Load the data in several dataframes
activityLabels <- read.table(activityLabelsFile, sep =" ")
featuresLabels <- read.table(featureLabelsFile, sep=" ")
subjectTestData <- read.table(subjectTestFile, sep=" ")
subjectTrainData <- read.table(subjectTrainFile, sep=" ")
activitiesTestData <- read.table(activitiesTestFile, sep=" ")
activitiesTrainData <- read.table(activitiesTrainFile, sep=" ")
featuresTestData <- read.fwf(featuresTestFile, widths=widths)
featuresTrainData <- read.fwf(featuresTrainFile, widths=widths)

#Merging the original datasets
activityCode <- rbind(activitiesTestData, activitiesTrainData)
subjectData <- rbind(subjectTestData, subjectTrainData)
featuresData <- rbind(featuresTestData, featuresTrainData)

#Variables to keep from features dataset
meanIndex = grep("mean\\(", featuresLabels$V2)
stdIndex= grep("std\\(", featuresLabels$V2)
index = sort(union(meanIndex, stdIndex))
featuresToUse <- featuresData[, index]

#Edit the names of the features variables
featuresLabels$V2 <- gsub("[\\(\\)]", "", featuresLabels$V2)
featuresLabels$V2 <- gsub("[-,]", "_", featuresLabels$V2)

#Transform activity codes in activity names
names(activityCode) <- "activityCode"
names(activityLabels) <- c("activityCode", "activity")
activityData <- join(activityCode, activityLabels, by="activityCode")

#Final dataset
dataset <- cbind(subjectData, activityData$activity, featuresToUse)

#Label the dataset w/ descriptive names
names(dataset) <- c("subject", "activity", featuresLabels[index, 2])

#Transform the subject variable into a factor
dataset$subject <- factor(dataset$subject)

#Clear the workspace
rm(subjectData, subjectTestData, subjectTrainData,
   subjectTestFile, subjectTrainFile)
rm(activityData, activitiesTestData, activitiesTrainData, 
   activityLabelsFile, activitiesTestFile, activitiesTrainFile,
   activityLabels, activityCode)
rm(featuresData, featuresToUse, featuresTestData, featuresTrainData, 
   featureLabelsFile, featuresTestFile, featuresTrainFile, featuresLabels)

#write the dataset to a new file
write.csv(dataset, file="./means_and_stds.csv", row.names=F)

#Melt the dataset by subject and activity
moltenData <- melt(dataset, id=c("subject", "activity"))

#Cast the molten dataset by subject and activity, summarinzing w/ mean function
summaryData <- dcast(moltenData, subject + activity ~ variable, mean)

#write the casted dataset to a new file
write.csv(summaryData, file="./tidy_dataset.txt", row.names=F)

#Clear the workspace
rm(dataset, summaryData)
