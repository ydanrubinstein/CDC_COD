# Author: Y. Dan Rubinstein
# Date: Mar 20, 2015
# Project assignment for Coursera Data Products Class
# Displays interactive dashboard of cause of death per 100k population in the USA. Data from CDC
# Allows User to select year (or animate across years), and COD

# read the data
# obtained from CDC web site: http://wonder.cdc.gov/ucd-icd10.html
# selected State, Year, ICD Chapter
dd = read.delim("./data/Underlying Cause of Death, 1999-2013 (3).txt")

# Clean up data
# filter out non-data rows, i.e. ones which have computed totals or notes
# remove first column ("notes"), and transform last column from factor to number
aa = dd$Notes != ""
cleanData = dd[!aa,-1]
cleanData$Death.Rate = round(as.double(cleanData$Deaths/cleanData$Population) * 100000)
cleanData$State = tolower(cleanData$State)
attach(cleanData)
NUMBUCKETS = 10