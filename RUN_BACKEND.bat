@echo off
echo ========================================
echo   Starting Backend Server
echo ========================================
echo.

cd letterboxd-clone\backend

if not exist venv (
    echo ERROR: Virtual environment not found!
    echo Please run SETUP_BACKEND.bat first
    pause
    exit /b 1
)

echo Activating virtual environment...
call venv\Scripts\activate.bat

echo.
echo Starting Django server...
echo Server will run at: http://localhost:8000
echo.
echo Press Ctrl+C to stop the server
echo.
python manage.py runserver
