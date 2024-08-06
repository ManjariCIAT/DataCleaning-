# CodeBook

## Study Design

The dataset used for this project was collected from accelerometers in Samsung Galaxy S smartphones. It involves data collected from 30 volunteers performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The dataset is divided into training and test sets.

## Data Sources

- **Dataset**: [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Data Set Information

- **Subjects**: 30 volunteers aged 19-48 years.
- **Activities**: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
- **Sensors**: Accelerometer and gyroscope.
- **Sampling Rate**: 50Hz.
- **Window Size**: 2.56 seconds with 50% overlap.

## Variables

### Original Variable Names

The dataset includes the following types of measurements:

- `tBodyAcc-mean()-X`
- `tBodyAcc-mean()-Y`
- `tBodyAcc-mean()-Z`
- `tBodyAcc-std()-X`
- `tBodyAcc-std()-Y`
- `tBodyAcc-std()-Z`
- `tGravityAcc-mean()-X`
- `tGravityAcc-mean()-Y`
- `tGravityAcc-mean()-Z`
- `tGravityAcc-std()-X`
- `tGravityAcc-std()-Y`
- `tGravityAcc-std()-Z`
- ... (additional variables follow the same pattern)

### Transformed Variable Names

In the cleaned dataset, variable names are transformed to be more descriptive:

- `timeDomainBodyAccelerometerMeanX`
- `timeDomainBodyAccelerometerMeanY`
- `timeDomainBodyAccelerometerMeanZ`
- `timeDomainBodyAccelerometerStandardDeviationX`
- `timeDomainBodyAccelerometerStandardDeviationY`
- `timeDomainBodyAccelerometerStandardDeviationZ`
- `timeDomainGravityAccelerometerMeanX`
- `timeDomainGravityAccelerometerMeanY`
- `timeDomainGravityAccelerometerMeanZ`
- `timeDomainGravityAccelerometerStandardDeviationX`
- `timeDomainGravityAccelerometerStandardDeviationY`
- `timeDomainGravityAccelerometerStandardDeviationZ`
- ... (additional variables follow the same pattern)

## Transformations

1. **Merging Data**: Combined the training and test datasets using the `rbind` function.
2. **Extracting Mean and Standard Deviation**: Selected columns containing measurements of mean and standard deviation.
3. **Descriptive Activity Names**: Replaced numeric activity labels with descriptive names from `activity_labels.txt`.
4. **Descriptive Variable Names**: Renamed variables to make them more descriptive and readable.
5. **Creating Tidy Dataset**: Generated a tidy dataset with the average of each variable for each activity and each subject using the `dplyr` package.

## Steps in the `run_analysis.R` Script

1. **Download and Extract Data**: The dataset is downloaded and extracted.
2. **Load Data**: Read data from files into R data frames.
3. **Merge Training and Test Data**: Combined the training and test datasets.
4. **Extract Relevant Measurements**: Filtered for mean and standard deviation measurements.
5. **Label Activities**: Replaced activity numbers with descriptive names.
6. **Label Variables**: Updated variable names to be more descriptive.
7. **Create Final Tidy Dataset**: Computed the mean of each variable for each activity and each subject and saved the result.

## Files

- `run_analysis.R`: The R script performing data preparation and analysis.
- `tidy_data_summary.txt`: The final tidy dataset with average values.
