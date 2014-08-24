Getting and cleaning data course project - Readme
======================

* Run the run_analysis script from the directory that contains the UCI HAR Dataset folder

This script will compile the test and train datasets.
It will then merge in variable labels for the data.
Then it will add descriptive name to the activity values.

The test and train datasets are merged to create tidy dataset 1 - named test_and_train


The mean and standard deviation variables are then extracted from this dataset.
Note that I have also included the meanFreq variables as they are also mean values.

The subjects and activities are then aggregated and the mean of these values calculated.

This dataset is then exported using write.table to a file named "Tidy Dataset 2.txt" in tab delimited format.

