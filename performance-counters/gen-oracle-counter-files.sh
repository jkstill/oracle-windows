#!/usr/bin/env bash

counterFileDir=counter-files

mkdir -p $counterFileDir

for class in $(grep '\Database(HealthService)' all-windows-oracle-counters.txt  | awk -F \\ '{ print $3 }'| awk '{ print $1 }'| sort -u)
do
	echo
	echo class: $class
	echo
	#grep '\\Database(HealthService)\\'$class all-windows-oracle-counters.txt | perl -e '$x=<>; chomp $x; print qq{"$x"\n}' > $counterFileDir/oracle-$(echo $class | sed -e 's#/##' )-counter.txt
	# enquote and remove CTL-M with sed
	grep '\\Database(HealthService)\\'$class all-windows-oracle-counters.txt | sed -r -e 's/^(.*)$/"\1"/' -e 's/\o015//g' > $counterFileDir/oracle-$(echo $class | sed -e 's#/##' )-counter.txt
done


metricsDrive=C:
sampleCount=1439
sampleInterval=60
metricsHome=%HOMEPATH%\\counters
outputDir=csv


for baseFile in $(grep '\Database(HealthService)' all-windows-oracle-counters.txt  | awk -F \\ '{ print $3 }' | awk '{ print $1 }'| sort -u)
do

	baseFile=oracle-$(echo $baseFile | sed -e 's#/##' )-counter

	echo baseFile: $baseFile

	cat <<-EOF > $baseFile.cmd

@REM $baseFile.cmd
@echo off

set counterFileDir=$counterFileDir
set metricsDrive=$metricsDrive
set metricsHome=$metricsHome
set outputDir=csv
set sampleCount=$sampleCount
set sampleInterval=$sampleInterval

mkdir %metricsDrive%\%metricsHome%\%outputDir%

%metricsDrive%
cd %metricsHome%

@rem timestamp called by master script
@rem uncomment for standalone
@call timestamp.cmd

set countersFile=$baseFile.txt
set metricsFile=$baseFile-%timestamp%.csv

@echo on

call C:\\Windows\\System32\\typeperf.exe -f CSV -cf %metricsDrive%%metricsHome%\%counterFileDir%\%countersFile% -o %metricsDrive%%metricsHome%\%outputDir%\%metricsFile% -sc %sampleCount% -si %sampleInterval% -y

exit

	EOF


done


