Class Project - Oct2014
=================================================

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The repository will contain:
1. a tidy data set, 
2. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
3. the script that processed the data and created the analysis and
4. this README.md file.in 

The source file contains wearable computing data collected from the accelerometers from the Samsung Galaxy S smartphone
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data for this project was located:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## run_analysis R Script

A single R script called run_analysis.R that does the following. 
  1. Merges the training and the test sets to create one data set. 
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set 
  4. Appropriately labels the data set with descriptive variable names. and 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In addition to the above requrements, this script also downloads the zip file and unzips it into the individual files into it's own directory "UCI HAR Dataset" under the working directory.  To run this script, you should only have to open the R environment on this folder and type:  *source('./run_analysis.R')*

This will dowload the zip files, read the raw data and process it by following following the instructions of the assignment. The code is fairly well (IMHO) documented and it follows a straightforward approach of:
- reading all of the files, 
- creating the train and test tables with appropriate column headings, 
- row binding the two tables into a single dataset, 
- stripping out any column that have mean or std in the column hame and 
- performing the mean funciton on those remaining columns usinng the aggregate command for a by subject by activity table.

This final table is saved as it's owns tidy dataset called: [tidydata.txt](data/tidydata.txt). See the [CodeBook](CodeBook.md) for details on the variables, input datasets and transformations applied.

**NOTE:** A quick inspection of the column names indicated mean was found as mean and Mean in the column heads.  Just to be safe, I used all combinations of upper and lower case to make up mean (e.g. MeAn) and std (e.g. sTd).  This is probably overkill, but what the heck.

## Output Datasets

The [Data folder](data)  in this repository contains these 4 files:
  1. [all_dataset.csv](data/all_dataset.csv) - the combined dataset with both train and test data included in it.  It also contains the subject and activity columns added to it
  2. [features.txt](data/features.txt) - The file that lists all feature (column heads) that contain mean or std
  3. [subsetdata.csv](data/subsetdata.csv) - The subset of all_dataset.csv that only has the mean or std columns
  4. [tidydata.txt](data/tidydata.txt) - The fifth activity final tidy dataset that contains the averages of the mean or std columns by activity by subject


