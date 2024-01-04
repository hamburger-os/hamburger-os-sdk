set version=%1

call .\bsp\refresh.bat

@REM call .\tools\mkfirmware-*.bat %version%
call .\tools\mkfirmware-mini-link.bat %version%
