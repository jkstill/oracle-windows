
@REM call with physdisk cpu memory or network

@REM win-counters.cmd
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
@REM the syntax requires to put a dash before the timestamp is bizarre
set metricsFile=win-%1-%-%%timestamp%.csv
mkdir %metricsDrive%%metricsHome%\%counterFileDir%

copy /y counter-files\%countersFile% %metricsDrive%%metricsHome%\%counterFileDir%

%metricsDrive%

cd %metricsHome%

@echo on

call C:\Windows\System32\typeperf.exe -f CSV -cf %metricsDrive%%metricsHome%\%counterFileDir%\%countersFile% -o %metricsDrive%%metricsHome%\%outputDir%\%metricsFile% -sc %sampleCount% -si %sampleInterval% -y

exit

