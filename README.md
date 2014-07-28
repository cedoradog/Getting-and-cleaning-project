Getting and cleaning data Course project
============================

This is a repo to demonstrate what I have learned during the Coursera MOOC "Getting and cleaning data" (July 2014).

Raw data from mechanical measurements performed in 30 subjects by means of Samsung Galaxy S II smartphones, as well as classification of activities that they perform, were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. Information about the nature of the variables and its measurament can be found in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

A R script *run_analysis.R* was written under the assumption that the working directory contains the downloaded and unzipped *UCI HAR Dataset* directory with the original data.

When executed, the script generates a tidy dataset that summarizes the mean of certain variables grouped by subject and activity. Those selected variables are those identified as "mean" or "std" of the mechanical parameters present in the original dataset.

Briefly, the train and test datasets were read as dataframes and merged together, having selected previously the **features** (mechanical quantitative variables) that had the substrings "mean()" or "std()" in its original name, and having joined the activities data to show the names of the performed activity instead of their numeric codes. Descriptive names were assigned to features deleting parenthesis and replacing commas and dashes by underscores.

Finally, the dataset was molten with the **subject** and **activity** variables as identifiers, and then casted, grouped by those same variables, summarizing the mean of the selected features grouped by subject and activity.

The resultant dataset was written in a comma-separated-value, saved with the *.txt* extension to allow submission.

Unfortunately, the working memory of my PC was not enough to load the complete raw data (just 4 GB of ~ 40 GB required). Then, a modified version of the script *run_analysis.R* was executed to allow the reading of just 500 records of each test and train file, to generate the attached tydy_dataset.txt file that is currently in this repo. That implies, that some of the subjects are not represented on the reported dataset. However, a user with a sufficient working memory, should not have any problem to obtain the expected resultant file from the execution of the attached script.
