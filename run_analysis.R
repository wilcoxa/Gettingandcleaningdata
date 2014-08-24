library(data.table)

#set this to the UCI HAR Dataset folder
DIR <- c("C:/Users/Al/Desktop/UCI HAR Dataset")

setwd(DIR)

#read in variable names and descriptive labels
labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

#----------------------------------------------------

#read in data from the test directory
# - recode activity values as per question 3
# - add variable labels as per question 4

setwd(paste0(DIR, "/test"))

test_subject <- read.table("subject_test.txt")
names(test_subject) <- c("Subject No.")

test_data <- read.table("X_test.txt")
names(test_data) <- features$V2

test_label <- read.table("y_test.txt")
names(test_label) <- c("Activity")
test_label$Activity <- labels$V2[match(test_label$Activity, labels$V1)]

#combine test data components
test <- cbind (test_subject, test_label, test_data)

#----------------------------------------------------

#read in data from the train directory
# - recode activity values as per question 3
# - add variable labels as per question 4

setwd(paste0(DIR, "/train"))

train_subject <- read.table("subject_train.txt")
names(train_subject) <- c("Subject No.")

train_data <- read.table("X_train.txt")
names(train_data) <- features$V2

train_label <- read.table("y_train.txt")
names(train_label) <- c("Activity")
train_label$Activity <- labels$V2[match(train_label$Activity, labels$V1)]

#combine train data components
train <- cbind (train_subject, train_label, train_data)


#---------------------------------------------------
setwd("..")

#merge test and train to create tidy dataset 1 (question 1)
test_and_train <- rbind(test,train)


#extract mean and std as per question 2
# - Note have included meanFreq varaibles as well
tatids <-  names(test_and_train) == "Activity" | names(test_and_train) == "Subject No."   
tatmean <- grepl("^.*mean.*$", names(test_and_train))
tatstd <- grepl("^.*std.*$", names(test_and_train))

tat <- test_and_train[, tatids | tatmean | tatstd]
tat <- data.table(tat)

#Creates a second, independent tidy data set
# - with the average of each variable for each activity and each subject
# - as per question 5
tidy <- tat[ , lapply(.SD, mean), by = c("Subject No.", "Activity")]


# write variable names to codebook
write.table(file = "codebook.md", paste(names(tidy)), sep = "\t")
            
#write tidy dataset 2 as a tab delimeted txt file
write.table(file = "Tidy dataset 2.txt", x = tidy, row.names = FALSE, sep = "\t")



#------------------------------------------------------------------






