@echo off

set ProjectsFolder= C:\Users\c0llat2\OneDrive\Projects\

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
IF EXIST %ProjectsFolder%%1\ (
    cd %ProjectsFolder%%1
    for /d %%e in (*) do (
        @echo    %%e
    )

) ELSE (
    mkdir %ProjectsFolder%%1
    cd %ProjectsFolder%%1
))

IF NOT "%2"=="" (
    IF EXIST %ProjectsFolder%\%1\%2\ (
    cd %ProjectsFolder%%1\%2
) ELSE (
    mkdir %ProjectsFolder%%1\%2
    cd %ProjectsFolder%%1\%2
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
    IF "%2"==""  ( echo Need to specify platform )
    IF "%3"==""  ( echo Need to specify project )
    IF NOT  "%2"=="" IF NOT "%3"=="" ( 
        rmdir %ProjectsFolder%%2\%3 
        )      

GOTO:end

:showfolders
for /d %%e in (%1\*) do (
        @echo                         %%e
    )


:end