@echo off
:main
cls
echo ==============================
echo PsExec Remote Management Tool
echo ==============================
set /p pcName=Digite o nome do computador: 

:menu
cls
echo ==============================
echo PsExec Remote Management Tool
echo Computador: %pcName%
echo ==============================
echo [Gerenciamento de Processos]
echo 1. Listar processos (tasklist)
echo 2. Matar processo por nome (taskkill /IM)
echo 3. Matar processo por PID (taskkill /PID)
echo [Sistema e Disco]
echo 4. Verificar disco (chkdsk)
echo 5. Verificar integridade do sistema (sfc /scannow)
echo 6. Atualizar Windows
echo 7. Apagar arquivos da pasta temp
echo [Mensagens e Rede]
echo 8. Enviar mensagem (msg)
echo 9. Ver mapeamentos de rede (net use)
echo 10. Ver IP (ipconfig)
echo [Programas]
echo 11. Ver lista de programas para atualizar (winget list)
echo 12. Atualizar programas (winget upgrade --all)
echo 13. Atualizar programa específico (winget upgrade)
echo [Outros]
echo 14. Abrir cmd no computador remoto
echo 15. Reiniciar o computador (shutdown -r -t 00)
echo 16. Sair
echo ==============================
set /p choice=Escolha uma opcao (1-16): 

if '%choice%'=='1' goto tasklist
if '%choice%'=='2' goto taskkill_name
if '%choice%'=='3' goto taskkill_pid
if '%choice%'=='4' goto chkdsk
if '%choice%'=='5' goto sfc
if '%choice%'=='6' goto update_windows
if '%choice%'=='7' goto delete_temp
if '%choice%'=='8' goto msg
if '%choice%'=='9' goto net_use
if '%choice%'=='10' goto ipconfig
if '%choice%'=='11' goto winget_list
if '%choice%'=='12' goto winget_upgrade
if '%choice%'=='13' goto select_upgrade
if '%choice%'=='14' goto open_cmd
if '%choice%'=='15' goto shutdown
if '%choice%'=='16' goto end

goto menu

:tasklist
C:\PSTools\psexec \\%pcName% tasklist
pause
goto menu

:taskkill_name
set /p procName=Digite o nome do processo: 
C:\PSTools\psexec \\%pcName% taskkill /IM %procName% /F
pause
goto menu

:taskkill_pid
set /p procPID=Digite o PID do processo: 
C:\PSTools\psexec \\%pcName% taskkill /PID %procPID% /F
pause
goto menu

:chkdsk
C:\PSTools\psexec \\%pcName% chkdsk
pause
goto menu

:sfc
C:\PSTools\psexec \\%pcName% sfc /scannow
pause
goto menu

:update_windows
C:\PSTools\psexec \\%pcName% usoclient StartScan
C:\PSTools\psexec \\%pcName% usoclient StartInstall
pause
goto menu

:delete_temp
C:\PSTools\psexec \\%pcName% cmd /c "del /q/f/s %TEMP%\*"
pause
goto menu

:msg
set /p message=Digite a mensagem: 
C:\PSTools\psexec \\%pcName% msg * "%message%"
pause
goto menu

:net_use
C:\PSTools\psexec \\%pcName% net use
pause
goto menu

:ipconfig
C:\PSTools\psexec \\%pcName% ipconfig
pause
goto menu

:winget_list
C:\PSTools\psexec \\%pcName% winget list > %TEMP%\winget_list.txt
C:\PSTools\psexec \\%pcName% type %TEMP%\winget_list.txt
pause
goto menu

:winget_upgrade
C:\PSTools\psexec \\%pcName% winget upgrade --all
pause
goto menu

:select_upgrade
C:\PSTools\psexec \\%pcName% winget list > %TEMP%\winget_list.txt
C:\PSTools\psexec \\%pcName% type %TEMP%\winget_list.txt
echo ==============================
echo Digite o nome do programa que deseja atualizar:
set /p programName=
C:\PSTools\psexec \\%pcName% winget upgrade --id %programName%
pause
goto menu

:open_cmd
C:\PSTools\psexec \\%pcName% cmd
pause
goto menu

:shutdown
C:\PSTools\psexec \\%pcName% shutdown -r -t 00
pause
goto menu

:end
echo Saindo...
pause
