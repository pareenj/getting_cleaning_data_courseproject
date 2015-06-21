# CodeBook

## Introduction
The script **run_analysis.R** performs the 5 steps described in the course project's definition.
* First, all the similar data is merged using the **rbind()** function. By similar, we address those files having the same number of columns and referring to the same entities.
* Then, only those columns with the mean and standard deviation measures are taken from the whole dataset. After extracting these columns, they are given the correct names, taken from **featureset.txt**.
* As activity data is addressed with values 1:6, we take the activity names and IDs from **activitylabel.txt** and they are substituted in the dataset.
* On the whole dataset, those columns with vague column names are corrected.
* Finally, we generate a new dataset with all the average measures for each subject and activity type (30 subjects x 6 activities = 180 rows). The output file is called **TidyData.txt**, and uploaded to this repository.

## Variables
* **trainset**, **testset**, **trainlabel**, **testlabel**, **trainsub**, and **testsub** contain the data from the downloaded files.
* **dataset**, **datalabel**, **datasub** are the merged datasets from the previous datasets.
* **featureset** contains the correct names for the *dataset* dataset, which are applied to the column names stored in **mean_std**, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the **activity** variable.
* **datafinal** merges **dataset**, **datalabel** and **datasub** in a big dataset.
* Finally, **TidyData** contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
