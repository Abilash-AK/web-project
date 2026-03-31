@echo off
echo Creating Letterboxd Clone Project Structure...

REM Create backend directories
mkdir letterboxd-clone\backend\config 2>nul
mkdir letterboxd-clone\backend\users 2>nul
mkdir letterboxd-clone\backend\movies 2>nul
mkdir letterboxd-clone\backend\reviews 2>nul
mkdir letterboxd-clone\backend\recommendations 2>nul

REM Create frontend directories
mkdir letterboxd-clone\frontend\src\components 2>nul
mkdir letterboxd-clone\frontend\src\pages 2>nul
mkdir letterboxd-clone\frontend\src\context 2>nul
mkdir letterboxd-clone\frontend\src\utils 2>nul
mkdir letterboxd-clone\frontend\public 2>nul

echo.
echo All directories created successfully!
echo You can now proceed with the application setup.
pause
