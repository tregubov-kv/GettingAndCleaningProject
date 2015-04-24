##PROJECT

library(data.table)
library(dplyr)

#read original code lists
features <- read.table(".//data//UCI HAR Dataset//features.txt")
activity_labels <- read.table(".//data//UCI HAR Dataset//activity_labels.txt")

#prepare TEST data frame
test <- read.table(".//data//UCI HAR Dataset//test//X_test.txt") #read raw data
names(test) <- as.character(features[,2]) #form measure names string
measures.needed <- c(grep("mean()",names(test)),grep("std()",names(test))) #choose measure names containing "mean" and "std"
test <- test[,names(test)[measures.needed]] #remove all other measures
subj.test <- read.table(".//data//UCI HAR Dataset//test//subject_test.txt") # read subject's ids corrsponding to data rows
act.test <- read.table(".//data//UCI HAR Dataset//test//Y_test.txt") # read activity's ids  corrsponding to data rows
test <- cbind(subj.test, activity_labels[act.test[,],2], test) #bind subjects and activities to data rows, also substitute activity ids with activity names

#set proper column names
names(test)[1] = "subject" 
names(test)[2] = "activity"


#prepare TRAIN data frame

train <- read.table(".//data//UCI HAR Dataset//train//X_train.txt") #read raw data
names(train) <- as.character(features[,2]) #form measure names string
measures.needed <- c(grep("mean()",names(train)),grep("std()",names(train))) #choose measure names containing "mean" and "std"
train <- train[,names(train)[measures.needed]] #remove all other measures
subj.train <- read.table(".//data//UCI HAR Dataset//train//subject_train.txt") # read subject's ids corrsponding to data rows
act.train <- read.table(".//data//UCI HAR Dataset//train//y_train.txt")# read activity's ids  corrsponding to data rows
train <- cbind(subj.train, activity_labels[act.train[,],2], train) #bind subjects and activities to data rows, also substitute activity ids with activity names

#set proper column names
names(train)[1] = "subject"
names(train)[2] = "activity"

## append TEST and TRAIN data
complete <- rbind(train, test)

# some formating for dataframe names
names(complete)<-sub("[(]","",names(complete))
names(complete)<-sub("[)]","",names(complete))
names(complete)<-sub("[-]","",names(complete))
names(complete)<-sub("[-]","",names(complete))
names(complete)<-sub("mean","MEAN",names(complete))
names(complete)<-sub("std","STD",names(complete))

# transform data to vertical format
complete.melt <- melt(complete,
                      id=c("subject", "activity"),
                      measure.vars=names(complete)[3:length(names(complete))]
)

# prepare tidy data with measures averages per subject, activity
tidy.data <- dcast(complete.melt, subject + activity ~ variable, mean)

# save tidy data file
write.table(tidy.data, file = "tidy_data.txt", row.name=FALSE)  