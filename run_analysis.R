#Loading libraries and functions
library(tidyverse)

source("read_textfile.R")

#Reading data
train <- read_textfile(y="train/X_train.txt")
train_labels <- read_textfile(y="train/y_train.txt")
subject_train <- read_textfile(y="train/subject_train.txt")

test <- read_textfile(y="test/X_test.txt")
test_labels <- read_textfile(y="test/y_test.txt")
subject_test <- read_textfile(y="test/subject_test.txt")

activity_labels <- read_textfile(y="activity_labels.txt")
features <- read_textfile(y="features.txt")


#Changing columnnames of training- and test data
colnames(train)=features$V2
colnames(test)=features$V2

colnames(subject_train)="subject"
colnames(subject_test)="subject"

colnames(train_labels)="activity"
colnames(test_labels)="activity"

#Combining training-and testdata with subjects
train_data <- cbind(subject_train, train_labels, train)
test_data <- cbind(subject_test, test_labels, test)

#Identify each dataset
train_data$dataset="train"
test_data$dataset="test"

#Merges into one dataset
dat <- rbind(train_data, test_data)
