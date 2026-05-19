# Dawamy - Quick Start Script
# Run this script to start the full Dawamy environment

param(
    [switch]$BackendOnly,
    [switch]$AppOnly,
    [switch]$WebPreview
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   DAWAMY - Quick Start" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$rootDir = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not $AppOnly) {
    Write-Host "[1/3] Starting backend server..." -ForegroundColor Yellow
    $backendJob = Start-Job -ScriptBlock {
        param($dir)
        Set-Location $dir
        npm start
    } -ArgumentList "$rootDir\backend"
    Write-Host "  Backend starting on http://localhost:3000" -ForegroundColor Green
    Start-Sleep -Seconds 2
}

if (-not $BackendOnly) {
    if ($WebPreview) {
        Write-Host "[2/3] Building web preview..." -ForegroundColor Yellow
        & "$rootDir\dawamy_app\scripts\serve_web.ps1"
    } else {
        Write-Host "[2/3] Starting Flutter app..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "  Available commands:" -ForegroundColor Cyan
        Write-Host "  flutter run           - Run on connected device" -ForegroundColor White
        Write-Host "  flutter run -d chrome - Run in browser" -ForegroundColor White
        Write-Host "  .\scripts\serve_web   - Web with QR preview" -ForegroundColor White
        Write-Host ""

        Set-Location "$rootDir\dawamy_app"
        flutter run
    }
}

if (-not $AppOnly -and -not $BackendOnly) {
    Write-Host "[3/3] Environment ready!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Backend:  http://localhost:3000" -ForegroundColor Green
    Write-Host "  App:      Running in your device/browser" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   DAWAMY is running" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
