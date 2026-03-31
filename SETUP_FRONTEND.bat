@echo off
echo ========================================
echo   Letterboxd Clone - Frontend Setup
echo ========================================
echo.

cd letterboxd-clone\frontend

echo [1/3] Installing dependencies...
call npm install
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    echo Make sure Node.js and npm are installed
    pause
    exit /b 1
)
echo ✓ Dependencies installed
echo.

echo [2/3] Creating .env file...
if not exist .env (
    copy .env.example .env
    echo ✓ .env file created
) else (
    echo .env file already exists
)
echo.

echo [3/3] Building complete...
echo ✓ Frontend setup complete
echo.

echo ========================================
echo   Frontend Setup Complete!
echo ========================================
echo.
echo To start the frontend server, run:
echo    cd letterboxd-clone\frontend
echo    npm run dev
echo.
echo The app will open at: http://localhost:5173
echo.
pause
