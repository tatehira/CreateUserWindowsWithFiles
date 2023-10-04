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
    echo O arquivo UserForRemove.txt n�o cont�m um nome de usu�rio v�lido.
    exit /b 1
)

if "%senha%"=="" (
    echo O arquivo UserForRemove.txt n�o cont�m uma senha v�lida.
    exit /b 1
)

net user "%usuario%" "%senha%" /delete
if %errorlevel%==0 (
    echo O usu�rio "%usuario%" foi removido com sucesso.
) else (
    echo O usu�rio "%usuario%" n�o foi encontrado ou j� foi removido.
)

endlocal
