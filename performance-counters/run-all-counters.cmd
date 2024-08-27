

set counterHome=c:\Users\USERNAME\counters
cd %counterHome%

@set username="domain\username"
@set password="PASSWORD-QUOTED"

@call timestamp.cmd

@rem futureTime is 2 minutes in the future

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

