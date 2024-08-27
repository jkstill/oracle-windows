
@rem https://stackoverflow.com/questions/53298208/add-minutes-whole-number-in-time-to-batch-file
@rem create a timestamp in Windows 2008

@echo OFF

@rem echo add minutes
@rem set/p "minutesToAdd=>"

set minutesToAdd=2

for /F "tokens=2 delims==" %%a in ('wmic OS Get LocalDateTime /value') do set "dt=%%a"
set /A "D=%dt:~0,8%, MM=1%dt:~4,2%-100, newS=((1%dt:~8,2%-100)*60+1%dt:~10,2%-100+minutesToAdd)*60+1%dt:~12,2%-100"
set /A "s=newS%%60+100,newS/=60,m=newS%%60+100,h=newS/60,newDD=h/24,h%%=24"
if %newDD% neq 0 (
   set /A "newMM=!( 1%D:~6%-(130+(MM+MM/8)%%2+!(MM-2)*(!(%D:~0,4%%%4)-2)) ), lastMM=!(1%D:~4,2%-112), newYYYY=newMM*lastMM"
   set /A "MM+=newMM*(1-lastMM*12), D+=newYYYY*(20100-1%D:~4%) + !newYYYY*newMM*(100*MM+10000-1%D:~4%) + newDD"
)

@rem windows 2008
set "futureTime=%h%:%m:~1%:%s:~1%"  &  set "futureDate2008=%D:~4,2%/%D:~6,2%/%D:~0,4%" & set "futureDateISO8601=%D:~0,4%-%D:~4,2%-%D:~6,2%"
set "futureTimeISO8601=%h%-%m:~1%-%s:~1%"  

@rem windows 10
@rem set "futureTime=%h%:%m:~1%:%s:~1%"  &  set "futureDate=%D:~0,4%-%D:~4,2%-%D:~6,2%"

set futureTimestamp2008=%futureDate2008%_%futureTime%
set futureTimestampISO8601=%futureDateISO8601%_%futureTimeISO8601%

@rem
@rem echo                future time: %futureTime%
@rem echo       future time ISO8601 : %futureTimeISO8601%
@rem echo      future date Win 2008 : %futureDate2008%
@rem echo   future date Win ISO8601 : %futureDateISO8601%
@rem echo future timestamp Win 2008 : %futureTimestamp2008%
@rem echo future timestamp ISO8601  : %futureTimestampISO8601%

set timestamp=%futureTimestampISO8601%
@rem echo                 timestamp : %timestamp%


