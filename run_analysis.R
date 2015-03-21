# url of the dataset
URL <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# root directory of the dataset
DIR <- 'UCI HAR Dataset'
# output filenames
TIDY_FILENAME <- 'tidy.txt'
AGGREGATED_FILENAME <- 'aggregated.txt'

if (!file.exists(DIR)) {
  message("Dataset doesn't exist in working directory, need to download it first.")
  download.file(URL, 'dataset.zip', 'curl')
  unzip('dataset.zip')
}

message('Reading data from text files into memory.')

x.train <- read.table(file.path(DIR, 'train', 'X_train.txt'))
y.train <- read.table(file.path(DIR, 'train', 'y_train.txt'))
subj.train <- read.table(file.path(DIR, 'train', 'subject_train.txt'))
x.test <- read.table(file.path(DIR, 'test', 'X_test.txt'))
y.test <- read.table(file.path(DIR, 'test', 'y_test.txt'))
subj.test <- read.table(file.path(DIR, 'test', 'subject_test.txt'))
features <- read.table(file.path(DIR, 'features.txt'))
activities <- read.table(file.path(DIR, 'activity_labels.txt'))

message('Reading data is finished.')

message('Binding train and test datasets.')
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
subj <- rbind(subj.train, subj.test)

message('Filtering mean and standard deviation.')
features.filter <- grep("-mean\\(\\)|-std\\(\\)",features[,2])
x <- x[,features.filter]
names(x) <- gsub("\\(|\\)","",tolower(features[features.filter, 2]))

message('Merging activity names to dataset.')
names(y) <- 'activity'
y[,1] <- activities[y[,1],2]

message('Creating tidy dataset.')
names(subj) <- 'subject'
tidy <- cbind(subj, y, x)

message('Aggregating tidy dataset variables by activity and subject.')
aggregated <- aggregate(tidy[3:68], by=list(subject = tidy$subject,activity = tidy$activity), FUN=mean)

message('Writing tidy datasets to files.')
write.table(tidy, TIDY_FILENAME, row.names = FALSE)
write.table(aggregated, AGGREGATED_FILENAME, row.names = FALSE)
