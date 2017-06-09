---
title:CodeBook.md
author:AbbeyMarlowe
date:9June2017
output:html_document
---

```{rsetup,include=FALSE}
knitr::opts_chunk$set(echo=TRUE)
```

##CodeBook.md
###CodebookforGettingandCleaningDatafinalproject
#####subject  
    subject number  
#####test  
    subject's activity, one of:  
        "walking"=1, "walking_upstairs" = 2, "walking_downstairs" = 3,
        "sitting" = 4, "standing" = 5, "laying" = 6  
        
#####data values  
    Values between -1 and 1 representing a variety of recorded data.  Means of 
    repeated data were taken (ie where subject and test were both the same
    over multiple rows).  No other numerical manipulation took place.  
        tbodyacc-mean()-x  
        tbodyacc-mean()-y  
        tbodyacc-mean()-z  
        tbodyacc-std()-x  
        tbodyacc-std()-y  
        tbodyacc-std()-z  
        tgravityacc-mean()-x  
        tgravityacc-mean()-y  
        tgravityacc-mean()-z  
        tgravityacc-std()-x  
        tgravityacc-std()-y  
        tgravityacc-std()-z  
        tbodyaccjerk-mean()-x  
        tbodyaccjerk-mean()-y  
        tbodyaccjerk-mean()-z  
        tbodyaccjerk-std()-x  
        tbodyaccjerk-std()-y  
        tbodyaccjerk-std()-z  
        tbodygyro-mean()-x  
        tbodygyro-mean()-y  
        tbodygyro-mean()-z  
        tbodygyro-std()-x  
        tbodygyro-std()-y  
        tbodygyro-std()-z  
        tbodygyrojerk-mean()-x  
        tbodygyrojerk-mean()-y  
        tbodygyrojerk-mean()-z  
        tbodygyrojerk-std()-x  
        tbodygyrojerk-std()-y  
        tbodygyrojerk-std()-z  
        tbodyaccmag-mean()  
        tbodyaccmag-std()  
        tgravityaccmag-mean()  
        tgravityaccmag-std()  
        tbodyaccjerkmag-mean()  
        tbodyaccjerkmag-std()  
        tbodygyromag-mean()  
        tbodygyromag-std()  
        tbodygyrojerkmag-mean()  
        tbodygyrojerkmag-std()  
        fbodyacc-mean()-x  
        fbodyacc-mean()-y  
        fbodyacc-mean()-z  
        fbodyacc-std()-x  
        fbodyacc-std()-y  
        fbodyacc-std()-z  
        fbodyaccjerk-mean()-x  
        fbodyaccjerk-mean()-y  
        fbodyaccjerk-mean()-z  
        fbodyaccjerk-std()-x  
        fbodyaccjerk-std()-y  
        fbodyaccjerk-std()-z  
        fbodygyro-mean()-x  
        fbodygyro-mean()-y  
        fbodygyro-mean()-z  
        fbodygyro-std()-x  
        fbodygyro-std()-y  
        fbodygyro-std()-z  
        fbodyaccmag-mean()  
        fbodyaccmag-std()  
        fbodybodyaccjerkmag-mean()  
        fbodybodyaccjerkmag-std()  
        fbodybodygyromag-mean()  
        fbodybodygyromag-std()  
        fbodybodygyrojerkmag-mean()  
        fbodybodygyrojerkmag-std()  