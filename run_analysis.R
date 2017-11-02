# run_analysis.R 

#=========================================
# This script prepares a tidy dataset as requested for the 
# programming assigment of Week 4 of the course of Getting 
# and Cleaning the Data.
#=========================================

# Please insert here your directory paths and filenames
trainX <- "/Users/francesco/Downloads/UCI_HAR_Dataset/train/X_train.txt"
trainY <- "/Users/francesco/Downloads/UCI_HAR_Dataset/train/y_train.txt"
trainSubject <- "/Users/francesco/Downloads/UCI_HAR_Dataset/train/subject_train.txt"

testX <- "/Users/francesco/Downloads/UCI_HAR_Dataset/test/X_test.txt"
testY <- "/Users/francesco/Downloads/UCI_HAR_Dataset/test/y_test.txt"
testSubject <- "/Users/francesco/Downloads/UCI_HAR_Dataset/test/subject_test.txt"

 #Read the trainX and testX and rbind them 
 data <- rbind(read.table(trainX),read.table(testX)) 
 #Read the trainY and testY and rbind them 
 activity <- rbind(read.table(trainY, col.names = "Activity"),
                   read.table(testY, col.names = "Activity") )    
 #Read the trainSubject and testSubject and rbind them 
 subject <- rbind(read.table(trainSubject, col.names = "Subject"),
                   read.table(testSubject, col.names = "Subject") )    
 
  
# Read the features.txt file and extract the measuraments that contain
# the mean and standard devation
 feature_file <- "/Users/francesco/Downloads/UCI_HAR_Dataset/features.txt"
 features <- read.table(feature_file, stringsAsFactors = FALSE)
 colIndex <- features$V1[grepl(paste(c("mean\\()","std\\()"), collapse = "|"), features$V2)]
 colNames <- sub("\\()","",features[[2]][colIndex])
 
 # Extract the desired columns and renames with the measuraments names
 data1 <- data[,colIndex]
 colnames(data1) <- colNames
 
 
 # Read the activity_label.txt file and associate labels to activity numbers 
 activity_label_file <- "/Users/francesco/Downloads/UCI_HAR_Dataset/activity_labels.txt"
 activity_label <- read.table(activity_label_file, stringsAsFactors = FALSE)
 
 for (i in 1:length(activity_label[[2]])) {
         activity[activity == activity_label[[1]][i]] <- activity_label[[2]][i]
 }
 
 # Cbind the activity and the subject as factors with the data1. 
 # Write the result in data, so to override the memory 
 # consuming, and not needed anymore object  
 
 activity$Activity <- as.factor(activity$Activity)
 subject$Subject <- as.factor(subject$Subject)
 data2 <- cbind(activity,subject, data1)
 
 # Creates a second, independent tidy data set with the average 
 # of each variable for each activity and each subject 
 
 # Split the dataset by activity 
 a <- split(data2, data2$Activity )
 
 for ( i in 1:nlevels(activity$Activity) ) {
         for( j in 1:nlevels(subject$Subject) ){
                 # Select the a part of the data frame based on activity (first) and Subject (second)
                 t  <- a[[i]][a[[i]]$Subject == j,]
                 # Compute the colum means
                 tt <- colMeans(t[,3:dim(t)[2]])
                 if (i == 1 & j == 1 ){ 
                         # Initialize the new data frame and call it data, so to 
                         # override initial, and not needed anymore, data object  
                         data <- data.frame( Activity = activity_label$V2[i], 
                                             Subject  = as.character(j) , t(tt) )
                 } else { # Add a new row to the data frame
                         tmp <-  data.frame( Activity = activity_label$V2[i], 
                                             Subject  = as.character(j) , t(tt) )
                         data <- rbind(data,tmp)
                 }
         }
 }

# write.csv(data, "tidy_data.cvs", row.names=FALSE)
 write.table(data, "tidy_data.txt", row.names=FALSE)
 
  