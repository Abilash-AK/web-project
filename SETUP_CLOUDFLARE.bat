@echo off
color 0B
echo.
echo ============================================================
echo   CLOUDFLARE D1 SETUP - LETTERBOXD CLONE
echo ============================================================
echo.
echo This script will help you set up Cloudflare D1 database
echo for production deployment.
echo.
echo PREREQUISITES:
echo   - Node.js installed
echo   - Cloudflare account
echo   - Internet connection
echo.
pause

echo.
echo ============================================================
echo   STEP 1: Installing Wrangler CLI
echo ============================================================
echo.
echo Checking if Wrangler is installed...
call wrangler --version >nul 2>&1
if errorlevel 1 (
    echo Wrangler not found. Installing...
    call npm install -g wrangler
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to install Wrangler
        pause
        exit /b 1
    )
    echo SUCCESS: Wrangler installed
) else (
    echo SUCCESS: Wrangler is already installed
)

echo.
echo ============================================================
echo   STEP 2: Login to Cloudflare
echo ============================================================
echo.
echo This will open your browser for authentication.
pause
call wrangler login
if errorlevel 1 (
    echo.
    echo ERROR: Failed to login to Cloudflare
    pause
    exit /b 1
)
echo SUCCESS: Logged in to Cloudflare

echo.
echo ============================================================
echo   STEP 3: Create D1 Database
echo ============================================================
echo.
cd letterboxd-clone\backend
echo Creating D1 database 'letterboxd-db'...
echo.
call wrangler d1 create letterboxd-db
if errorlevel 1 (
    echo.
    echo ERROR: Failed to create D1 database
    pause
    exit /b 1
)

echo.
echo ============================================================
echo   IMPORTANT: Copy the database_id!
echo ============================================================
echo.
echo From the output above, copy the 'database_id' value.
echo It looks like: database_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
echo.
echo You need to paste this into:
echo   letterboxd-clone\backend\wrangler.toml
echo.
echo Find the line that says: database_id = ""
echo And replace it with your actual database_id.
echo.
pause

echo.
echo ============================================================
echo   STEP 4: Apply Database Schema
echo ============================================================
echo.
set /p APPLY_SCHEMA="Have you updated wrangler.toml with the database_id? (y/n): "
if /i not "%APPLY_SCHEMA%"=="y" (
    echo.
    echo Please update wrangler.toml first, then run this script again.
    echo Or manually run: wrangler d1 execute letterboxd-db --file=d1_schema.sql
    pause
    exit /b 0
)

echo.
echo Applying database schema to D1...
call wrangler d1 execute letterboxd-db --file=d1_schema.sql
if errorlevel 1 (
    echo.
    echo ERROR: Failed to apply database schema
    echo You can try manually: wrangler d1 execute letterboxd-db --file=d1_schema.sql
    pause
    exit /b 1
)
echo SUCCESS: Database schema applied

echo.
echo ============================================================
echo   STEP 5: Verify Database
echo ============================================================
echo.
echo Listing tables in D1 database...
call wrangler d1 execute letterboxd-db --command="SELECT name FROM sqlite_master WHERE type='table'"

echo.
echo ============================================================
echo   SETUP COMPLETE!
echo ============================================================
echo.
echo Your Cloudflare D1 database is ready!
echo.
echo NEXT STEPS:
echo.
echo 1. For local development:
echo    - Continue using SQLite (db.sqlite3)
echo    - Run: RUN_BACKEND.bat and RUN_FRONTEND.bat
echo.
echo 2. To deploy to production:
echo    Backend:  wrangler deploy (in backend directory)
echo    Frontend: npm run build then wrangler pages deploy dist
echo.
echo 3. Useful commands:
echo    - View data: wrangler d1 execute letterboxd-db --command="SELECT * FROM users_user"
echo    - Database info: wrangler d1 info letterboxd-db
echo.
echo Full documentation: letterboxd-clone\CLOUDFLARE_D1_SETUP.md
echo.
pause

cd ..\..
