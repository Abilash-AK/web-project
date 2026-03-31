@echo off
echo ============================================================
echo   LETTERBOXD CLONE - ONE-CLICK SETUP AND RUN
echo ============================================================
echo.

cd /d "%~dp0letterboxd-clone\backend"

echo [STEP 1/5] Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)
echo SUCCESS: Virtual environment created
echo.

echo [STEP 2/5] Installing backend dependencies...
venv\Scripts\pip.exe install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)
echo SUCCESS: Dependencies installed
echo.

echo [STEP 3/5] Running database migrations...
venv\Scripts\python.exe manage.py makemigrations
venv\Scripts\python.exe manage.py migrate
if errorlevel 1 (
    echo ERROR: Migration failed
    pause
    exit /b 1
)
echo SUCCESS: Database ready
echo.

echo [STEP 4/5] Installing frontend dependencies...
cd ..\frontend
call npm install
if errorlevel 1 (
    echo ERROR: Failed to install frontend dependencies
    pause
    exit /b 1
)
echo SUCCESS: Frontend dependencies installed
echo.

echo ============================================================
echo   SETUP COMPLETE! Starting servers...
echo ============================================================
echo.
echo Backend will run at: http://localhost:8000
echo Frontend will run at: http://localhost:5173
echo.
echo Press Ctrl+C in each window to stop the servers
echo.
pause

echo Starting backend server in new window...
cd ..\backend
start "Backend Server" cmd /k "venv\Scripts\activate && python manage.py runserver"

timeout /t 3 /nobreak > nul

echo Starting frontend server in new window...
cd ..\frontend
start "Frontend Server" cmd /k "npm run dev"

echo.
echo ============================================================
echo   SERVERS STARTED!
echo ============================================================
echo.
echo Open your browser at: http://localhost:5173
echo.
echo Two new windows opened:
echo   - Backend Server (Django)
echo   - Frontend Server (Vite)
echo.
echo Press any key to exit this window (servers will keep running)
pause > nul
