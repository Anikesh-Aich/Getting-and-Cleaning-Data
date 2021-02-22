library(dplyr)
# Checking for and/or creating directories

if(!file.exists("data")){
  dir.create("data")
}

# Assigning each datasets to various variables

activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", col.names = c("Code", "Activity"))
features <- read.table("data/UCI HAR Dataset/features.txt", col.names = c("Sl_no", "Signal_function_Direction"))
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", col.names = features$Signal_function_Direction)
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", col.names = "Code")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", col.names = features$Signal_function_Direction)
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", col.names = "Code")

# To merge the training and the test dataset into one single data set

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
Merged_data <- cbind(subject, y, x)

# To extract only the measurements on the mean and standard deviation for each measurement

Tidy_data <- Merged_data %>% select(Subject, Code , contains("mean"), contains("std"))

# To use descriptive activity names to name the activities in the data set

Tidy_data$Code <- activity_labels[Tidy_data$Code, 2]

# To appropriately label the data set with descriptive variable names

names(Tidy_data)[2] <- "Activities"
names(Tidy_data) <- gsub("Acc", "Accelerometer", names(Tidy_data))
names(Tidy_data) <- gsub("Gyro", "Gyroscope", names(Tidy_data))
names(Tidy_data) <- gsub("BodyBody", "Body", names(Tidy_data))
names(Tidy_data) <- gsub("Mag", "Magnitude", names(Tidy_data))
names(Tidy_data) <- gsub("^t", "Time", names(Tidy_data))
names(Tidy_data) <- gsub("^f", "Frequency", names(Tidy_data))
names(Tidy_data) <- gsub("tBody", "TimeBody", names(Tidy_data))
names(Tidy_data) <- gsub("-mean()", "Mean", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data) <- gsub("-std()", "Standard Deviation", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data) <- gsub("-freq()", "Frequency", names(Tidy_data), ignore.case = TRUE)
names(Tidy_data) <- gsub("angle", "Angle", names(Tidy_data))
names(Tidy_data) <- gsub("gravity", "Gravity", names(Tidy_data))

# To create a second, independent tidy data set with the average of each variable for each 
# activity and each subject.

Tidy_data2 <- Tidy_data %>%
    group_by(Subject, Activity) %>%
    summarise_all(funs(mean))
write.table(Tidy_data2, "TidyData.txt", row.name = FALSE)
