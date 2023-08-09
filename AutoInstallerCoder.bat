@echo off
echo Do you want to install Visual Studio Code with Chocolatey? (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    echo Installing Visual Studio Code...
    powershell.exe -Command "choco install vscode -y"
) else (
    echo Skipping installation of Visual Studio Code.
)
echo Do you want to install Notepad++ with Chocolatey? (Y/N)
set /p choice=
if /i "%choice%"=="Y" (
    echo Installing Notepad++...
    powershell.exe -Command "choco install notepadplusplus -y"
) else (
    echo Skipping installation of Notepad++.
)
pause