library (dplyr)

#Download file from URL. Skip if already don=wnloaded before
if (!file.exists("Assignment-Data.zip")){
    fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileurl, "Assignment-Data.zip")
}  

# Unzip file if not done before
if (!file.exists("UCI HAR Dataset")) { 
    unzip("Assignment-Data.zip") 
}


#Reading all necessary datasets
features=read.table("./UCI HAR Dataset/features.txt",col.names = c("code","Feature")) # variables names
activities=read.table("./UCI HAR Dataset/activity_labels.txt",col.names = c("ActivityId","Activityname"))

testdata=read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$Feature)
testactivities=read.table("./UCI HAR Dataset/test/y_test.txt",col.names = c("Activity"))
testsubjects=read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = c("Subject"))

traindata=read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$Feature)
trainactivities=read.table("./UCI HAR Dataset/train/y_train.txt",col.names = c("Activity"))
trainsubjects=read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = c("Subject"))

#Merge the training & test datsets into one dataset
testdata=cbind(testsubjects,testactivities,testdata)
traindata=cbind(trainsubjects,trainactivities,traindata)
Merged_Data=rbind(testdata,traindata)

#Extracts only the measurements on the mean and standard deviation for each measurement.
Merged_Data =Merged_Data[,c(1,2,grep("mean\\.\\.\\.*|std\\.\\.\\.*",names(Merged_Data)))]

# Use Descriptive Activity Names to name activities
Merged_Data$Activity=factor(Merged_Data$Activity,1:6,activities$Activityname)

# Assign Descriptive variable names to dataset
names(Merged_Data)=gsub("\\.\\.\\.", "()-", names(Merged_Data))
names(Merged_Data)=gsub("\\.\\.", "()", names(Merged_Data))
names(Merged_Data)=gsub(".mean", "-Mean", names(Merged_Data))
names(Merged_Data)=gsub(".std", "-SD", names(Merged_Data))
names(Merged_Data)=gsub("^t", "Time", names(Merged_Data))
names(Merged_Data)=gsub("^f", "Frequency", names(Merged_Data))
names(Merged_Data)=gsub("Acc", "Accelerometer", names(Merged_Data))
names(Merged_Data)=gsub("Gyro", "Gyroscope", names(Merged_Data))
names(Merged_Data)=gsub("Mag", "Magnitude", names(Merged_Data))
names(Merged_Data)=gsub("BodyBody", "Body", names(Merged_Data))
names(Merged_Data)=gsub("BodyBody", "Body", names(Merged_Data))

#Tidy data set with the average of each variable for each activity and each subject.
TidyData=Merged_Data %>%group_by(Subject, Activity) %>% summarize_all(mean)

#Write the result out to txt file
write.table(TidyData, "TidyDataSet.txt", row.name=FALSE)

