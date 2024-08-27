
@REM call with 
@REM Defragmentation
@REM IO
@REM Log
@REM Pages
@REM Records
@REM Sessions
@REM Table
@REM Version


@REM oracle-counters.cmd
@echo off

set counterFileDir=counter-files
set metricsDrive=C:
set metricsHome=%HOMEPATH%\counters
set outputDir=csv
set sampleCount=1439
set sampleInterval=60

mkdir %metricsDrive%\%metricsHome%\%outputDir%

copy /y timestamp.cmd %metricsDrive%\%metricsHome%

@rem timestamp called by master script
@rem uncomment for standalone
@call timestamp.cmd

set countersFile=win-%1%-counters.txt
set metricsFile=win-%1%-counters-%timestamp%.csv
mkdir %metricsDrive%%metricsHome%\%counterFileDir%

copy /y counter-files\%countersFile% %metricsDrive%%metricsHome%\%counterFileDir%

%metricsDrive%

cd %metricsHome%

@echo on

call C:\Windows\System32\typeperf.exe -f CSV -cf %metricsDrive%%metricsHome%\%counterFileDir%\%countersFile% -o %metricsDrive%%metricsHome%\%outputDir%\%metricsFile% -sc %sampleCount% -si %sampleInterval% -y

exit


