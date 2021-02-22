The run_analysis.R script creates a tidy data set following the 5 steps described in the Getting 
and Cleaning Data Course Project.

1. Checking for the directory: 
       
    * Checking for the directory "data" where the downloaded zip file was extracted. The extracted 
      folder was under the name "UCI HAR Dataset".

2. Assigning each data sets to various variables: 
       
    * activity_labels = activity_labels.txt : 6 records and 2 fields.
      List of activities performed by each person while wearing a smartphone on the waist with  
      their respective codes(labels).
    
    * features = features.txt : 561 records and 2 fields.
      List of all features. The features selected for this database come from the accelerometer 
      and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
      
    * subject_test = test/subject_test.txt : 2947 records and 1 field.
      Each observation is the test data of 9 out of 30 volunteer subjects being observed.
      
    * x_test = test/X_test.txt : 2947 records and 561 fields.
      Contains the test data records.
      
    * y_test = test/y_test.txt : 2947 records and 1 field.
      Contains the test Codes(labels) of the test data.
      
    * subject_train = train/subject_train.txt : 7352 records and 1 field.
      Each observation is the train data of 21 out of 30 volunteer subjects being observed.
      
    * x_train = train/X_train.txt : 7352 records and 561 fields.
      Contains the train data records.
      
    * y_train = train/y_train.txt : 7352 records and 1 field.
      Contains the train Codes(labels) of the train data.
      
3. To merge the training and the test sets into one single data set:

    * x : 10299 records and 561 fields. It is created by merging x_train and x_test
      using rbind() function.
    
    * y : 10299 records and 1 field. It is created by merging y_train and y_test
      using rbind() function.
    
    * subject : 10299 records and 1 field. It is created by merging subject_train and
      subject_test using rbind() function.
    
    * Merged_data : 10299 records and 563 fields. It is created my merging subject, y and x
      using cbind function.

4. To extract only the measurements on the mean and standard deviation for each measurement:

    * Tidy_data : 10299 records and 88 fields. It is created by subsetting the Merged_data
      selecting only columns, i.e., Subject, Code and the measurements on the mean and standard
      deviation for each measurement.
    
5. To use descriptive activity names to name the activities in the data set:

    * Entire numbers in "Code" column of the Tidy_data replaced with corresponding activity taken
      from second column of the "activity_labels" variable.
    
6. To appropriately label the data set with descriptive variable names:

    * "Code" column in Tidt_data renamed into "Activities".
    
    * All "Acc" in column's name replaced by "Accelerometer".
    
    * All "Gyro" in column's name replaced by "Gyroscope".
    
    * All "BodyBody" in column's name replaced by "Body".
    
    * All "Mag" in column's name replaced by "Magnitude".
    
    * All start with character "t" in column's name replaced by "Time".
    
    * All start with character "f" in column's name replaced by "Frequency".
    
    * All "tBody" in column's name replaced by "TimeBody".
    
    * All "-mean()" in column's name replaced by "Mean".
    
    * All "-std()" in column's name replaced by "Standard Deviation".
    
    * All "-freq()" in column's name replaced by "Frequency".
    
    * All "angle" in column's name replaced by "Angle".
    
    * All "gravity" in column's name replaced by "Gravity".

7. To create a second, independent tidy data set with the average of each variable for each
   activity and each subject:
   
    * Tidy_data2 : 180 records and 88 fields. It is created by summarising "Tidy_data" taking the
      means of each variable for each activity and each subject, after grouped by subject and
      activity.
    
    * Saved the Tidy_data2 as a txt file under the name "TidyData" using the write.table()              function.
    
    