# Getting and Cleaning Data Project 

#load library 
library(data.table)
library(reshape2)

setwd("C:/Users/MSingh/Documents")
path <- getwd()

##Get the data & Download the file. 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "assignment.zip"
if (!file.exists(path))
  {dir.create(path)}
download.file(url, file.path(path, f))
getwd()
##Unzip the file with WinRar on Windows
exe <- file.path("C:", "Program Files (x86)", "WinRAR", "WinRAR.exe")
parameters <- "x"
cmd <- paste(paste0("\"", exe, "\""), parameters, paste0("\"", file.path(path,f), "\""))
system(cmd)

#set path of activity label and features
path_act <- file.path(path, "UCI HAR Dataset/activity_labels.txt")
path_feature <- file.path(path, "UCI HAR Dataset/features.txt")
  
# Load activity labels and features
activityLabels <- fread(path_act, col.names = c("classLabels", "activityName"))
features <- fread(path_feature, col.names = c("index", "featureNames"))

featuresW <- grep("(mean|std)\\(\\)", features[, featureNames])
obs <- features[featuresW, featureNames]
obs <- gsub('[()]', '', obs)


# Load train datasets
path_trainX <- file.path(path, "UCI HAR Dataset/train/X_train.txt")
train <- fread(path_trainX)[, featuresWanted, with = FALSE]
data.table::setnames(train, colnames(train), obs)

path_trainY <- file.path(path, "UCI HAR Dataset/train/Y_train.txt")
trainActivities <- fread(path_trainY, col.names = c("Activity"))

path_train_sub <- file.path(path, "UCI HAR Dataset/train/subject_train.txt")
trainSubjects <- fread(path_train_sub , col.names = c("SubjectNum"))

train <- cbind(trainSubjects, trainActivities, train)

# Load test datasets
path_testX <- file.path(path, "UCI HAR Dataset/test/X_test.txt")
test <- fread(path_testX)[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), obs)

path_testY <- file.path(path, "UCI HAR Dataset/test/Y_test.txt")
testActivities <- fread(path_testY, col.names = c("Activity"))

path_test_sub <- file.path(path, "UCI HAR Dataset/test/subject_test.txt")
testSubjects <- fread(path_test_sub, col.names = c("SubjectNum"))

test <- cbind(testSubjects, testActivities, test)

# merge datasets
combined <- rbind(train, test)

# Convert classLabels to activityName basically
combined[["Activity"]] <- factor(combined[, Activity]
                              , levels = activityLabels[["classLabels"]]
                              , labels = activityLabels[["activityName"]])

combined[["SubjectNum"]] <- as.factor(combined[, SubjectNum])
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, SubjectNum + Activity ~ variable, fun.aggregate = mean)

write.table(x = combined, file = "TidyData.txt",row.name=FALSE,quote = FALSE)
