
###coursera-cleandata



** function mergedata( ... )
* loads data from x_|y_|subject_ files
* filters x_ set for interesting features only using features.index
* merge data combines data from x_|y_|subject files into one 

** man script
* reads labels for activities and features
* filters features.index for features containing "std", "mean"
* creates datasets test, train using mergedata()
* changes data in Activity col to human readable labels
* averages data aggregated by Activity, Subject 