#!/usr/bin/env bash


counterFileDir=counter-files

mkdir -p $counterFileDir


grep -E '^\\Memory\\' all-counters.txt | sed -r -e 's/^(.*)$/"\1"/' -e 's/\o015//g' > $counterFileDir/win-memory-counters.txt

grep -E '^\\Processor\(_Total\)\\%' all-counters.txt | sed -r -e 's/^(.*)$/"\1"/' -e 's/\o015//g' > $counterFileDir/win-cpu-counters.txt

grep -E  '^\\Network Interface\(' all-counters.txt | grep -v Unicast | sed -r -e 's/^(.*)$/"\1"/' -e 's/\o015//g' > $counterFileDir/win-network-counters.txt

grep -E  '\\PhysicalDisk\(' all-counters.txt | sed -r -e 's/^(.*)$/"\1"/' -e 's/\o015//g' > $counterFileDir/win-physdisk-counters.txt


metricsDrive=C:
sampleCount=1439
sampleInterval=60
metricsHome=%HOMEPATH%\\counters
outputDir=csv

for baseFile in win-memory-counters win-cpu-counters win-network-counters win-physdisk-counters
do
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

