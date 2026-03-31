@echo off
color 0A
echo.
echo ========================================
echo   🎬 LETTERBOXD CLONE - COMPLETE SETUP
echo ========================================
echo.
echo This will set up BOTH backend and frontend
echo Please make sure you have:
echo   ✓ Python 3.9+ installed
echo   ✓ Node.js 18+ installed
echo   ✓ TMDb API key ready
echo.
pause
echo.

echo ========================================
echo   STEP 1: Backend Setup
echo ========================================
echo.
call SETUP_BACKEND.bat
if errorlevel 1 (
    echo.
    echo Backend setup failed!
    pause
    exit /b 1
)

echo.
echo.
echo ========================================
echo   STEP 2: Frontend Setup
echo ========================================
echo.
call SETUP_FRONTEND.bat
if errorlevel 1 (
    echo.
    echo Frontend setup failed!
    pause
    exit /b 1
)

echo.
echo.
echo ========================================
echo   ✅ COMPLETE SETUP SUCCESSFUL!
echo ========================================
echo.
echo Your Letterboxd clone is ready!
echo.
echo 📝 IMPORTANT NEXT STEPS:
echo.
echo 1. Add TMDb API Key:
echo    - Open: letterboxd-clone\backend\.env
echo    - Get key from: https://www.themoviedb.org/settings/api
echo    - Add: TMDB_API_KEY=your_key_here
echo.
echo 2. Start the servers:
echo    - Run RUN_BACKEND.bat (in one terminal)
echo    - Run RUN_FRONTEND.bat (in another terminal)
echo.
echo 3. Open your browser:
echo    - Go to: http://localhost:5173
echo.
echo ========================================
pause
