Introduction
==================================================================

This is the CodeBook for the Programming Assignment of the course Getting and Cleaning the Data. 
The objective of this Assignment is to create a tidy data set, starting from the Human Activity Recognition Using Smartphones Dataset (dowloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on 2017-10-30).


The Human Activity Recognition Using Smartphones Dataset
==================================================================

The Human Activity Recognition Using Smartphones Dataset includes several measurements of activity-related variables for a group of 30 volunteers each performing six different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). Please consult the README.txt provided with the dataset for a detailed description of the original dataset. 


The dataset “tidy_data.csv”
==================================================================

The provided “tidy_data.csv” contains the average, for each activity and each subject, of the mean and of the standard deviation of the different activity-related variables. 
The dataset is constituted by 180 rows and 68 columns. 

- Each row corresponds to one activity and to one subject: 
  6 different activities performed by 30 different subjects. 
- Column 1 is the activity identifier 
  (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING);
- Column 2 is the subject identifier and ranges from 1 to 30;
- Columns 3 to 68 contain the averages.


The data-processing to obtain the dataset “tidy_data.csv”
==================================================================

The tidy_data.csv dataset is obtained from the Human Activity Recognition Using Smartphones Dataset by executing the run_analysis.R script. The script applies the following data-processing:

1. Merges the training and test data of the Human Activity Recognition Using Smartphones Dataset, to create a new data.frame, called data. 

2. Extracts the measurements of the mean and of the standard deviation for the activity-related variables retaining the information on the type of activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) and on the subject (“1” to ”30”) who performed the activity. The results are stored in a new data.frame called data2. 

3. Computes the average of the different measurements of the mean and standard deviation of each activity-related variable for each activity and for each subject. The results are stored in a new data.frame, called data, and saved as “.csv” file. 

IMPORTANT NOTE: The path to the files contained in the local copy of Human Activity Recognition Using Smartphones Dataset, must be adapted before running the script.