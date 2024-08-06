# Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

# Load the datasets
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge the training and test datasets
data <- rbind(train_data, test_data)
labels <- rbind(train_labels, test_labels)
subjects <- rbind(train_subjects, test_subjects)

# Extract measurements of mean and standard deviation
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_features <- grep("mean\\(\\)|std\\(\\)", features$V2)
data <- data[, mean_std_features]

# Use descriptive activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
labels <- factor(labels$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Label the dataset with descriptive variable names
names(data) <- features$V2[mean_std_features]
names(subjects) <- "Subject"
names(labels) <- "Activity"
tidy_data <- cbind(subjects, labels, data)

# Create a second, independent tidy dataset with the average of each variable for each activity and subject
library(dplyr)
tidy_data_summary <- tidy_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# Save the tidy dataset to a file
write.table(tidy_data_summary, "tidy_data_summary.txt", row.names = FALSE)

# End of the script
