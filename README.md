Getting and cleaning data Course project
============================

This is a repo to demonstrate what I have learned during the Coursera MOOC "Getting and cleaning data" (July 2014).

Raw data from mechanical measurements performed in 30 subjects by means of Samsung smartphones, as well as classification of activities that they report to perform, were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Information about the nature of the variables and its measurament can be found in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

A R script "run_analysis.R" was written under the assumption that the working directory contains the downloaded and unzipped "UCI HAR Dataset" directory with the original data.

When executed the script generates a tidy dataset that summarizes the mean of certain variables grouped by subject and activity. Those variables are those identified as "mean" or "std" of the mechanical parameters present in the original dataset.

Briefly, the train and test datasets were read as dataframes and merged together, having selected just the features (mechanical quantitative variables) that had the substrings "mean()" or "std()" in its original name and having joined the activities data to show the names of the performed activity instead of the numeric code. Descriptive names to the features were assigned deleting parenthesis and replacing commas and dashes by underscores.
Finally, the dataset was molten with the subject and activity variables as identifiers and then casted, grouped by those same variables, summarizing the mean of the selected variables in each subject and activity.
