@echo off
setlocal enabledelayedexpansion

set "user="
set "password="

for /f "tokens=1,2 delims=: " %%a in (AddUser.txt) do (
    if /i "%%a"=="user" (
        set "user=%%b"
    ) else if /i "%%a"=="password" (
        set "password=%%b"
    )
)

if "%user%"=="" (
    echo O arquivo AddUser.txt n�o cont�m um nome de usu�rio v�lido.
    exit /b 1
)

if "%password%"=="" (
    echo O arquivo AddUser.txt n�o cont�m uma password v�lida.
    exit /b 1
)

net user "%user%" "%password%" /add
if %errorlevel%==0 (
    echo O usu�rio "%user%" foi criado com sucesso.
) else (
    echo O usu�rio "%user%" j� existe.
)

endlocal
