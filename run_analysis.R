#Loading libraries and functions
library(tidyverse)


# 1) Load and merge data
source("read_textfile.R")
source("load_merge.R")


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
      summarize(average=mean(value))
