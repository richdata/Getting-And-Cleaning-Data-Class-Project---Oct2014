## One of the most exciting areas in all of data science right now is wearable 
## computing - see for example this article . Companies like Fitbit, Nike, and 
## Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data collected from the 
## accelerometers from the Samsung Galaxy S smartphone. A full description is available 
## at the site where the data was obtained: 
##       
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##
##Here are the data for the project: 
##        
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
## You should create one R script called run_analysis.R that does the following. 
## 1) Merges the training and the test sets to create one data set.
## 2)Extracts only the measurements on the mean and standard deviation for each 
##   measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#Initial Housekeeping to set the working directory, 
#create the data directory if it doesn't exist and get the file.

if(!file.exists("./data")){dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip?accessType=DOWNLOAD"

# create the placeholder file
tf <- "./data/getdata-projectfiles-FUCI-HAR-Dataset.zip"

# download the zip file (remember, it is a binary file)
download.file(fileURL, tf, mode="wb")

# get the names of the files in the zip archive
fname <- unzip(tf, list=TRUE)$Name

#now extract them
unzip(tf,fname)

## Get the features
features <- read.table('UCI HAR Dataset/features.txt',col.names=c('number', 'Feature'))

## Get the activities
activities <- read.table('UCI HAR Dataset/activity_labels.txt',col.names=c('number', 'Activity'))

### read labels for each table
testlabels <- read.table('UCI HAR Dataset/test/y_test.txt', col.names="Activity")
testlabels <- activities$Activity[testlabels$Activity]
testlabels <- as.data.frame (testlabels)
names(testlabels) <-"Activity"

trainlabels <- read.table('UCI HAR Dataset/train/y_train.txt', col.names="Activity")
trainlabels <- as.data.frame(activities$Activity[trainlabels$Activity])
trainlabels <- as.data.frame (trainlabels)
names(trainlabels) <-"Activity"

## Because each entry in each table is associated with a specific subject and we need to
## do subject analysis later, we need to identify who the subject was.  The number 
## identifying the subject are in files called subject_test.txt and subject_train.txt


## Get the subject and adds to main tables
testdatasubject <- read.table('UCI HAR Dataset/test/subject_test.txt', 
                              col.names=c("Subject"))
traindatasubject <-read.table('UCI HAR Dataset/train/subject_train.txt', 
                            col.names=c("Subject"))



## Each entry in each table is associated with a specific label. The labels 
## identifiers are stored on the y_train.txt and y_test_txt file. The file 
## activity_labels.txt store the name of each label.


## load the raw data
testdata  <- read.table('UCI HAR Dataset/test/X_test.txt', col.names=features$Feature)
traindata <- read.table('UCI HAR Dataset/train/X_train.txt', col.names=features$Feature)


##
##
## All datasets are in current working directory, let's get started
##
#-----------------------------------------------------------------------------------
##
## 1) Merges the training and the test sets to create one data set.
##
##

#first create the full wide tables adding subject & activity data to them

testdata <- cbind(testdatasubject, testlabels, testdata)
traindata <- cbind(traindatasubject, trainlabels, traindata)

#next create the full deep tables putting test & train data together
alldata <- rbind(testdata, traindata)

#and save it
write.csv(alldata, "./data/all_dataset.csv", row.names=FALSE)

##
#-----------------------------------------------------------------------------------
##
## 2)Extracts only the measurements on the mean and standard deviation for each 
##   measurement. 
##

## identify which columns contain 'mean' or 'std' since some of the columns had
## mean as 'Mean' need to take that into consideration as well and any other spell errors
pattern <- "[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]"
JustMeanStdCols <- names(alldata)[grep(pattern, names(alldata))]
## Save the name of the columns used
write.table(JustMeanStdCols, './data/features.txt', quote=FALSE)

## Subset the data with the mean_std_cols + `subject` and `activity`
OnlyMeanAndStdData <- alldata[c('Subject', 'Activity',JustMeanStdCols)]
write.csv(OnlyMeanAndStdData, "./data/subsetdata.csv")

##
##  Ok, now that the data is appropriately subsetted to only those columns that
##  Have either a mean or std in it, time to wrap things up.  Because the columns
##  are already labeled, 3 & 4 are inherently completed
##
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) From the data set in step 4, creates a second, independent tidy data set with 
##    the average of each variable for each activity and each subject.
##
##
##  Aggregate by subject id (Subject) and activity
AggregatedData <- aggregate(. ~ Subject + Activity, data=OnlyMeanAndStdData, FUN = mean)


##Create the file
write.table(AggregatedData, "./data/tidydata.txt", sep="\t", row.name=FALSE )

