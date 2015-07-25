###The run_analysis.R script performs the following steps to clean the data:

- create working directory
      
- setwd("D:/Assignment/Getting and Cleaning Data/UCI HAR Dataset/")

- Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and assign them to trainData, trainLabel and trainSubject variables respectively.

- Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and assign them to testData, testLabel and testsubject variables respectively.

- Concatenate testData to trainData to generate a data frame, joinData; 
- Concatenate testLabel to trainLabel to generate a data frame,joinLabel; 
- Concatenate testSubject to trainSubject to generate a data frame, joinSubject.

- Read the features.txt file from the "/data" subdirectory and store the data in a variable called features. 

- Extract only the measurements on the mean and standard deviation. We get a subset of joinData with the 66 corresponding columns.

- Clean the column names of the subset. remove the "()" and "-" symbols in the names, rename the first letter of "mean" and "std" to a capital letter "M" and "S" respectively.

- Read the activity_labels.txt file from the "./data"" subdirectory and store the data in a variable called activity.

- Clean the activity names in the second column of activity. convert all names to lower cases. Remove the underscore sign, if any and convert the letter to upper case after the underscore.

- Transform the values of joinLabel according to the activity data frame.

- Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame, cleanedData. 
- Properly name the first two columns, "subject" and "activity". 
- The "subject" column contains integers that range from 1 to 30 inclusive; 
- The "activity" column contains 6 kinds of activity names; 
- The last 66 columns contain measurements that range from -1 to 1 exclusive.


***Write the cleaned Data to "merged_data.txt" file in working directory***


####Generate a second independent tidy data set with the average of each measurement for each activity and each subject. 

There are 180 combinations derived from 30 unique subjects and 6 unique activities. 
The mean value for each measurment was calculated for each corresponding combination.

***Write the result to "datawithmeans.txt" file in current working directory***



