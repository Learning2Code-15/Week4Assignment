The TidyData.R script converts the raw data provided to tidy data as per the 5 steps provided in course assignment details:

Download the file as Assignment-Data.zip and unzip the dataset as UCI HAR Dataset
Read the data of each file to variables

features - features.txt : 561 rows, 2 columns
The features measured from smartphone (Samsung Galaxy S II) on the waist using its embedded accelerometer and gyroscope 

activities - activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)

testdata - test/X_test.txt : 2947 rows, 561 columns
contains recorded feature measurements for tests on subjects 

testactivities - test/y_test.txt : 2947 rows, 1 columns
contains codes of activities done during tests on subjects

testsubjects - test/subject_test.txt : 2947 rows, 1 column
contains code of test subjects for each test conducted

traindata - test/X_train.txt : 7352 rows, 561 columns
contains recorded feature measurements on training of subjects 

trainactivities - test/y_train.txt : 7352 rows, 1 columns
contains codes of activities done during training of subjects

trainsubjects - test/subject_train.txt : 7352 rows, 1 column
contains subject code for train subjects


Merges the training and the test sets to create one data set
testdata(2947 rows, 563 columns) is created by adding testsubjects and testactivites as colomns to existing testdata(2947 rows, 561 columns) using rbind() function
traindata(7352 rows, 563 columns) is created by adding trainsubjects and trainactivites as colomns to existing traindata(7352 rows, 561 columns) using rbind() function
Merged_Data (10299 rows, 563 column) is created by adding traindata and testdata together using rbind() function

Extracts only the measurements on the mean and standard deviation for each measurement
Merged_Data (10299 rows, 68 columns) is created by selecting colomns which match the pattern for mean or std in variable names of Merged_Data 

Use Descriptive Activity Names to name activities in data set
Codes in Activity column of the Merged_Data is replaced with activity name taken from second column of the activities variable

Assign Descriptive variable names to dataset
All .. in column’s name replaced with ()
All ... in column’s name replaced with ()-
All .mean in column’s name replaced with -Mean
All .std in column’s name replaced with -Std
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All f in start of column’s name replaced by Frequency
All t in start of column’s name replaced by Time

Tidy data set with the average of each variable for each activity and each subject.
TidyData (180 rows, 68 columns) is created by grouping MergedData by Subject and Activity and taking mean of measurements of each activity and each subject post grouping.
Export TidyData into TidyDataSet.txt file.

