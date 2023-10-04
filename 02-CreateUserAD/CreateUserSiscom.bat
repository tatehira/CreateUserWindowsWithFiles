@echo off
setlocal enabledelayedexpansion

:listarUsuarios
cls
net group "Siscom-Dev" /domain

:menu
echo.
echo [1] Adicionar usuario
echo [2] Remover usuario
echo [3] Sair
echo.
set /p escolha=Escolha uma opcao: 
echo.

if "%escolha%"=="1" (
    call :adicionarUsuario
) else if "%escolha%"=="2" (
    call :removerUsuario
) else if "%escolha%"=="3" (
    exit /b 0
) else (
    echo Opcao invalida. Por favor, escolha uma opcao valida.
    pause
    cls
    net group "Siscom-Dev" /domain
    goto :menu
)

exit /b 0

:adicionarUsuario
set /p nome=Digite o nome do usuario: 
echo.
set /p senha=Digite a senha do usuario: 
echo.
set "senhaValida=false"

if "!senha:~7,1!" neq "" (
    for %%c in (!senha!) do (
        set "char=%%c"
        echo !char! | findstr /r "[!@#$%^&*()_+={}\[\]:;<>?~]" >nul && (
            echo !char! | findstr /r "[A-Z]" >nul && (
                set "senhaValida=true"
            )
        )
    )
)

if !senhaValida! == false (
    echo A senha nao atende aos requisitos minimos.
    echo.
    pause
    cls
    net group "Siscom-Dev" /domain
    goto :menu
)

REM Verificar se o usuário já está no grupo "Siscom-Dev"
net group "Siscom-Dev" /domain | findstr /i /c:"%nome%" >nul
if !errorlevel!==0 (
    echo Usuario ja existe no grupo "Siscom-Dev".
    pause
    cls
    net group "Siscom-Dev" /domain
    goto :menu
)

echo ==========================
echo UsuarioAdicionado %nome% >> UsuariosSiscom.txt
echo. >> UsuariosSiscom.txt
echo SenhaAdicionada %senha% >> UsuariosSiscom.txt
echo ========================== >> UsuariosSiscom.txt
echo. >> UsuariosSiscom.txt

net user %nome% %senha% /add
net group "Siscom-Dev" %nome% /add
pause
cls
net group "Siscom-Dev" /domain
goto :menu

:removerUsuario
set /p nome=Digite o nome do usuario a ser removido: 

REM Verificar se o usuário está no grupo "Siscom-Dev"
net group "Siscom-Dev" /domain | findstr /i /c:"%nome%" >nul
if !errorlevel!==1 (
    echo Usuario nao encontrado no grupo "Siscom-Dev".
    pause
    cls
    net group "Siscom-Dev" /domain
    goto :menu
)

REM Obter a senha do usuário antes de excluí-lo
for /f "tokens=*" %%a in ('net user %nome% /domain ^| findstr /i "Senha"') do (
    echo SenhaExcluida %%a >> UsuariosSiscom.txt
)

net user %nome% /delete /y
net group "Siscom-Dev" %nome% /delete /y

REM Adicionar a informação do usuário excluído no arquivo UsuariosSiscom.txt
echo UsuarioExcluido %nome% >> UsuariosSiscom.txt
echo. >> UsuariosSiscom.txt

pause
cls
net group "Siscom-Dev" /domain
goto :menu
