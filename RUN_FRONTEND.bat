@echo off
echo ========================================
echo   Starting Frontend Server
echo ========================================
echo.

cd letterboxd-clone\frontend

if not exist node_modules (
    echo ERROR: Dependencies not installed!
    echo Please run SETUP_FRONTEND.bat first
    pause
    exit /b 1
)

echo.
echo Starting Vite development server...
echo Server will run at: http://localhost:5173
echo.
echo Press Ctrl+C to stop the server
echo.
call npm run dev
