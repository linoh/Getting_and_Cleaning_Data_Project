# Merges the training and the test sets to create one data set.
# create working directory
#      
setwd("D:/Assignment/Getting and Cleaning Data/UCI HAR Dataset/")
getwd()
#
#Read X_train.txt, y_train.txt and subject_train.txt from the "train" folder and store them in trainData, 
#trainLabel and trainSubject variables respectively.

trainData <- read.table("train/X_train.txt")
dim(trainData) 
head(trainData)
trainLabel <- read.table("train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("train/subject_train.txt")

#Read X_test.txt, y_test.txt and subject_test.txt from the "test" folder and store them in testData, testLabel and testsubject variables respectively.

testData <- read.table("test/X_test.txt")
dim(testData)
testLabel <- read.table("test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("test/subject_test.txt")

#Assign joinData from concatenated of testdata to traindata to generate a data frame
#Assign joinLabel from concatenated of testLabel to trainLabel to generate a data frame
#Assign joinSubject from concatenate testSubject to trainSubject to generate a data frame

joinData <- rbind(trainData, testData)
dim(joinData)
joinLabel <- rbind(trainLabel, testLabel)
dim(joinLabel)
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)

#Read the features.txt file from the "UCI HAR Dataset" folder and store the data in a variable named features. 
#Extract only the measurements on the mean and standard deviation. 

features <- read.table("features.txt")
dim(features) 
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices)

#Clean the column names of the subset. Remove the "()" and "-" symbols in the names. 
#Assign capital letter "M" and "S" respectively to the "mean" and "std".

joinData <- joinData[, meanStdIndices]
dim(joinData) 
names(joinData) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinData) <- gsub("mean", "Mean", names(joinData))
names(joinData) <- gsub("std", "Std", names(joinData))
names(joinData) <- gsub("-", "", names(joinData))

#Read the activity_labels.txt file from the "UCI HAR Dataset" folder and store the data in a variable called activity.

activity <- read.table("activity_labels.txt")

#Clean the activity names in the second column of activity, first change all names to lower cases. If the name contains an underscore in between letters, 
#then remove the underscore and capitalize the letter immediately after the underscore.

activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"


# Combine the joinSubject, joinLabel and joinData by column to get a new cleaned data frame. 

names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
dim(cleanedData)

#Write the cleanedData  to "merged_data.txt" file in working directory.

write.table(cleanedData, "merged_data.txt") 

# Creates a second tidy independent data set with the average of each variable for each activity and each subject. 

subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
for(j in 1:activityLen) {
result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
result[row, 2] <- activity[j, 2]
bool1 <- i == cleanedData$subject
bool2 <- activity[j, 2] == cleanedData$activity
result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
row <- row + 1
}
}
head(result)

# Write the result to "data_with_means.txt" file in working directory.

write.table(result, "datawithmeans.txt")
