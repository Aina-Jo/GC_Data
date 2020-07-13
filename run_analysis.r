install.packages(c("reshape2", "data.table"))
library(data.table)

path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path(path, "DF.zip"))
unzip(zipfile = "DF.zip")

# Load activity labels + features

# Fread is similar to read.table but faster and more convenient. 
activityLabels <- fread(file.path(path, "UCIHAR/activity_labels.txt")
                        , col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCIHAR/features.txt")
                  , col.names = c("index", "featureNames"))

featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train datasets: this is the fastest method I found for now
train <- fread(file.path(path, "UCIHAR/train/X_train.txt"))[, featuresWanted, with = FALSE]
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCIHAR/train/Y_train.txt")
                         , col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCIHAR/train/subject_train.txt")
                       , col.names = c("Subject"))
train <- cbind(trainSubjects, trainActivities, train)

# Test datasets: 
test <- fread(file.path(path, "UCIHAR/test/X_test.txt"))[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCIHAR/test/Y_test.txt")
                        , col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCIHAR/test/subject_test.txt")
                      , col.names = c("Subject"))
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add labels
combined <- rbind(train, test)
head(combined)

# FACTORS
combined[["Activity"]] <- factor(combined[, Activity])
combined[["Subject"]] <- as.factor(combined[, Subject])

tidydata <- aggregate( . ~ Subject + Activity, data = combined, FUN = mean )
write.table( tidydata, "avedata.txt", row.names = FALSE )
