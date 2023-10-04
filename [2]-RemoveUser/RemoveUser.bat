@echo off
setlocal enabledelayedexpansion

set "usuario="
set "senha="

for /f "tokens=1,2 delims=: " %%a in (UserForRemove.txt) do (
    if /i "%%a"=="usuario" (
        set "usuario=%%b"
    ) else if /i "%%a"=="senha" (
        set "senha=%%b"
    )
)

if "%usuario%"=="" (
    echo O arquivo UserForRemove.txt não contém um nome de usuário válido.
    exit /b 1
)

if "%senha%"=="" (
    echo O arquivo UserForRemove.txt não contém uma senha válida.
    exit /b 1
)

net user "%usuario%" "%senha%" /delete
if %errorlevel%==0 (
    echo O usuário "%usuario%" foi removido com sucesso.
) else (
    echo O usuário "%usuario%" não foi encontrado ou já foi removido.
)

endlocal
