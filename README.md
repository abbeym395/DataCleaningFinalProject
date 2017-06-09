---
title: "README"
author: "Abbey Marlowe"
date: "3 June 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## README.md
### run_analysis.R main()
The first stage is reading in all of the data.  The labels are then read in, 
converted to a comma-separated data set which can be easily manipulated.

An initial data table with subject and test numbers is set up.  The various
columns from the X_test file are added.  The colnames are assigned to the 
provided features data.  The following in then performed on both the training
and the test data:

* Tidy up header names and removes extraneous numbers
* Read in the values
* (1st run only) Set up initial data.table with subject and test values
* Adds the columns from X_z where z is test or train.

The two datasets are then combined, one on top of the other.  ALl measurements
which are not means or standard deviations were removed.  The columns are reordered slightly.

### run_analysis.R newdata(dt)
newdata takes the data.table produced by main() as an output and this is what is achieved by the function call at the end of the document which runs the code
when it is sourced.

This data.table has no duplicate values, as the mean is taken of all duplicate
values.  I appreciate that it is not the most efficient or speediest implementation but it does work and does still use sapply.

The header names from dt is taken to produce a new, empty table.  A vector with the data-containing column headings is produced.

An empty vector is created in which to hold the indices of rows where subject an test are both identical.  All rows are then looped through, including the final row.

For every row:

* Checks whether the test columns in the two rows of interest are identical AND
if the subject columns are also identical.
* If that is the case, then add the current row number to the list of identical
rows
* If that is not the case, then still add the current row number to the list
Indicating the penultimate and final entries

For every column of every row:
* Take the mean over all the rows stored in values
* Add these new mean values to the new table, set the subject and test values,
then reset the values vector and start again.

This occurs for each row, and each column for each row, iterating over the entire data.table row by row.