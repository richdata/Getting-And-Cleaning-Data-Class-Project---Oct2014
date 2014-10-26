---
title: "Codebook"
output: html_document
---
 This code book describes the variables, the data, and any transformations or work that you performed to clean up the data.
 
 ##Variables & Input Datasets
 The test/train datasets contained 561 variables as described here:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
 The test/train data also had a Y dataset that described the activities associated with each observation found in the test/train X datasets.  These variables were numeric codes for the activities.
 
 The activity_label.txt dataset contained the 6 text values that equated to the numeric activity coes in the Y datasets for test/train observations.
 
 The features.txt dataset contained all 561 vaariables in text format for the data to be read in the test/train datasets
 
 Finally, the subject_test and subject_train datasets found in the test/train directories, contained a code to identify which subject the equivalent record in the test/train datasets performed that observation.  For example, the 5th record in the x_test dataset belonged to the 5th record in the subject_test dataset.
 
 Through the following tranformations, the datasets were combined and translated to add the subject identifier and a text equivalent of the activity code found in y_test/y_train datasets to improve readibility of the final tidy dataset.
 
##First transformation
The features, subject and activity datasets were given column headers when they were read in using the col.names parameter on the read command.

##Second Transformation
The raw data contained a numeric code to represent the activities for the observations.  To make this data in the observations more readable, the y_test, and y_train dataframes were converted from numeric to the equivalent text activity using the numeric code to subset the activity table.

##Third Transformation
Because the source files didn't have meaningful headers, by default, R creates generic V1, V2, ...Vn heading names.  To improve readability, the 561 fields found in the festures.txt file were used as column headers when the test/train data files were read into the respective dataframes using thecol.names parameter and the features data frame.

##Fourth Transformation
The subject id and activity fields were added to the test and train data frames through the use of the column bind command.  Subject and Activity were added to the beginning of the file.  This new dataframe now has 563 variables, the 561 from the original data set and the 2 additional ones (subject, activity)

##Fifth Transformation
The two data sets were combined into a single data frame using the rbind command.  This file was written to disk as an intermediary file.

##Sixth Transformation
The column headers of the combined data frame were used to create a single character vector of the 86 variables that contained any upper/lower case permutation of mean and std.  This character vector of the 86 variables was used along with 'Subject"and "Activity" to subset out only those fields that contained mean or std.  In addition, subject and activity were left in to allow grouping for the aggregate command later.

##Seventh and Final Transformation
The aggregate command was used to create the mean of the 86 variables from the above transformation grouped by subject and activity.  This final tidy dataset was saved to the hard drive as well.
