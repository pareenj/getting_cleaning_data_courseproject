library(plyr)

## 0. Reading all the data
setwd("E:/CourseraDataScience/Working Directory/UCI HAR Dataset/test")
testset <- read.table("X_test.txt")
testlabel <- read.table("y_test.txt")
testsub <- read.table("subject_test.txt")
setwd("E:/CourseraDataScience/Working Directory/UCI HAR Dataset/train")
trainset <- read.table("X_train.txt")
trainlabel <- read.table("y_train.txt")
trainsub <- read.table("subject_train.txt")
setwd("E:/CourseraDataScience/Working Directory/UCI HAR Dataset")
featureset <- read.table("features.txt")
activitylabel <- read.table("activity_labels.txt")

## 1. Merge Data
dataset <- rbind(trainset, testset)
datasub <- rbind(trainsub, testsub)
datalabel <- rbind(trainlabel, testlabel)

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
mean_std <- grep("-(mean|std)\\(\\)", featureset[, 2])
dataset <- dataset[,mean_std]
names(dataset) <- featureset[mean_std, 2]

## 3. Use descriptive activity names to name the activities in the data set
datalabel[, 1] <- activitylabel[datalabel[, 1], 2]
names(datalabel) <- "activity"
names(datasub) <- "subject"
datafinal <- cbind(dataset, datalabel, datasub)

## 4. Appropriately label the data set with descriptive variable names.
names(datafinal)<-gsub("^t", "time", names(datafinal))
names(datafinal)<-gsub("^f", "frequency", names(datafinal))
names(datafinal)<-gsub("Acc", "Accelerometer", names(datafinal))
names(datafinal)<-gsub("Gyro", "Gyroscope", names(datafinal))
names(datafinal)<-gsub("Mag", "Magnitude", names(datafinal))
names(datafinal)<-gsub("BodyBody", "Body", names(datafinal))
names(datafinal)<-gsub("\\.mean",".Mean", names(datafinal))
names(datafinal)<-gsub("\\.std",".StandardDeviation", names(datafinal))

## 5.Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidydata <- ddply(datafinal, c("subject", "activity"), function(x) colMeans(x[, 1:66]))
write.table(tidydata, file = "TidyData.txt", row.names = FALSE )
