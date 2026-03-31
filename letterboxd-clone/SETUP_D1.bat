@echo off
echo ============================================================
echo   CLOUDFLARE D1 DATABASE SETUP
echo ============================================================
echo.

echo This script will help you set up Cloudflare D1 database.
echo.
echo Prerequisites:
echo   1. Cloudflare account (free tier available)
echo   2. Node.js installed
echo.

pause

echo.
echo [STEP 1/5] Installing Wrangler CLI...
call npm install -g wrangler
if errorlevel 1 (
    echo ERROR: Failed to install Wrangler
    pause
    exit /b 1
)
echo SUCCESS: Wrangler installed
echo.

echo [STEP 2/5] Logging in to Cloudflare...
echo A browser window will open for authentication...
call wrangler login
if errorlevel 1 (
    echo ERROR: Login failed
    pause
    exit /b 1
)
echo SUCCESS: Logged in
echo.

echo [STEP 3/5] Creating D1 Database...
cd /d "%~dp0letterboxd-clone\backend"
call wrangler d1 create letterboxd-db
echo.
echo IMPORTANT: Copy the 'database_id' from the output above!
echo You need to add it to wrangler.toml
echo.
pause

echo.
echo [STEP 4/5] Generating database schema...
if not exist venv (
    python -m venv venv
)
call venv\Scripts\activate
python manage.py makemigrations
python manage.py migrate

echo Exporting schema for D1...
python manage.py sqlmigrate users 0001 > d1_schema.sql
python manage.py sqlmigrate movies 0001 >> d1_schema.sql
python manage.py sqlmigrate reviews 0001 >> d1_schema.sql
echo.
echo SUCCESS: Schema exported to d1_schema.sql
echo.

echo [STEP 5/5] Do you want to apply schema to D1 now?
echo Make sure you updated wrangler.toml with database_id first!
echo.
set /p apply="Apply schema to D1? (y/n): "
if /i "%apply%"=="y" (
    call wrangler d1 execute letterboxd-db --file=d1_schema.sql
    echo SUCCESS: Schema applied to D1!
) else (
    echo Skipped. You can apply later with:
    echo   wrangler d1 execute letterboxd-db --file=d1_schema.sql
)
echo.

echo ============================================================
echo   D1 SETUP COMPLETE!
echo ============================================================
echo.
echo Next steps:
echo   1. Update wrangler.toml with your database_id
echo   2. Add TMDB_API_KEY to wrangler.toml [vars] section
echo   3. Run START_WEBSITE.bat for local development
echo   4. Run 'wrangler deploy' when ready for production
echo.
pause
