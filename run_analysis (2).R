# Load necessary libraries
library(dplyr)

# Set working directory to the location of the Samsung data
setwd("path/to/your/UCI HAR Dataset")

# Load activity labels and features
activity_labels <- read.table("activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("features.txt", col.names = c("n", "functions"))

# Load train datasets
subject_train <- read.table("train/subject_train.txt", col.names = "subject")
x_train <- read.table("train/X_train.txt", col.names = features$functions)
y_train <- read.table("train/y_train.txt", col.names = "code")

# Load test datasets
subject_test <- read.table("test/subject_test.txt", col.names = "subject")
x_test <- read.table("test/X_test.txt", col.names = features$functions)
y_test <- read.table("test/y_test.txt", col.names = "code")

# Merge train and test datasets
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_data, y_data, x_data)

# Extract only the measurements on the mean and standard deviation for each measurement
tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

# Use descriptive activity names to name the activities in the dataset
tidy_data$code <- activity_labels[tidy_data$code, 2]

# Appropriately label the dataset with descriptive variable names
names(tidy_data)[2] <- "activity"
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data) <- gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <- gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <- gsub("gravity", "Gravity", names(tidy_data))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = ~ mean(.)))

# Write the final tidy dataset to a file
write.table(final_data, "FinalData.txt", row.name = FALSE)

# Print completion message
print("Tidy data set created and saved as FinalData.txt")
