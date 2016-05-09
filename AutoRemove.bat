:init
@echo off
cd /d %~dp0
reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f
schtasks /delete /TN "ElliotLabsAutoRemovalTool" /F
bcdedit /deletevalue {default} safeboot
set rkill.exe=
set rkill.com=
set mbamsetup=
set mbamdefs=
set adwcleaner=
set combofix=
set uninstaller=
set mcaffeerm=
set nortonrm=
set npe=
set superanti=
set ccleaner=
set defraggler=
if not EXIST rkill\rkill.exe set rkill.exe=no
if not EXIST rkill\rkill.com set rkill.com=no
if not EXIST malwarebytes\mbam-setup* set mbamsetup=no
if not EXIST malwarebytes\rules.ref set mbamdefs=no
if not EXIST malwarebytes\configureations\* set mbamdefs=no
if not EXIST adwcleaner* set adwcleaner=no
if not EXIST combofix.exe set combofix=no
if not EXIST iobituninstaller* set uninstaller=no
if not EXIST MCPR* set mcaffeerm=no
if not EXIST Norton_Removal_tool* set nortonrm=no
if not EXIST NPE* set npe=no
if not EXIST SAS_* set superanti=no
if not EXIST ccsetup* set ccleaner=no
if not EXIST dfsetup* set defraggler=no
goto mainmenu

:start
IF DEFINED %1 (goto %1) ELSE (goto mainmenu)
rem goto mainmenu


:mainmenu
set next=
cls
echo What task would you like to accomplish?
echo.
echo.
echo 1. Remove Programs
echo 2. Start Combofix
echo 3. Scan for viruses
echo 4. Remove (scan then delete) Viruses
echo 5. Download Tools
echo.
set /p mmenu=Please enter your selection here (1-5):
if %mmenu%==1 set next=Uninstall
if %mmenu%==2 set next=combofix
if %mmenu%==3 set next=scan
if %mmenu%==4 set next=remove
if %mmenu%==5 set next=download
goto %next%
cls
echo There has been an error
echo Error Location "mainmenu"
pause
goto mainmenu

:check
if %rkill.exe%==no set rkill.exechk=
if %rkill.com%==no set rkill.comchk=
if %mbamsetup%==no set mbamsetupchk=
if %mbamdefs%==no set mbamdefschk=
if %adwcleaner%==no set adwcleanerchk=
if %combofix%==no set combofixchk=
if %uninstaller%==no set uninstallerchk=
if %mcaffeerm%==no set mcaffeermchk=
if %nortonrm%==no set nortonrmchk=
if %npe%==no set npechk=
if %superanti%==no set superantichk=
if %ccleaner%==no set ccleanerchk=
if %defraggler%==no set defragglerchk=
if %rkill.exechk%%rkill.comchk%%mbamsetupchk%%mbamdefschk=%%adwcleanerchk%%combofixchk%%uninstallerchk%%mcaffeermchk%%nortonrmchk%%npechk%%superantichk%%ccleanerchk%%defragglerchk%%=="" goto %next%
echo There are some tools missing. Would you like to download them?
set /p downloadq=Y=yes N=no
if %downloadq%==Y goto download
if %downloadq%==y goto download
if %downloadq%==N goto %next%
if %downloadq%==n goto %next%
cls
echo There has been an error
echo Error location "downloadq"
pause
goto check


:download
wget -O ccsetup.zip www.piriform.com/ccleaner/download/portable/downloadfile
wget -O dfsetup.zip www.piriform.com/defraggler/download/portable/downloadfile
wget download.bleepingcomputer.com/sUBs/ComboFix.exe
wget download.bleepingcomputer.com/grinler/rkill.exe
wget download.bleepingcomputer.com/grinler/rkill.com
rem wget 
goto %next%


:Uninstall
cls
echo What do you wish to remove?
echo.
echo 1. Mcaffee Antivirus
echo 2. Norton Antivirus
echo 3. Other Programs
echo.
echo 4. Back to main menu
echo.
set /p uninstallm=Select what operation you wish to complete(1-4):
if %uninstallm%==1 goto rmmcaffee
if %uninstallm%==2 goto rmnorton
if %uninstallm%==3 goto iobituninstaller
if %uninstallm%==4 goto mainmenu
cls
echo There has been an error
echo Error Location "Uninstall"
pause
goto Uninstall


:rmmcaffee
MCPR
goto rebootpersist

:rmnorton
Norton_*
goto rebootpersist

:iobituninstaller
iobituninstaller
goto rebootpersist

:rebootpersist
schtasks /create /sc onlogon /tn ElliotLabsAutoRemovalTool /rl highest /tr "%cd%\autoremove.bat"
reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
bcdedit /set {default} safeboot network
exit
