@echo off

cd app
for /r "." %%a in (*.mo) do (
    echo %%~dpa%%~nxa
    copy %%~dpa%%~nxa ..\rootfs\bin\
)
cd ..

cd lib
for /r "." %%a in (*.so) do (
    echo %%~dpa%%~nxa
    copy %%~dpa%%~nxa ..\rootfs\lib\
)
cd ..