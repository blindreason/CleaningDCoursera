
# Script for cleaning body measurement data
# Takes training and test data from a data set to:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# Read data into R objects

if(!exists("TrainX")) TrainX <- read.csv("X_train.txt",header=FALSE,sep="")
if(!exists("TrainY")) TrainY <- read.csv("y_train.txt",header=FALSE)

if(!exists("TestX"))  TestX <- read.csv("X_test.txt",header=FALSE,sep="")
if(!exists("TestY")) TestY <- read.csv("y_test.txt",header=FALSE)

if(!exists("SubjectTest"))  SubjectTest <- read.csv("subject_test.txt",header=FALSE)
if(!exists("SubjectTrain")) SubjectTrain <- read.csv("subject_train.txt",header=FALSE)

if(!exists("ActivityLabel")) ActivityLabel <- read.csv("activity_labels.txt",header=FALSE,sep="")

# Merge datasets into one

CombineX <- rbind(TrainX,TestX)
CombineY <- rbind(TrainY,TestY)
CombineSubject <- rbind(SubjectTrain,SubjectTest)

# Feature Load from features.txt
Feature <- read.csv("features.txt",header=FALSE,sep="")

names(CombineX) <- Feature$V2
names(CombineSubject) <- "SubjectID"
names(CombineY) <- "ActivityID"


# Find mean & std features in Feature
# Find_meanstd <- intersect(grep("mean\\(\\)|std\\(\\)",Feature$V2),
#                          grep("BodyBody",Feature$V2,invert=TRUE))

Find_meanstd <- grep("mean\\(\\)|std\\(\\)",Feature$V2)

# Filtered dataset with mean & std features

ExtractX <- CombineX[,Find_meanstd]

 TidyNames <- c("TimeAvg_BodyAcceleration_XAxis",
               "TimeAvg_BodyAcceleration_YAxis",
               "TimeAvg_BodyAcceleration_ZAxis",
               "TimeStandardDev_BodyAcceleration_XAxis",
               "TimeStandardDev_BodyAcceleration_YAxis",
               "TimeStandardDev_BodyAcceleration_ZAxis",
               "TimeAvg_GravityAcceleration_XAxis",
               "TimeAvg_GravityAcceleration_YAxis",
               "TimeAvg_GravityAcceleration_ZAxis",
               "TimeStandardDev_GravityAcceleration_XAxis",
               "TimeStandardDev_GravityAcceleration_YAxis",
               "TimeStandardDev_GravityAcceleration_ZAxis",
               "TimeAvg_BodyAccelerationJerk_XAxis",
               "TimeAvg_BodyAccelerationJerk_YAxis",
               "TimeAvg_BodyAccelerationJerk_ZAxis",
               "TimeStandardDev_BodyAccelerationJerk_XAxis",
               "TimeStandardDev_BodyAccelerationJerk_YAxis",
               "TimeStandardDev_BodyAccelerationJerk_ZAxis",
               "TimeAvg_BodyGyro_XAxis",
               "TimeAvg_BodyGyro_YAxis",
               "TimeAvg_BodyGyro_ZAxis",
               "TimeStandardDev_BodyGyro_XAxis",
               "TimeStandardDev_BodyGyro_YAxis",
               "TimeStandardDev_BodyGyro_ZAxis",
               "TimeAvg_BodyGyroJerk_XAxis",
               "TimeAvg_BodyGyroJerk_YAxis",
               "TimeAvg_BodyGyroJerk_ZAxis",
               "TimeStandardDev_BodyGyroJerk_XAxis",
               "TimeStandardDev_BodyGyroJerk_YAxis",
               "TimeStandardDev_BodyGyroJerk_ZAxis",
               "TimeAvg_BodyAcceleration_Magnitude",
               "TimeStandardDev_BodyAcceleration_Magnitude",
               "TimeAvg_GravityAcceleration_Magnitude",
               "TimeStandardDev_BodyAcceleration_Magnitude",
               "TimeAvg_BodyAccelerationJerk_Magnitude",
               "TimeStandardDev_BodyAccelerationJerk_Magnitude",
               "TimeAvg_BodyGyro_Magnitude",
               "TimeStandardDev_BodyGyro_Magnitude",
               "TimeAvg_BodyGyroJerk_Magnitude",
               "TimeStandardDev_BodyGyroJerk_Magnitude",
              
               "FrequencyAvg_BodyAcceleration_XAxis",
               "FrequencyAvg_BodyAcceleration_YAxis",
               "FrequencyAvg_BodyAcceleration_ZAxis",
               "FrequencyStandardDev_BodyAcceleration_XAxis",
               "FrequencyStandardDev_BodyAcceleration_YAxis",
               "FrequencyStandardDev_BodyAcceleration_ZAxis",
               "FrequencyAvg_BodyAccelerationJerk_XAxis",
               "FrequencyAvg_BodyAccelerationJerk_YAxis",
               "FrequencyAvg_BodyAccelerationJerk_ZAxis",
               "FrequencyStandardDev_BodyAccelerationJerk_XAxis",
               "FrequencyStandardDev_BodyAccelerationJerk_YAxis",
               "FrequencyStandardDev_BodyAccelerationJerk_ZAxis",
               "FrequencyAvg_BodyGyro_XAxis",
               "FrequencyAvg_BodyGyro_YAxis",
               "FrequencyAvg_BodyGyro_ZAxis",
               "FrequencyStandardDev_BodyGyro_XAxis",
               "FrequencyStandardDev_BodyGyro_YAxis",
               "FrequencyStandardDev_BodyGyro_ZAxis",
               "FrequencyAvg_BodyAcceleration_Magnitude",
               "FrequencyStandardDev_BodyAcceleration_Magnitude",
               "FrequencyAvg_BodyAccelerationJerk_Magnitude",
               "FrequencyStandardDev_BodyAccelerationJerk_Magnitude",
               "FrequencyAvg_BodyGyro_Magnitude",
               "FrequencyStandardDev_BodyGyro_Magnitude",
               "FrequencyAvg_BodyGyroJerk_Magnitude",
               "FrequencyStandardDev_BodyGyroJerk_Magnitude")

names(ExtractX) <- TidyNames

TidyDataSet <- cbind(CombineSubject,ExtractX,CombineY)

MeltedTDS <- melt(TidyDataSet,id=c("SubjectID","ActivityID"),meas.var=TidyNames)
  
SubjectAvg  <- dcast(MeltedTDS,SubjectID ~ variable,mean)
ActivityAvg  <- dcast(MeltedTDS,ActivityID ~ variable, mean)
CombinedAvg  <- dcast(MeltedTDS,ActivityID+SubjectID~variable,mean)


# Save 2nd tidy dataset to a .csv file
write.csv(CombinedAvg,file="CombinedAvg.csv")


