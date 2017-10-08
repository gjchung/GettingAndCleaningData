# GettingAndCleaningData


## Getting and Cleaning Data Course Project


### Purpose:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

1. A tidy data set. 
2. A link to a Github repository with your script for performing the analysis. 
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
4. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.


### Assignment Requirements:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Analysis
For this project, a series of data sets were imported from the UCI Human Activity Recognition Using Smartphones Data Set for analysis.  The files for both the data sets and it's column names were combined to create one dataframe containing the data for the test and train subjects performing various activities.  Using the activities data set, the activity names were also added to the dataframe.  Once that dataframe was created, the mean and standard deviation of the measurements from sensor signals using the devices' accelerometer was extracted.  Using that information, the `run_analysis.R` file will group the data by the subject and activities they performed and the averages of each of the measurements are derived.
'
