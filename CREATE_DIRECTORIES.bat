@echo off
echo Creating Letterboxd Clone Directory Structure...
echo.

mkdir letterboxd-clone\backend\config 2>nul
mkdir letterboxd-clone\backend\users 2>nul
mkdir letterboxd-clone\backend\movies 2>nul
mkdir letterboxd-clone\backend\reviews 2>nul
mkdir letterboxd-clone\backend\recommendations 2>nul
mkdir letterboxd-clone\frontend\src\components 2>nul
mkdir letterboxd-clone\frontend\src\pages 2>nul
mkdir letterboxd-clone\frontend\src\context 2>nul
mkdir letterboxd-clone\frontend\src\utils 2>nul
mkdir letterboxd-clone\frontend\public 2>nul

echo.
echo ================================================
echo Directory structure created successfully!
echo ================================================
echo.
echo Next steps:
echo 1. I will now create all application files
echo 2. Wait for file creation to complete
echo 3. Follow setup instructions in SETUP_GUIDE.md
echo.
pause
