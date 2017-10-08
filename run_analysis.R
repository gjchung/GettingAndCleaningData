setwd("/Users/joycelyn/code/coursera/data_analytics/GettingAndCleaningData/week4/GettingAndCleaningData")

library(dplyr)

# Function to import the data from the UCI Human Activity Recognition Using Smartphones Data Set and extract
# the data for the mean and standard deviation (std) for each measurement.
getMeanStdDataset <- function() {
  # Get the feature column names
  features <- read.table("./UCI\ HAR\ Dataset/features.txt", col.names=c("Index", "Feature"), colClasses=c("numeric", "character"))
  features$Feature <- gsub("BodyBody", "Body", features$Feature)
  features$Feature <- gsub("Acc", "Accelerometer", features$Feature)
  features$Feature <- gsub("Gyro", "Gyroscope", features$Feature)
  feature_names <- as.character(features[,2])
  
  # This column is added to keep track of which name contains the "mean()" or "std()" string.
  features["isStdMean"] = grepl("-std(", features$Feature, fixed=TRUE) | grepl("-mean(", features$Feature, fixed=TRUE)
  
  # Get the activities dataframe containing the ID and name
  activities <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt", col.names=c("Index", "Activity"))

  # Get test datasets by getting the subject IDs, test labels, and test set.
  test_subject <- read.csv("./UCI\ HAR\ Dataset/test/subject_test.txt", sep=" ", col.names="Subject", header=FALSE)
  test_x <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt", colClasses="numeric")
  colnames(test_x) <- feature_names
  test_y <- read.csv("./UCI\ HAR\ Dataset/test/y_test.txt", sep=" ", col.names="Activity.Labels", header=FALSE)
  
  # Apply the Activity names to test dataset using the activities dataframe
  test_y['Activity'] <- activities[test_y$Activity.Labels,]$Activity

  # Combine the test dataframes into one dataframe
  test_df <- cbind(test_subject, Activity=test_y$Activity, test_x)
  
  # Add a column to keep track of the subject type
  test_df["Subject.Type"] = "Test"

  
  # Get train datasets by getting the subject IDs, train labels, and train set.
  train_subject <- read.csv("./UCI\ HAR\ Dataset/train/subject_train.txt", sep=" ", col.names="Subject", header=FALSE)
  train_x <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt", colClasses="numeric")
  colnames(train_x) <- feature_names
  train_y <- read.csv("./UCI\ HAR\ Dataset/train/y_train.txt", sep=" ", col.names="Activity.Labels", header=FALSE)

  # Apply the Activity names to train dataset using the activities dataframe
  train_y['Activity'] <- activities[train_y$Activity.Labels,]$Activity
  
  # Combine the test dataframes into one dataframe
  train_df <- cbind(train_subject, Activity=train_y$Activity, train_x)
  
  # Add a column to keep track of the subject type
  train_df["Subject.Type"] = "Train"
  
  # Combine the test and train dataframes into one dataframe
  harus_df <- rbind(test_df, train_df)

  # Filter the columns to just the mean and std columns using the 'isStdMean' column in the features dataframe.  The 
  # is shifted by 2 to take the 'Subject' and 'Activity' columns into account.
  featureColNum <- features[features$isStdMean == TRUE,1] + 2
  harus_meanstd_df <- harus_df[,c(1, 564, 2, featureColNum)]

  return(harus_meanstd_df)
}

# Function to get the averages of the mean and std features grouped by the subject and activity.
getMeanStdAvgDataSet <- function() {
  # Get the mean and std dataframe
  df <- getMeanStdDataset()
  
  # Get the averages of the mean and std features grouped by the subject and activity.
  avg_df <- aggregate(df[, 4:69], list(Activity=df$Activity,Subject=df$Subject), mean)
  
  # Reorder the columns
  avg_df <- avg_df[,c(2, 1, 3:68)]

  return(avg_df)
}

# print(head(getMeanStdDataset()))
final_df <- getMeanStdAvgDataSet()
write.table(final_df, file="test_train_avg.txt", row.name=FALSE)