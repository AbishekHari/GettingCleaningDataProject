---
title: "Getting and Cleaning data ReadMe"
author: "Abishek Hari"
date: "Friday, May 22, 2015"
---

This file describes how to execute the run_analysis.R

1. Download the data set for the project from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the data to a folder.
3. In the directory where you find "test", "train" folders copy the "run_analysis.R" program. Also ensure that the directory you chose has "activity_labels.txt" and "features.txt"
4. In R Studio enter the command 
```{r}
source("run_analysis.R")
```
A file "tidy.txt" will be created in the same directory. Tidy data set contains the average of each variable for each activity and each subject. The dimensions of the dataset are (180 X 68) and file size is approximately 220KB

Note: More details about how the data is cleaned and transformed can be found in CodeBook.md
