#Part 1

X <- rbind(x_test,x_train) #binds both X datasets on top of each other
Y <- rbind(y_test,y_train) #binds both y datasets on top of each other
Subject <- rbind(subject_test, subject_train) #binds the subject ids x and y datasets on top of each other
MergedData <- cbind(Subject,X,Y) #merge all the previous datasets into one single data frame

#Part2
#creates a new data frame only with Mean and STD
MeanSTD <- MergedData %>% select(contains("Mean"), contains("mean"), contains("std"))

#Part3
#Substitutes the codes for their respective activities, taken from the activities dataset
MergedData$code <- activities[MergedData$code, 2]

#Part4
#substitutes abreviations for their full names
names(MergedData)<-gsub("code", "Activity", names(MergedData))
names(MergedData)<-gsub("Acc", "Accelerometer", names(MergedData))
names(MergedData)<-gsub("Gyro", "Gyroscope", names(MergedData))
names(MergedData)<-gsub("BodyBody", "Body", names(MergedData))
names(MergedData)<-gsub("Mag", "Magnitude", names(MergedData))
names(MergedData)<-gsub("^t", "Time", names(MergedData))
names(MergedData)<-gsub("^f", "Frequency", names(MergedData))
names(MergedData)<-gsub("tBody", "TimeBody", names(MergedData))
names(MergedData)<-gsub("-mean()", "Mean", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("-std()", "STD", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("-freq()", "Frequency", names(MergedData), ignore.case = TRUE)
names(MergedData)<-gsub("angle", "Angle", names(MergedData))
names(MergedData)<-gsub("gravity", "Gravity", names(MergedData))

#Part5
#Average values for each subject grouped by activity
FinalData <- MergedData %>%
  group_by(subject, Activity) %>%
  summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
