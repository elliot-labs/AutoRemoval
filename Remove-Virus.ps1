param([switch]$NoCombofix)

Function Get-Tools {
    Invoke-WebRequest https://downloads.malwarebytes.com/file/mb3/ -OutFile "MBAM_Setup.exe" -ErrorAction Stop
    Invoke-WebRequest https://download.bleepingcomputer.com/grinler/rkill.com -OutFile "rkill.com" -ErrorAction Stop
    Invoke-WebRequest https://download.bleepingcomputer.com/grinler/rkill.exe -OutFile "rkill.exe" -ErrorAction Stop
    Invoke-WebRequest https://download.bleepingcomputer.com/sUBs/ComboFix.exe -OutFile "ComboFix.exe" -ErrorAction Stop
    Invoke-WebRequest https://www.piriform.com/defraggler/download/portable/downloadfile -OutFile "dfsetup.zip" -ErrorAction Stop
    Invoke-WebRequest https://www.piriform.com/ccleaner/download/portable/downloadfile -OutFile "ccsetup.zip" -ErrorAction Stop
    Invoke-WebRequest https://www.superantispyware.com/sasportablehome.php -OutFile "SAS_Setup.exe" -ErrorAction Stop
}

# SAS Silent install is /SCILENT
# reg ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f


Function Restart-Persistance {
    # will persist script actions upon reboot.
}