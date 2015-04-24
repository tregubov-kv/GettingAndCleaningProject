
run_analysis.R
==============

1.INPUT: Load, unzip and put folders in working directory (./R) using the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2.OUTPUT: tidy_data.txt saved in working directory (./R)

3.TRANSFORMATIONS:
	1) prepare TEST data frame
		1.1) read raw data set
		1.2) form measure names string
		1.3) choose measure names containing "mean" and "std" only
		1.4) remove all other measures
		1.5) read subject's ids corrsponding to data rows
		1.6) read activity's ids  corrsponding to data rows
		1.7) bind subjects and activities to data rows, also substitute activity ids with activity names
		1.8) set proper column names
	2) prepare TRAIN data frame
		repeat same steps as for TEST data frame
	3) append TEST and TRAIN data
	4) some formating for dataframe names
	5) transform data to vertical format
	6) prepare tidy data with measures averages per subject, activity
	7) save tidy data file
