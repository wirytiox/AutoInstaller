@echo off

choco -v >nul 2>&1
if %errorlevel% equ 0 (
    echo Chocolatey is already installed on this system.
    
) else (
    echo Chocolatey is not installed on this system. Installing now...
    rd /s /q "C:\ProgramData\chocolatey"
    powershell.exe "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    echo Restart the Powershell and execute it with administrator privileges
)

curl --version > nul 2>&1
if %errorlevel% neq 0 (
    echo curl is not installed. Installing curl...
    powershell.exe -Command "choco install curl -y"
)
call :browser
set /p install_steam=Do you want to install Steam? (Y/N): 
if /i "%install_steam%"=="Y" (
    if not exist "%USERPROFILE%\Downloads" mkdir "%USERPROFILE%\Downloads"
    curl -L -o "%USERPROFILE%\Downloads\SteamSetup.exe" "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe"
    "%USERPROFILE%\Downloads\SteamSetup.exe"
    del "%USERPROFILE%\Downloads\SteamSetup.exe" /q
    echo Steam installation complete.
) else (
    echo Skipping Steam installation.
)

set /p install_lol=Do you want to install LoL? (Y/N): 
if /i "%install_lol%"=="Y" (
    curl -o "%USERPROFILE%\Downloads\live.la1.exe" "https://lol.secure.dyn.riotcdn.net/channels/public/x/installer/current/live.la1.exe"
    "%USERPROFILE%\Downloads\live.la1.exe"
    echo League of Legends installation complete.
) else (
    echo Skipping League of Legends installation.
)

set /p install_spotify=Do you want to install Spotify? (Y/N): 
if /i "%install_spotify%"=="Y" (
    curl -o %USERPROFILE%\Downloads\SpotifySetup.exe https://download.scdn.co/SpotifySetup.exe
    start "" "%USERPROFILE%\Downloads\SpotifySetup.exe"
    echo Spotify installation complete.
) else (
    echo Skipping Spotify installation.
)
set /p install_obs=Do you want to install OBS Studio? (Y/N): 
if /i "%install_obs%"=="Y" (
    powershell.exe -Command "choco install obs-studio -y"
    echo OBS Studio installation complete.
) else (
    echo Skipping OBS Studio installation.
)

set /p install_lghub=Do you want to install Logitech G Hub? (Y/N): 
if /i "%install_lghub%"=="Y" (
    powershell.exe -Command "choco install lghub -y"
    echo Logitech G Hub installation complete.
) else (
    echo Skipping Logitech G Hub installation.
)

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

echo YOU'RE GONNA GET HWINFO AND YOU WILL LOVE IT!!!
powershell.exe -Command "choco install hwinfo -y"
echo Installing latest JDK version.
powershell.exe -Command "choco install openjdk -y"
echo Installing latest Python version.
powershell.exe -Command "choco install python -y"
echo Installing whatsapp web.
start ms-windows-store://pdp/?productid=9NKSQGP7F2NH^&mode=mini

wmic path win32_videocontroller get caption | find /i "NVIDIA" > nul

if %ERRORLEVEL% equ 0 (
    echo NVIDIA GPU detected.
    start "" "https://la.nvidia.com/Download/index.aspx?lang=la"
) else (
    wmic path win32_videocontroller get caption | find /i "AMD" > nul
    if %ERRORLEVEL% equ 0 (
        echo AMD GPU detected.
        start "" "https://www.amd.com/es/support"
    ) else (
        echo GPU not detected or not supported.
    )
)
echo Installing CS:GO make sure to log in Steam!
start "" "steam://rungameid/730"
:browser
echo Choose explorer (1 Brave, 2 Chrome, 3 OperaGX, 4 Skip)
set /p explorer_choice=

if "%explorer_choice%"=="1" (
    powershell.exe -Command "choco install brave -y"
) else if "%explorer_choice%"=="2" (
    powershell.exe -Command "choco install googlechrome -y"
) else if "%explorer_choice%"=="3" (
    powershell.exe -Command "choco install opera-gx -y"
) else if "%explorer_choice%"=="4" (
    echo Skipping browser installation.
) else (
    echo Invalid choice. Please choose a valid option.
    goto :browser
)
exit /b
pause
