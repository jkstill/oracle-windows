
Run Windows and Oracle Performance Counters
============================================

## Quick Start

Create directory c:\users\administrator\counters

Unzip counters-setup.zip into c:\users\administrator\counters

Edit set-vars.cmd

Run run-all-counters.cmd


## Overview

Up through Oracle 12, the `Oracle Performance Counters for Windows` could be installed.

Later versions do not have these same counters, though some counters may be available.

Get a list of all available counters:


`typeperf -qx  > all--counters.txt`

Get a list of all available Oracle counters:

`typeperf -qx | findstr /i "oracle" > all-windows-oracle-counters.txt`

## gen-oracle-counter-files.sh

This script will create oracle counter scripts, based on several available oracle counters

These may not work for Oracle versions GT 12.2.

```bash
#!/usr/bin/env bash

counterFileDir=counter-files

mkdir -p $counterFileDir

for class in $(grep '\Database(HealthService)' all-windows-oracle-counters.txt  | awk -F \\ '{ print $3 }'| awk '{ print $1 }'| sort -u)
do
	echo
	echo class: $class
	echo
	grep '\\Database(HealthService)\\'$class all-windows-oracle-counters.txt > $counterFileDir/oracle-$(echo $class | sed -e 's#/##' )-counter.txt
done


metricsDrive=C:
sampleCount=1440
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

set countersFile=$baseFile.txt
set metricsFile=$baseFile.csv

@echo on

typeperf  -f CSV -cf %counterFileDir%\\%countersFile% -o %outputDir%\%metricsFile% -sc %sampleCount% -si %sampleInterval% -y

exit

	EOF


done
```

## gen-std-counter-files.sh

This script will create standard Windows counter scripts, based on a few metrics

```bash
#!/usr/bin/env bash


counterFileDir=counter-files

mkdir -p $counterFileDir


grep -E '^\\Memory\\' all-counters.txt > $counterFileDir\win-memory-counters.txt

grep -E '^\\Processor\(_Total\)\\%' all-counters.txt > $counterFileDir/win-cpu-counters.txt

grep -E  '^\\Network Interface\(' all-counters.txt | grep -v Unicast > $counterFileDir/win-network-counters.txt

grep -E  '\\PhysicalDisk\(' all-counters.txt > $counterFileDir/win-physdisk-counters.txt


metricsDrive=C:
sampleCount=1440
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

set countersFile=$baseFile.txt
set metricsFile=$baseFile.csv

@echo on

typeperf  -f CSV -cf %counterFileDir%\\%countersFile% -o %outputDir%\%metricsFile% -sc %sampleCount% -si %sampleInterval% -y

exit

	EOF


done
```

## timestamp-2008.cmd

Sets time values used by `run-all-counters.cmd`

```text

@rem create a timestamp in Windows 2008

@echo off

@rem Get time hh:mm:ss only
set t=%time:~0,8%
@rem hours < 10 have a leading space
@rem change spaces to 0
set t=%t: =0%
@rem change : to -
set t=%t::=-%

@rem 12:15:21

set hh=%t:~0,2%
set mm=%t:~3,2%
set ss=%t:~6,2%

set mytime=%hh%:%mm%:%ss%

@rem fm: future minute
set /a fm=mm+2

set futuretime=%hh%:%fm%:%ss%

@rem get date - should not have spaces
@rem date on Windows server 2008:
@rem Thu 08/03/2023

set mm=%DATE:~4,2%

@rem echo %mm%
@rem 08

set dd=%DATE:~7,2%

@rem echo %dd%
@rem 03

set yy=%DATE:~10%

@rem echo %yy%
@rem 2023

set timestamp=%yy%-%mm%-%dd%_%t%
```

## run-all-counters.cmd

Run this CMD script to create and start the counters, 


```text

set counterHome=c:\Users\USERNAME\counters
cd %counterHome%

@set username="domain\username"
@set password="PASSWORD-QUOTED"

run-all-counters.cmd 

```

The `run-all-counters.cmd` script will schedule the counters scripts, which will run daily

Each of the counter scripts will perform 1439 iterations at 1 minute intervals, or 1 day.

Following is the text of run-all-counter.cmd

```text


set counterHome=c:\Users\USERNAME\counters
cd %counterHome%

@set username="domain\username"
@set password="PASSWORD-QUOTED"

@call timestamp.cmd

@rem futureTime is 2 minutes in the future
@rem Hard code futureTime to a partiuclar time if you like
@rem set futureTime='18:00:00'

call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Database-counter        /tr %counterHome%\oracle-Database-counter.cmd        /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Defragmentation-counter /tr %counterHome%\oracle-Defragmentation-counter.cmd /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Log-counter             /tr %counterHome%\oracle-Log-counter.cmd             /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Pages-counter           /tr %counterHome%\oracle-Pages-counter.cmd           /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Records-counter         /tr %counterHome%\oracle-Records-counter.cmd         /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Sessions-counter        /tr %counterHome%\oracle-Sessions-counter.cmd        /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Table-counter           /tr %counterHome%\oracle-Table-counter.cmd           /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-Version-counter         /tr %counterHome%\oracle-Version-counter.cmd         /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn oracle-IO-counter              /tr %counterHome%\oracle-IO-counter.cmd              /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn win-cpu-counters               /tr %counterHome%\win-cpu-counters.cmd               /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn win-memory-counters            /tr %counterHome%\win-memory-counters.cmd            /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn win-network-counters           /tr %counterHome%\win-network-counters.cmd           /sc daily /st %futureTime%
call schtasks /F /ru %username% /rp %password% /rl highest /create /tn win-physdisk-counters          /tr %counterHome%\win-physdisk-counters.cmd          /sc daily /st %futureTime%


```

## csv-hdr-rewrite.pl

This Perl script will rewrite the CSV header lines so that that name are much shorted.

Additionally, any backslash characters will be changed to slash.

All line terminator characters will be removed from all header lines and all data.

The CSV files will be written into a new directory, in this case 'csv-new':

```text
$  ./csv-hdr-rewrite.pl  csv-tmp csv-new
working on oracle-Table-counter.csv
working on oracle-Database-counter.csv
working on oracle-Records-counter.csv
working on oracle-Pages-counter.csv
working on win-physdisk-counters.csv
working on oracle-Log-counter.csv
working on win-cpu-counters.csv
working on oracle-Version-counter.csv
working on win-network-counters.csv
working on oracle-Defragmentation-counter.csv
working on oracle-Sessions-counter.csv
```

This cleanup will greatly facilitate automating Excel and Chart generation.


## create-chart-col-params.sh

This script will generate a bash script `perf-counter-charts.sh`

`create-chart-col-params.sh` contains all the commands to generate an Excel files from each of the csv files.

There is currently an example script perf-counter-charts.sh already created and edited.

The only editing performed was to remove several '--chart-cols' lines from several of the commands.

Using this script will require installing the Perl package `Excel::Writer::XLSX`, as it is required by dynchart.pl.

Details at: [dynachar](https://github.com/jkstill/dynachart)


## combine-csv.sh

Use this script to combine counter files that are periodically rotated

