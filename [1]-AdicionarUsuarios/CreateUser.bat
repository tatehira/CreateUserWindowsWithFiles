@echo off
setlocal enabledelayedexpansion

set "usuario="
set "senha="

for /f "tokens=1,2 delims=: " %%a in (AddUser.txt) do (
    if /i "%%a"=="usuario" (
        set "usuario=%%b"
    ) else if /i "%%a"=="senha" (
        set "senha=%%b"
    )
)

if "%usuario%"=="" (
    echo O arquivo AddUser.txt não contém um nome de usuário válido.
    exit /b 1
)

if "%senha%"=="" (
    echo O arquivo AddUser.txt não contém uma senha válida.
    exit /b 1
)

net user "%usuario%" "%senha%" /add
if %errorlevel%==0 (
    echo O usuário "%usuario%" foi criado com sucesso.
) else (
    echo O usuário "%usuario%" já existe.
)

endlocal
