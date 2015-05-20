# ------------------------------------------------------------------
# path variables (relative to this R script file)
folderpath_dataset <- "UCI HAR Dataset"
folderpath_train <- sprintf("%s/%s", folderpath_dataset, "train")
folderpath_test <- sprintf("%s/%s", folderpath_dataset, "test")

filename_activity_labels <- "activity_labels.txt"
filename_features <- "features.txt"
filename_subject_train <- "subject_train.txt"
filename_subject_test <- "subject_test.txt"
filename_x_train <- "X_train.txt"
filename_x_test <- "X_test.txt"
filename_y_train <- "y_train.txt"
filename_y_test <- "y_test.txt"

filepath_activity_labels <- sprintf("%s/%s", folderpath_dataset, filename_activity_labels)
filepath_features <- sprintf("%s/%s", folderpath_dataset, filename_features)

filepath_subject_train <- sprintf("%s/%s", folderpath_train, filename_subject_train)
filepath_x_train <- sprintf("%s/%s", folderpath_train, filename_x_train)
filepath_y_train <- sprintf("%s/%s", folderpath_train, filename_y_train)

filepath_subject_test <- sprintf("%s/%s", folderpath_test, filename_subject_test)
filepath_x_test <- sprintf("%s/%s", folderpath_test, filename_x_test)
filepath_y_test <- sprintf("%s/%s", folderpath_test, filename_y_test)


# ------------------------------------------------------------------
# load activity_labels & feature_names
act_labels <- read.table(
    file = filepath_activity_labels,
    header = F,
    col.names = c("activity_id","activity_name")
  )

features <- read.table(
  file = filepath_features,
  header = F,
  col.names = c("column_index","feature_name"),
  colClasses = c("integer","character")
)


# ------------------------------------------------------------------
# load train set
subject_train <- read.table(
    file = filepath_subject_train,
    header = F,
    col.names = c("subject_id")
  )

y_train <- read.table(
    file = filepath_y_train,
    header = F,
    col.names = c("activity_id")
  )

x_train <- read.table(
    file = filepath_x_train,
    header = F,
    col.names = features$feature_name
  )

train_set <- cbind(subject_train, y_train , x_train)

remove(subject_train)
remove(y_train)
remove(x_train)


# ------------------------------------------------------------------
# load test set
subject_test <- read.table(
    file = filepath_subject_test,
    header = F,
    col.names = c("subject_id")
  )

y_test <- read.table(
    file = filepath_y_test,
    header = F,
    col.names = c("activity_id")
  )

x_test <- read.table(
    file = filepath_x_test,
    header = F,
    col.names = features$feature_name
  )

test_set <- cbind(subject_test, y_test, x_test)

remove(subject_test)
remove(y_test)
remove(x_test)


# ------------------------------------------------------------------
# merge train & test sets
dataset <- rbind(train_set, test_set)

remove(train_set)
remove(test_set)


# ------------------------------------------------------------------
# extract mean & std columns for each measurement

## extract subject_id, activity_id & any columns with names contain "mean" or "std"
dataset <- dataset[, c(1,2, grep("(mean|std)", colnames(dataset)))]

## remove column with names contain "meanFreq"
dataset <- dataset[, -grep("meanFreq", colnames(dataset))]


# ------------------------------------------------------------------
# use descriptive activity names

## add activity_name by merge
dataset <- merge(dataset, act_labels, by = "activity_id")

## remove activity_id
dataset <- dataset[, -match("activity_id", colnames(dataset))]


# ------------------------------------------------------------------
# labels the data set with descriptive variable names
library(dplyr)
dataset <- rename(dataset,
    tBodyAcc_x_mean = tBodyAcc.mean...X,
    tBodyAcc_y_mean = tBodyAcc.mean...Y,
    tBodyAcc_z_mean = tBodyAcc.mean...Z,
    tBodyAcc_x_std = tBodyAcc.std...X,
    tBodyAcc_y_std = tBodyAcc.std...Y,
    tBodyAcc_z_std = tBodyAcc.std...Z,
    tGravityAcc_x_mean = tGravityAcc.mean...X,
    tGravityAcc_y_mean = tGravityAcc.mean...Y,
    tGravityAcc_z_mean = tGravityAcc.mean...Z,
    tGravityAcc_x_std = tGravityAcc.std...X,
    tGravityAcc_y_std = tGravityAcc.std...Y,
    tGravityAcc_z_std = tGravityAcc.std...Z,
    tBodyAccJerk_x_mean = tBodyAccJerk.mean...X,
    tBodyAccJerk_y_mean = tBodyAccJerk.mean...Y,
    tBodyAccJerk_z_mean = tBodyAccJerk.mean...Z,
    tBodyAccJerk_x_std = tBodyAccJerk.std...X,
    tBodyAccJerk_y_std = tBodyAccJerk.std...Y,
    tBodyAccJerk_z_std = tBodyAccJerk.std...Z,
    tBodyGyro_x_mean = tBodyGyro.mean...X,
    tBodyGyro_y_mean = tBodyGyro.mean...Y,
    tBodyGyro_z_mean = tBodyGyro.mean...Z,
    tBodyGyro_x_std = tBodyGyro.std...X,
    tBodyGyro_y_std = tBodyGyro.std...Y,
    tBodyGyro_z_std = tBodyGyro.std...Z,
    tBodyGyroJerk_x_mean = tBodyGyroJerk.mean...X,
    tBodyGyroJerk_y_mean = tBodyGyroJerk.mean...Y,
    tBodyGyroJerk_z_mean = tBodyGyroJerk.mean...Z,
    tBodyGyroJerk_x_std = tBodyGyroJerk.std...X,
    tBodyGyroJerk_y_std = tBodyGyroJerk.std...Y,
    tBodyGyroJerk_z_std = tBodyGyroJerk.std...Z,
    tBodyAccMag_mean = tBodyAccMag.mean..,
    tBodyAccMag_std = tBodyAccMag.std..,
    tGravityAccMag_mean = tGravityAccMag.mean..,
    tGravityAccMag_std = tGravityAccMag.std..,
    tBodyAccJerkMag_mean = tBodyAccJerkMag.mean..,
    tBodyAccJerkMag_std = tBodyAccJerkMag.std..,
    tBodyGyroMag_mean = tBodyGyroMag.mean..,
    tBodyGyroMag_std = tBodyGyroMag.std..,
    tBodyGyroJerkMag_mean = tBodyGyroJerkMag.mean..,
    tBodyGyroJerkMag_std = tBodyGyroJerkMag.std..,
    fBodyAcc_x_mean = fBodyAcc.mean...X,
    fBodyAcc_y_mean = fBodyAcc.mean...Y,
    fBodyAcc_z_mean = fBodyAcc.mean...Z,
    fBodyAcc_x_std = fBodyAcc.std...X,
    fBodyAcc_y_std = fBodyAcc.std...Y,
    fBodyAcc_z_std = fBodyAcc.std...Z,
    fBodyAccJerk_x_mean = fBodyAccJerk.mean...X,
    fBodyAccJerk_y_mean = fBodyAccJerk.mean...Y,
    fBodyAccJerk_z_mean = fBodyAccJerk.mean...Z,
    fBodyAccJerk_x_std = fBodyAccJerk.std...X,
    fBodyAccJerk_y_std = fBodyAccJerk.std...Y,
    fBodyAccJerk_z_std = fBodyAccJerk.std...Z,
    fBodyGyro_x_mean = fBodyGyro.mean...X,
    fBodyGyro_y_mean = fBodyGyro.mean...Y,
    fBodyGyro_z_mean = fBodyGyro.mean...Z,
    fBodyGyro_x_std = fBodyGyro.std...X,
    fBodyGyro_y_std = fBodyGyro.std...Y,
    fBodyGyro_z_std = fBodyGyro.std...Z,
    fBodyAccMag_mean = fBodyAccMag.mean..,
    fBodyAccMag_std = fBodyAccMag.std..,
    fBodyAccJerkMag_mean = fBodyBodyAccJerkMag.mean..,
    fBodyAccJerkMag_std = fBodyBodyAccJerkMag.std..,
    fBodyGyroMag_mean = fBodyBodyGyroMag.mean..,
    fBodyGyroMag_std = fBodyBodyGyroMag.std..,
    fBodyGyroJerkMag_mean = fBodyBodyGyroJerkMag.mean..,
    fBodyGyroJerkMag_std = fBodyBodyGyroJerkMag.std..
  )


# ------------------------------------------------------------------
# create a new dataset with the average
# of each variable for each activity and each subject

## create the dataset
avg_dataset <- dataset %>% group_by(subject_id, activity_name) %>% summarise_each(funs(mean))

## update the column names for the averaged variables
tmpColnames <- colnames(avg_dataset)
tmpColnames <- tmpColnames[-match(c("subject_id", "activity_name"), tmpColnames)]
tmpColnames <- sapply(tmpColnames, function(x) sprintf("avg(%s)", x))
colnames(avg_dataset) <- c("subject_id", "activity_name", tmpColnames)

## write the dataset as text file
write.table(avg_dataset, "avg_dataset.txt", row.name = F)