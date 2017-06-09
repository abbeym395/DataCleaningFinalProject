library(data.table)
library(dplyr)
library(gsubfn)

main <- function(){
    ## Read in all of the data
    subject_test <- as.data.table(read.table("UCI HAR Dataset/test/subject_test.txt"))
    X_test <- as.list(read.table("UCI HAR Dataset/test/X_test.txt"))
    y_test <- as.data.table(read.table("UCI HAR Dataset/test/y_test.txt"))
    
    ## Read in the labels, convert to a comma-separated data set which plays nicely
    ## with assigning colnames
    features <- readLines("UCI HAR Dataset/features.txt")
    features <- replace(features, "\n", ",")
    
    ## Set up initial data table with subject and test numbers
    test <- data.table(subject = subject_test[[1]], testlabel = y_test)
    
    ##  Adds the various data columns from the X_test file
    for (i in 1:length(X_test)){
        test <- cbind(test, X_test[[i]])
    }
    
    ## Assigns the colnames to the provided features data
    colnames(test) <- c("subject", "testlabel", features[1:length(features)-1])

    ## Tidies up header names and remove extraneous numbers
    names(test) <- tolower(unlist(names(test)))
    headers <- names(test)
    headers <- strsplit(headers, " ")
    for (i in 3:length(headers)){
        headers[i] <- headers[[i]][2]
    }
    names(test) <- unlist(headers)
    
    ## Read in the training values
    subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
    X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
    y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
    
    ## Set up initial data table with subject and test numbers
    train <- data.table(subject = subject_train[[1]], testlabel = y_train)
    
    ##  Adds the various data columns from the X_test file
    for (i in 1:length(X_test)){
        train <- cbind(train, X_train[[i]])
    }
    
    ## Assigns the colnames to the provided features data
    colnames(train) <- c("subject", "testlabel", features[1:length(features)-1])
    
    ## Tidies up header names and remove extraneous numbers
    names(train) <- tolower(unlist(names(train)))
    headers <- names(train)
    headers <- strsplit(headers, " ")
    for (i in 3:length(headers)){
        headers[i] <- headers[[i]][2]
    }
    names(train) <- unlist(headers)
    
    ## Combines the two datasets together, one on top of the other.
    combined <- rbind(test, train)
    
    ## Eliminates non-mean and non-std dev measurements
    meanstdcols <- c(1:2, grep("[Mm]ean\\(|std", headers))
    combined <- combined[,..meanstdcols]
    
    ## Replaces numerial activity descriptors with descriptive strings
    testlabelnames <- c("walking"=1, "walking_upstairs" = 2, "walking_downstairs" = 3,"sitting" = 4, "standing" = 5, "laying" = 6)
    combined$test <- names(testlabelnames)[match(combined$testlabel, testlabelnames)] 
    
    ## Reorders columns
    combined <- combined[,c(1, 69, 2:68)]

    combined
}

newdata <- function(dt) {
    ## Takes data.table output (from main) and produces a tidy table with no duplicate
    ## values.
    
    ## Takes the header names and creates an empty table
    newtable <- dt[0,]
    
    ## Creates a vector with the data-containing columns
    cols <- colnames(dt)[!grepl('subject|test',colnames(dt))]
    
    ## Creates an empty vector in which to contain the indices of rows where 
    ## subject and test are identical
    values <- numeric()
    
    ## Loops through all rows
    for (i in 1:nrow(dt)){
        ## Checks whether the test columns in 2 rows are identical AND if
        ## the subject columns are ALSO identical
        if (identical(dt$test[i], dt$test[i+1]) && identical(dt$subject[i], dt$subject[i+1])){
            ## If that is the case, then add the current row number to the
            ## list of identical rows
            values <- append(values, i)   
        } else if (length(values) != 0 | i == nrow(dt)){
            ## If that is not the case, then still add the current row number to
            ## the list (meaning that this is the last identical row)
            values <- append(values, i)
            results <- numeric() # Create new, empty vector to place results in
            
            ## For each column, take the mean over all of the rows stored in
            ## values
            for (j in cols){
                result <- sapply(dt[values,..j], mean, na.rm=TRUE)
                results <- append(results, result) # Append to temp vector
            }
            ## Add these values to the new table, set the subject and test
            ## values, then reset the values vector
            newtable <- rbind(newtable, as.list(results), fill = TRUE)
            newtable$subject[nrow(newtable)] <- dt$subject[i]
            newtable$test[nrow(newtable)] <- dt$test[i]
            values <- numeric()
        }
    }
    newtable$testlabel <- NULL # Remove the testlabel column
    print(newtable)
    write.table(newtable, newtable.txt, rowname = FALSE)
    newtable # Return newtable
}

newdata(main())