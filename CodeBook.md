---
title: "Getting and Cleaning data"
author: "Abishek Hari"
date: "Friday, May 22, 2015"
---

This document describes the variables, the data, and any transformations or work that is performed to clean up the data.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Source data used for the project can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Helper functions:
The following helper functions are used to read and merge data
#####1. readData  
Input:  Directory name / DATASET TYPE("test" / "train").  
Output: A complete Dataframe containing Subject, Activity, and variables bound together

This function invokes the other helper functions and builds a complete data frame using cbind function.

#####2. readObservations  
Input:  Directory name / DATASET TYPE("test" / "train").   
Output: Clean Dataframe containing observations and feature name for each observation  

This funciton builds a complete FILEPATH ("x_<DATASET TYPE>.txt") name, checks for file existence.  
If the file doenst exist, the processing stops by issuing error message and else reads observations. Feature names are read from "features.txt", unique valid names are built using the make.names function

#####3. readActivity  
Input:  Directory name / DATASET TYPE ("test" / "train").   
Output: Dataframe containing activity id for each observation contained in observation dataset  

This funciton builds a complete FILEPATH ("y_<DATASET TYPE>.txt")name, checks for file existence.  
If the file doenst exist, the processing stops by issuing error message and else reads observations. The original column name "V1"" is renamed to contain descriptive name "PerformedActivity"  

#####4. readSubjects
Input:  Directory name / DATASET TYPE ("test" / "train").   
Output: Dataframe containing subject id for each observation contained in observation dataset

This funciton builds a complete FILEPATH ("subject_<DATASET TYPE>.txt") name, checks for file existence.
If the file doenst exist, the processing stops by issuing error message and else reads observations. The original column name "V1"" is renamed to contain descriptive name "Subject"

####The final clean dataset is created by following the below steps   

1. The required libraries are loaded in the accepted sequence  
2. Training data frame is read by calling readData function and loaded into a variable "trainData". The dimensions of this data frame are (7352 X 563).  
3. Testing data is read by calling readData function and loaded into a variable "testData". The dimensions of this data frame are (2947 X 563).  
4. These two datasets are merged into a single dataset named "masterDataSet" by using rbind() function. The dimensions of this master data frame are (10299 X 563).  
5. "masterDataSet" is then filtered based on the required variables. Requried variables are "PerformedActivity", "Subject", column names matching with exact word "mean" and "std" (standard deviation).   
6. The newly created "masterDataSet" has dimensions (10299 X 68) with "PeformedActivity" as the first column, "Subject" as the second column and the mean & standard deviation variables follow. Ignored the variables of the form meanFreq which did not match the exact word "mean". 
7. Acitivity Id vs. Activity name data frame is created by reading the "activity_labels.txt"  
8. Activity Id in the "masterDataSet" are given appropriate label names by converting them into factors  
9. A tidyDataSet is created by calculating  the average of each measurement for each activity and each subject. The dimensions of this data frame are (180 X 68).  
10. The tidyDataSet is written to a text file "tidy.txt" by excluding the rownames
11. Units for variables in masterDataSet and tidyDataSet  
  + Subject who performed the activity - int  
  + PerformedActivity                  - Factor  
  + All other variables (mean, std)    - numeric
