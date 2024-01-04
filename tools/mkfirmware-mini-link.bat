md release
set version=%1
set PackagerTools=..\tools\PackagerTools\release\PackagerTools
set product=MINI-LINK

chcp 65001
set name=基于%product%的HamburgerOS操作系统
md release\%name%%version%
chcp 936

@REM % ---------- application ---------- %

cd bsp
call build.bat configs\.config.stm32f103-mini-link-v2
chcp 65001
call %PackagerTools% --src rtthread.bin --rbl rtthread.rbl --part app --ver %version% --prod %product% --qlz
copy /Y rtthread.bin ..\release\%name%%version%\application.bin
copy /Y rtthread.rbl ..\release\%name%%version%\download.rbl
copy /Y rtthread.rbl ..\release\%name%%version%\factory.rbl
chcp 936
cd ..
