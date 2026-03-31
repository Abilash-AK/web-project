@echo off
echo ========================================
echo   Letterboxd Clone - Backend Setup
echo ========================================
echo.

cd letterboxd-clone\backend

echo [1/6] Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    echo Make sure Python is installed and in PATH
    pause
    exit /b 1
)
echo ✓ Virtual environment created
echo.

echo [2/6] Activating virtual environment...
call venv\Scripts\activate.bat
echo ✓ Virtual environment activated
echo.

echo [3/6] Installing dependencies...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)
echo ✓ Dependencies installed
echo.

echo [4/6] Creating .env file...
if not exist .env (
    copy .env.example .env
    echo ✓ .env file created
    echo.
    echo ⚠️  IMPORTANT: Edit .env and add your TMDb API key!
    echo    Get one free at: https://www.themoviedb.org/settings/api
    echo.
) else (
    echo .env file already exists
)
echo.

echo [5/6] Running database migrations...
python manage.py makemigrations
python manage.py migrate
if errorlevel 1 (
    echo ERROR: Migration failed
    pause
    exit /b 1
)
echo ✓ Database migrations completed
echo.

echo [6/6] Creating superuser (optional)...
echo.
set /p create_super="Do you want to create a superuser? (y/n): "
if /i "%create_super%"=="y" (
    python manage.py createsuperuser
)
echo.

echo ========================================
echo   Backend Setup Complete!
echo ========================================
echo.
echo ⚠️  Before starting the server:
echo    1. Edit backend\.env
echo    2. Add your TMDb API key
echo.
echo To start the backend server, run:
echo    cd letterboxd-clone\backend
echo    venv\Scripts\activate
echo    python manage.py runserver
echo.
pause
