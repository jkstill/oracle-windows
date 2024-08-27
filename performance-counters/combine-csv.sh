#!/usr/bin/env bash


# used to combine multiple days worth of counter files
# files are rotated periodically. in this case, daily
# edit as necessary

set -u

mkdir -p csv-combined

cd csv-cleaned || {
	echo
	echo could not cd to csv-cleaned
	echo run './csv-hdr-rewrite.pl csv csv-cleaned'
	echo
	exit 1
}


# the sed cmd removes the date-time stamp to get a base file name

for baseFileName in $(ls -1 *.csv| sed -r -e 's/-[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}_[[:digit:]]{2}-[[:digit:]]{2}-[[:digit:]]{2}.csv//'| sort -u)
do
	echo $baseFileName

	headerLine=$(head -1 $(ls -1 ${baseFileName}*.csv| head -1) )
	newCSVFile=../csv-combined/$baseFileName.csv

	echo $headerLine > $newCSVFile

	for csvFile in $baseFileName*.csv
	do
		# the first line is often full of blanks - skipping it
		tail -n +3 $csvFile >> $newCSVFile
	done

done

