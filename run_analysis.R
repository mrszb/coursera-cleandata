
#needs to point to the correct directory ...
script.dir <- dirname(parent.frame(2)$ofile)
#script.dir <- "C:/Users/marian/Dropbox/hw/cleaning_data"

print (paste("working directory is", script.dir)

data.path <- function (dataFilePath) {
  data.dir  <- file.path(script.dir,"UCI HAR Dataset")
  file.path(data.dir, dataFilePath)
}

mergedata <- function(datasetname, features){
  dataset.dir  <- file.path(data.path(datasetname))
  
  # read sets - we have 3 files (x_|y_|subject_)datasetname.txt in data directory
  dataset.x.path <- file.path(dataset.dir, paste('x_', datasetname,'.txt', sep="") )
  dataset.x <- read.table(dataset.x.path)
  
  dataset.y.path <- file.path(dataset.dir, paste('y_', datasetname,'.txt', sep="") )
  dataset.y <- read.table(dataset.y.path)
  
  dataset.subject.path <- file.path(dataset.dir, paste('subject_', datasetname,'.txt', sep="") )
  dataset.subject <- read.table(dataset.subject.path)
  
  #filter x file only for column we are interested in
  # and label the columns with feature names
  dataset.x <- dataset.x[,features$Index]
  colnames(dataset.x) <- features$Feature.Name
  
  colnames(dataset.y)<- c("Activity")
  colnames(dataset.subject) <- c("Subject")
  
  cbind(dataset.y, dataset.subject, dataset.x)
}

#get activity, feature labels

activities.path <- data.path("activity_labels.txt")
activities <- read.table(activities.path)
colnames(activities) <- c("Index", "Activity")
activities

features.path <- data.path("features.txt")
features.index <- read.table(features.path)
colnames(features.index) <- c("Index", "Feature.Name")
#features.index

#figure out which features are we interested in - should have mean or std in the name
extract.index.bool <- grepl("mean\\(\\)|std\\(\\)",features.index$Feature.Name)

#this will be mapping colno -> feature name
extract.index <- features.index[extract.index.bool,]

data.test  <- mergedata ('test',  extracted.index)
data.train <- mergedata ('train', extracted.index)

merged.sets <- rbind(data.test, data.train)

merged.sets$Activity <- activity.labels$Activity[match(merged.sets$Activity, activities$Index)]
write.table(merged.sets, file.path(script.dir,"merged_data.txt"), sep="\t", row.names=F)

#not sure how to column names here
#means.set <- aggregate(merged.sets[,-c($Subject,$Activity)], list(merged.sets$Subject, merged.sets$Activity), mean)

#ok will use 1,2 for activity, subject
means.set <- aggregate(merged.sets[,-c(1,2)], list(merged.sets$Activity, merged.sets$Subject ), mean)
colnames(means.set)[1:2] <- c("Activity", "Subject")
write.table(means.set, file.path(script.dir,"tidy.txt"), sep="\t", row.names=F)

