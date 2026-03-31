@echo off
echo ============================================================
echo   LETTERBOXD CLONE - QUICK RUN (No Setup)
echo ============================================================
echo.
echo This assumes you've already run setup once
echo.

cd /d "%~dp0letterboxd-clone"

echo Starting Backend Server...
cd backend
start "Backend Server" cmd /k "venv\Scripts\activate && python manage.py runserver"

timeout /t 2 /nobreak > nul

echo Starting Frontend Server...
cd ..\frontend
start "Frontend Server" cmd /k "npm run dev"

echo.
echo ============================================================
echo   SERVERS STARTED!
echo ============================================================
echo.
echo Backend: http://localhost:8000
echo Frontend: http://localhost:5173
echo.
echo Open your browser at: http://localhost:5173
echo.
pause
