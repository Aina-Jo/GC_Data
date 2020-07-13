Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Combined is the tidy data produced after going through the first 4 steps of the course project. It contains 10299 observations and 68 variables.
The first column refers to each subject that did the experiment.
Column 2~67 are the feature variables(mean and std of the whole feature variables).
The last column is refers to the activity that the subjects were doing, including WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
tidydata is the tidy data produced after going through all 5 steps of the course project. It contains 180 observations and 68 variables. Where the first column is the subject id, second column is the activity and the rest are the average of each feature variables.
