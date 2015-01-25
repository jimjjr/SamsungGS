data_dir <- "UCI HAR Dataset"

activity_labels_file <- "UCI HAR Dataset/activity_labels.txt"
data_features_file <- "UCI HAR Dataset/features.txt"

test_data_file <- "UCI HAR Dataset/test/X_test.txt"
test_labels_file <- "UCI HAR Dataset/test/y_test.txt"
test_subject_file <- "UCI HAR Dataset/test/subject_test.txt"

train_data_file <- "UCI HAR Dataset/train/X_train.txt"
train_labels_file <- "UCI HAR Dataset/train/y_train.txt"
train_subject_file <- "UCI HAR Dataset/train/subject_train.txt"

zip_data_file <- list.files(pattern="*.zip")[1]
read_zip <- (!data_dir %in% list.files())

## Determines which file location/connection to pass to read.table
thisFileCon <- function(file_name){
    if(read_zip){
        unz(zip_data_file, file_name)
    }else{
        file_name
    }
}

### Get data feature column names
data_features <- read.table(thisFileCon(data_features_file),
                            comment.char="", stringsAsFactors=FALSE)
data_features <- data_features[,2]

### Get all test data
test_data <- read.table(thisFileCon(test_data_file),
                        comment.char="", colClasses="numeric",
                        col.names=data_features)

test_labels <- read.table(thisFileCon(test_labels_file),
                          comment.char="", colClasses="numeric",
                          col.names="activity_label")

test_subject <- read.table(thisFileCon(test_subject_file),
                           comment.char="", colClasses="numeric",
                           col.names="subject_number")
### Merge all test data
test_data <- cbind(test_data, test_labels, test_subject)

### Get all training data
train_data <- read.table(thisFileCon(train_data_file),
                        comment.char="", colClasses="numeric",
                        col.names=data_features)

train_labels <- read.table(thisFileCon(train_labels_file),
                          comment.char="", colClasses="numeric",
                          col.names="activity_label")

train_subject <- read.table(thisFileCon(train_subject_file),
                           comment.char="", colClasses="numeric",
                           col.names="subject_number")
### Merge all training data
train_data <- cbind(train_data, train_labels, train_subject)

### Merge all test data with all training data
all_data <- rbind(test_data, train_data)