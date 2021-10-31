#Loading libraries
library(tidyverse)
library(data.table)


# 1) Load and merge data

    #Download data
    if(!dir.exists("data")){
    dir.create("data")
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    dat_zip <- download.file(url, "data.zip")
    unzip("data.zip", exdir="data")
    }

    #Function to read data
    read_textfile <- function(y){
      read.delim(y, stringsAsFactors = TRUE, header=FALSE,sep="")
    }
    
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



# 2) Extract mean and standard deviations

  # Find which columns to keep
    features_use <- features %>%
      mutate(use=grepl(("mean|std"),V2)) %>%
      filter(use==TRUE) %>%
      mutate(V1=V1+2) %>%
      select(V1)

  # Filter columns
    dat_filtered <- dat[,c(1,2,features_use$V1)]  
    

# 3) Name activities
    
    dat_named <- dat_filtered %>%
      mutate(activity=ifelse(activity==1, "Walking", ifelse(
        activity==2, "Walking upstairs", ifelse(
          activity==3, "Walking downstairs", ifelse(
            activity==4, "Sitting", ifelse(
              activity==5, "Standing", "Laying"
            )
          )
        )
      )))
    

# 4) Descriptive variable names
    
    dat_long <- dat_named %>%
      gather(key="variable", value="value",3:81 )
    

# 5) Make new dataset with means
    
    dat_average <- dat_long %>%
      group_by(variable, activity, subject) %>%
      summarize(average=mean(value)) %>%
      as_tibble
    
    # Save tidy dataset
    write.table(dat_average, "tidy_data.txt")
