@echo off
setlocal

echo ===================================================
echo    MySpy Cursor - Installation Script for Windows
echo ===================================================
echo.

:: 1. Check for Python
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not installed or not in your PATH.
    echo Please install Python (3.12 is recommended) from https://www.python.org/downloads/
    echo [IMPORTANT] Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
)
echo [OK] Python is found.
echo.

:: 2. Create Virtual Environment
if not exist "venv" (
    echo [INFO] Creating virtual environment (venv)...
    python -m venv venv
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create venv.
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created.
) else (
    echo [INFO] venv already exists.
)
echo.

:: 3. Install Dependencies into venv
echo [INFO] Installing required libraries into venv...
call venv\Scripts\activate.bat
pip install --upgrade pip
pip install -r facebook-ads-library-mcp/requirements.txt
if %errorlevel% neq 0 (
    echo [ERROR] Failed to install dependencies.
    pause
    exit /b 1
)
echo [OK] Dependencies installed successfully.
echo.

:: 4. Setup .env file
if not exist ".env" (
    echo [INFO] Creating .env config file from template...
    copy "facebook-ads-library-mcp\.env.template" ".env" >nul
    echo [OK] .env file created. 
    echo [IMPORTANT] OPEN THE .env FILE AND PASTE YOUR API KEYS!
) else (
    echo [INFO] .env file already exists. Skipping creation.
)



echo.
echo ===================================================
echo    Installation Complete!
echo ===================================================
echo.
echo IMPORTANT NEXT STEPS:
echo 1. Open the ".env" file and add your API keys.
echo 2. In Cursor (Settings -> Tools & MCP), use this path for Python:
echo.
echo    %CD%\venv\Scripts\python.exe
echo.
pause
