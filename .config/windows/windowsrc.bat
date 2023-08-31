REM 1 - regedit
REM 2 - Nav to HKEY_CURRENT_USER\Software\Microsoft
REM 3 - Create Key `Command Processor`
REM 4 - Open the key and add a new string value
REM 5 - Name the it `AutoRun` and give it the value `"C:\Users\Michaela\windowsrc.bat"` etc

@echo off
doskey cdg=cd /d C:\Users\Michaela\ioec\gateway\Gateway
doskey cdgc=cd /d C:\Users\Michaela\ioec\gateway\Gateway\Gateway.Client
@echo on
