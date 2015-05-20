# Get-CleanDataProject

## This repository contains the following folders/files:

- README.md

- run_analysis.R
contains the script for producing the tidy dataset
This script has to run with the working directory containing the folder "UCI HAR Dataset"
It loads the train set and test set from the dataset
downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
,
and combines them to create one dataset.
Then only the subject_id, activity_id, and the measurements on the mean and standard deviation for each feature
are retained.
Finally, the output dataset is produced by averaging each variable for each activity and each subject.

- CodeBook.md
contains the description on the variables and process to recreate the dataset