@echo off

SET mypath=%~dp0
SET ProjectsFolder=%mypath:~0,-1%


IF "%1"==""  IF "%2"=="" (
call :CheckPath "%ProjectsFolder%"  "%PATH%"   
)

set str1=%1
IF  x%str1:-=%==x%str1% (
    GOTO:DIR
) ELSE (
    IF %1 == -l (
        GOTO:list
    ) 
    IF %1 == -r (
        GOTO:remove
    ) ELSE (
        echo %1 is not a flag.
        GOTO:end
    )
)

:DIR
IF "%2"=="" (
IF EXIST %ProjectsFolder%\%1\ (
    cd %ProjectsFolder%\%1
    for /d %%e in (*) do (
        @echo    %%e
    )

) ELSE (
    mkdir %ProjectsFolder%\%1
    cd %ProjectsFolder%\%1
))

IF NOT "%2"=="" (
    IF EXIST %ProjectsFolder%\%1\%2\ (
    cd %ProjectsFolder%\%1\%2
) ELSE (
    mkdir %ProjectsFolder%\%1\%2
    cd %ProjectsFolder%\%1\%2
)) 
GOTO:end

:list
    @echo  ----------------------------------------------
    @echo  I       Platform       I       Project       I           
    @echo  ----------------------------------------------
    cd %ProjectsFolder%
    for /d %%d in (*) do (
        echo.
        @echo       %%d
        call :showfolders %%d

    )
GOTO:end


:remove
    cd %ProjectsFolder%
    IF "%2"==""  echo Need to specify platform 
    IF NOT "%2"=="" IF "%3"=="" ( 
        rmdir /s %ProjectsFolder%\%2 
        )
       IF NOT "%2"=="" IF NOT "%3"=="" ( 
        rmdir /s %ProjectsFolder%\%2 
        )
GOTO:end




:showfolders
for /d %%e in (%1\*) do (
        @echo                         %%e
    )
 GOTO:end








:CheckPath
    echo.%2 | findstr /C:"%1"  1>nul

    if errorlevel 1 (
    echo Need to run as admin to set up Project Manager.
    setx /M PATH "%PATH%;%ProjectsFolder%"
    pause
    ) ELSE (
     echo Project Manager already set up.
     pause
    )
    GOTO:end




:end