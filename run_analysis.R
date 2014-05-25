
## Step.1: reading all data sets
# Train set
trainSet <- read.table("./data/train/X_train.txt")      
trainLabels <- read.table("./data/train/y_train.txt")
trainSubjects <- read.table("./data/train/subject_train.txt")

# Test set
testSet <- read.table("./data/test/X_test.txt")
testLabels <- read.table("./data/test/y_test.txt")
testSubjects <- read.table("./data/test/subject_test.txt")

## Merging files
mData <- rbind(trainSet, testSet)  # Merging data
mLabel <- rbind(trainLabels, testLabels)  # Merging labels
mSubject <- rbind(trainSubjects, testSubjects)  # Merging subjects

## Step2. Extracting only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./data/features.txt")   # Reading the 561 feature vector
indicesOfMeanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])  # determining the indices of mean and std
mData <- mData[, indicesOfMeanStd]  # filtering the data set
names(mData) <- gsub("\\(\\)", "", features[indicesOfMeanStd, 2]) # removing "()"
names(mData) <- gsub("mean", "Mean", names(mData)) # improving readability (capitalizing M)
names(mData) <- gsub("std", "Std", names(mData)) # improving readability (capitalizing s)
names(mData) <- gsub("-", "", names(mData)) # remove "-" in column names

# Step3. Assigning descriptive names to the activities in the data set
activity <- read.table("./data/activity_labels.txt")  # reading the activity file
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))   # removing underscores
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))  # walkingUpstairs
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))  # walkingDownstairs
activityLabel <- activity[mLabel[, 1], 2] # temp variable creating labels
mLabel[, 1] <- activityLabel              # creating labels
names(mLabel) <- "activity"

# Step4. Appropriately labels the data set with descriptive activity # names.
names(mSubject) <- "subject"              # creating labels for the subjects
cleanedData <- cbind(mSubject, mLabel, mData)   # merging data, subjects and labels
write.table(cleanedData, "merged_data.txt") # wrting out the first dataset

# Step5. Creating a second tidy data set with the average of each variable for each activity and each subject.
subjectLength <- length(table(mSubject)) 
activityLength <- dim(activity)[1] 
columnLength <- dim(cleanedData)[2]
tidy <- matrix(NA, nrow=subjectLength*activityLength, ncol=columnLength)
tidy <- as.data.frame(result)
colnames(tidy) <- colnames(cleanedData)

row <- 1
for(i in 1:subjectLength) {
        for(j in 1:activityLength) {
                tidy[row, 1] <- sort(unique(mSubject)[, 1])[i]
                tidy[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                tidy[row, 3:columnLength] <- colMeans(cleanedData[bool1&bool2, 3:columnLength])
                row <- row + 1
        }
}

head(tidy)
write.table(tidy, "tidy_data_with_means.txt") # write out the 2nd dataset

