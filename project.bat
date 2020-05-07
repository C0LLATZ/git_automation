@echo off

set ProjectsFolder= C:\Users\c0llat2\OneDrive\Projects\

set str1=%1
IF  x%str1:-=%==x%str1% (
    GOTO:DIR
) ELSE (
    IF %1 == -list (
        GOTO:list
    ) ELSE (
        GOTO:end
    )
)

:DIR
IF EXIST %ProjectsFolder%%1\ (
    cd %ProjectsFolder%%1
    for /d %%e in (*) do (
        @echo    %%e
    )

) ELSE (
    mkdir %ProjectsFolder%%1
    cd %ProjectsFolder%%1
)

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

:showfolders
for /d %%e in (%1\*) do (
        @echo                         %%e
    )


:end