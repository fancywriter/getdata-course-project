# getdata-course-project
Peer assessment course project for "Getting and Cleaning Data" coursera MOOC course.

The only R script here is [run_analysis.R](run_analysis.R)
All parameters listed in the top of this file: URL (download link), DIR (data directory), TIDY_FILENAME (tidy.txt by default), AGGREGATED_FILENAME (aggregated.txt by default).

If data directory doesn't already exist in current working directory, script will firstly download and unpack data. Then it will create tidy datasets and save them to two text files.

The codebook is available here [CodeBook.md](CodeBook.md)
