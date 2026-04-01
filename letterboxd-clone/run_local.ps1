# run_local.ps1
# This script starts both the frontend and backend of the application locally

Write-Host "Starting Backend..." -ForegroundColor Green
$backendProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; if (Test-Path '..\..\.venv\Scripts\Activate.ps1') { ..\..\.venv\Scripts\Activate.ps1 } elseif (Test-Path '.venv\Scripts\Activate.ps1') { .venv\Scripts\Activate.ps1 }; python manage.py runserver" -PassThru

Write-Host "Starting Frontend..." -ForegroundColor Green
$frontendProcess = Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev" -PassThru

Write-Host "Services are starting in separate windows." -ForegroundColor Cyan
Write-Host "To stop the servers, close the new PowerShell windows." -ForegroundColor Yellow
