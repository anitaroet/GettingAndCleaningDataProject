
# Code Book - Human Activity Recognition Using Smartphones Dataset

## Data source
The data for this analysis is retrieved from [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]. 

## Data transformation
The data originally consisted of one training data set (70 %) and one test data set (30 %). For this analysis the two sets have been combined, and we have only extracted the means and standard deviations. After combining the two data sets we have computed the average of each mean and standard deviation for each activity and subject. 


## Data variables
The dataset consists of four variables:

1. Variable: Mean or standard deviation of body accelaration
2. Activity: Activity performed by the subject:
  + 1. Walking
  + 2. Walking upstairs
  + 3. Walking downstairs
  + 4. Sitting
  + 5. Standing
  + 6. Laying
3. Subject: id for each subject (1-30)
4. Average: average value for each variable, activity and subject

  

