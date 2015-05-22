library("plyr")         # always load plyr first if you wish to use the functionality
library("dplyr")        # from both plyr and dplyr libraries

# Step 1 - Merges the training and the test sets to create one data set.
# Step 1.1 - read the datasets
trainData <- readData("train")
testData  <- readData("test")

# Step 1.2 - merge the datasets
masterDataSet <- rbind(trainData, testData)

# Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement
masterDataSet <- select(masterDataSet, contains("PerformedActivity"), contains("Subject"), 
                        contains(".mean."), contains("std"))

# Step 3 - Uses descriptive activity names to name the activities in the data set
activityLabels <- read.csv("activity_labels.txt", header=F, blank.lines.skip=T, sep=" ", 
                           stringsAsFactors = F)

# Map numeric digit to name for the performed activity
masterDataSet$PerformedActivity <- factor(masterDataSet$PerformedActivity, activityLabels$V1, 
                                          activityLabels$V2)

# Step 4 - renaming the column names, this step is already peformed after reading the 
#          individual datasets (train and test)

# Step 5
tidyDataSet <- ddply(masterDataSet, .(Subject, PerformedActivity), numcolwise(mean))
write.table(tidyDataSet, file="tidy.txt", row.name=F)

######################### HELPER FUNCTIONS #####################################
# function that builds a data frame by linking subject, activity and observations
readData <- function(dirName)
{
    cbind(readSubjects(dirName), 
          readActivity(dirName), 
          readObservations(dirName))
}

# function reads the observation dataset (features)
readObservations <- function(dirName)
{
    # build the target file name which contain Observations for features
    obsPath <- paste(dirName,"\\","X_",dirName,".txt", sep = "")

    if (file.exists(obsPath) == F)
        stop(paste("The file ", obsPath, " doesnt exist", sep = ""))
    
    # read observations for features
    featureObs <-read.csv(obsPath, header=F, blank.lines.skip=T, sep="", stringsAsFactors=F)
    
    # Assign proper column names for the observations
    features <- read.csv("features.txt", header=F, blank.lines.skip=T, sep=" ", stringsAsFactors=F)
    
    # prepare unique column names with valid characters
    names(featureObs) <- make.names(names=features$V2, unique=T, allow_=T)
    
    featureObs
}

# function reads the activity dataset
readActivity <- function(dirName)
{
    # build the target file name which contain Activity performed for each observation
    actPath <- paste(dirName,"\\","Y_",dirName,".txt", sep = "")

    if (file.exists(actPath) == F)
        stop(paste("The file ", actPath, " doesnt exist", sep = ""))
    
    # read activities
    activity <- read.csv(actPath, header=F, blank.lines.skip=T, stringsAsFactors=F)
    
    # rename the column
    activity <- rename(activity, "PerformedActivity" = V1)
}

# function reads the subject data set
readSubjects <- function(dirName)
{
    # build the target file name which contain subject who performed activity for each observation
    subPath <- paste(dirName,"\\","subject_",dirName,".txt", sep = "")

    if (file.exists(subPath) == F)
        stop(paste("The file ", subPath, " doesnt exist", sep = ""))
    
    # read subject identified as a number between 1-30
    subject <- read.csv(subPath, header=F, blank.lines.skip=T, stringsAsFactors=F)
    
    # rename the column
    subject <- rename(subject, Subject = V1)
}
