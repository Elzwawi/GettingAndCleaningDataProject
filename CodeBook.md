<h2> This file describes the variables, the data, and any transformations or work that were used to clean up the data.</h2> 


## Data
+ *Source of the data*:    
   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
    
+ *Direct download link of the data*:              
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Processing steps
The following processes were performed in sequence using the run_analysis.R script 

+ Read X_train.txt, y_train.txt and sbject_train.txt from the "./data/train" folder and store them in trainSet, trainLabels and trainSubjects variables respectively.

+ Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in testSet, testLabels and testsubjects variables respectively.

+ Combine testSet with trainSet in one data frame "mData". Combine testLabels with trainLabels in one data frame "mLabel". Combine testSubjects with trainSubjects in one data frame "mSubject".

+ Reading in the features.txt file and storing the data in a variable called features. Then determining the indices of the standard deviation and the mean of the measurements (66 columns) and creating a new subset of "mData" containing only Std and mean data. 

+ Improving readability and cleaning the column names of the subset by removing "()" and "-" symbols in the names, as well as converting the first letter of "mean" and "std" to upper case letters.

+ Reading the activity_labels.txt storing the data in a variable called "activity".

+ Cleaning the activity names in the second column of activity. Converting all names to lower cases. Removing underscore between letters and converting the letter after underscore to upper case.

+ Changing the values of mLabel according to the activity data frame.

+ Combine the mSubject, mLabel and mData by column in one data frame "cleanedData". Naming the first two columns, "subject" and "activity". The "subject" variable contains participants IDs, integers from 1 to 30. The "activity" variable contains the 6 kinds of activity names. The last 66 variables contain mean and std of sensor measurements ranging from -1 to 1.

+ Writing out the cleanedData to "merged_data.txt" file in current working directory.

+ Generating a second tidy data set containing the average of each measurement for each activity and each subject. 30 subjects and 6 activities result in 180 combinations of the two. For each combination, the mean of each measurement is calculated. This is performed by a cascaded for-loop. The resulting data frame will be 180x68 in size.

+ Write the result out to "tidy_data_with_means.txt" file in current working directory. 
