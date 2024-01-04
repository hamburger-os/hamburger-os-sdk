set RTT_ROOT=bsp\rt-thread
set BSP_ROOT=bsp

del /q %2\*.o
del /s /q %2\app

call scons --%1=%2

set RTT_ROOT=
set BSP_ROOT=
