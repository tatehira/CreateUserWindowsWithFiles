@echo off
setlocal enabledelayedexpansion

set "user="
set "password="

for /f "tokens=1,2 delims=: " %%a in (UserForRemove.txt) do (
    if /i "%%a"=="user" (
        set "user=%%b"
    ) else if /i "%%a"=="password" (
        set "password=%%b"
    )
)

if "%user%"=="" (
    echo O arquivo UserForRemove.txt não contém um nome de usuário válido.
    exit /b 1
)

if "%password%"=="" (
    echo O arquivo UserForRemove.txt não contém uma password válida.
    exit /b 1
)

net user "%user%" "%password%" /delete
if %errorlevel%==0 (
    echo O usuário "%user%" foi removido com sucesso.
) else (
    echo O usuário "%user%" não foi encontrado ou já foi removido.
)

endlocal
