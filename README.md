==================================================================
run_analysis.R
for Cleaning Data with R (Coursera)
==================================================================
Michael A Choi
==================================================================

This script takes in data from a UCI Machine Learning data repository

Source:

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy.
activityrecognition '@' smartlab.ws
www.smartlab.ws


Script function:

/Loading

Loads in information from X, Y, subject datasets from both training and test sets.


/Filtering & Binding & Tidy naming

Uses grep to look for variables pertaining to mean() and std(). It also filters out 		"BodyBody" variables as these are perceived to be an artifact of the original data processing.

This filters down into 66 X variables.

Training & Test sets are row bound and Subject/Y are column bound.

Tidy names are inserted for each X variable to make them human readable.


/Data processing

The resultant large tidy data set is melted down and recast to provide averages for each X variable by activity and subject.


The dataset includes the following files:
=========================================

- 'README.md'

-  CombinedAvg.txt

-  A Codebook

-  The processing script, run_analysis.R
