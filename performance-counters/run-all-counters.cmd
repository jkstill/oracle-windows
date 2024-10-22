
@call C:\users\administrator\counters\set-vars.cmd

@REM should be unzipped into %counterHome%
cd %counterHome%

@set loginName="%machineName%\%username%"
@call timestamp.cmd

@rem futureTime is 2 minutes in the future

@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Database-counter        /tr %counterHome%\oracle-Database-counter.cmd        /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Defragmentation-counter /tr %counterHome%\oracle-Defragmentation-counter.cmd /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Log-counter             /tr %counterHome%\oracle-Log-counter.cmd             /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Pages-counter           /tr %counterHome%\oracle-Pages-counter.cmd           /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Records-counter         /tr %counterHome%\oracle-Records-counter.cmd         /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Sessions-counter        /tr %counterHome%\oracle-Sessions-counter.cmd        /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Table-counter           /tr %counterHome%\oracle-Table-counter.cmd           /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-Version-counter         /tr %counterHome%\oracle-Version-counter.cmd         /sc daily /st %futureTime%
@REM call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\oracle-IO-counter              /tr %counterHome%\oracle-IO-counter.cmd              /sc daily /st %futureTime%

@call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\win-cpu-counters               /tr %counterHome%\win-cpu-counters.cmd               /sc daily /st %futureTime%
@call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\win-memory-counters            /tr %counterHome%\win-memory-counters.cmd            /sc daily /st %futureTime%
@call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\win-network-counters           /tr %counterHome%\win-network-counters.cmd           /sc daily /st %futureTime%
@call schtasks /F /ru %loginName% /rp %password% /rl highest /create /tn %folder%\win-physdisk-counters          /tr %counterHome%\win-physdisk-counters.cmd          /sc daily /st %futureTime%



