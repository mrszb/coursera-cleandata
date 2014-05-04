### CodeBook

* The data is extracted from space delimted files in subdirectory UCI HAR Dataset
* there are 2 sets of data in separate subdirectories "test" and "train"
* each set contains X_ data with features, Y_ data with activities, and subject_ data.


### main script
* reads labels for activities and features
* filters features.index for features containing "std", "mean"
* creates datasets test, train using mergedata()
* changes data in Activity col to human readable labels
* averages data aggregated by Activity, Subject 

** function **mergedata( ... )**
* loads data from x_|y_|subject_ files
* filters x_ set for interesting features only using features.index
* merge data combines data from x_|y_|subject files into one 

