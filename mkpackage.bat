@REM % ./mkpackage.bat SOM-F450S1 v1.2.0.1_20231230 %
set product=%1
set version=%2

set PackagerTools=.\tools\PackagerTools\release\PackagerTools

%PackagerTools% --src ./bsp/Debug/rtthread.bin --rbl rtthread.rbl --part app --ver %version% --prod %product% --qlz