# Dawamy - Web Preview & QR System
# This script automatically detects your local IP, serves the Flutter web app,
# and generates a QR code for mobile preview.

param(
    [switch]$NoQR,
    [int]$Port = 4173,
    [switch]$Release
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   DAWAMY - Web Preview System" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Build the Flutter web app
$buildType = if ($Release) { "release" } else { "debug" }
Write-Host "Building Flutter web app ($buildType mode)..." -ForegroundColor Yellow

$buildResult = if ($Release) {
    flutter build web --release 2>&1
} else {
    flutter build web --debug 2>&1
}

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed. Please check your Flutter installation." -ForegroundColor Red
    exit 1
}

Write-Host "Build complete!" -ForegroundColor Green
Write-Host ""

# Detect local IP
Write-Host "Detecting local network IP..." -ForegroundColor Yellow
$localIPs = Get-NetIPAddress -AddressFamily IPv4 | Where-Object {
    $_.InterfaceAlias -notmatch 'Loopback|Loopback Pseudo-Interface|Virtual|Bluetooth' -and
    $_.PrefixOrigin -ne 'WellKnown' -and
    $_.IPAddress -match '^192\.|^10\.|^172\.'
}

$localIP = $localIPs | Select-Object -First 1
$ipAddress = if ($localIP) { $localIP.IPAddress } else { "localhost" }

Write-Host "Detected IP: $ipAddress" -ForegroundColor Green
Write-Host ""

# Start local server
$serverProcess = Start-Process -NoNewWindow -PassThru -FilePath "npx" -ArgumentList "serve", "build/web", "-l", "$Port", "--cors"

Start-Sleep -Seconds 2

$url = "http://$ipAddress`:$Port"
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Local server running at:" -ForegroundColor Green
Write-Host "  $url" -ForegroundColor White
Write-Host ""
Write-Host "  Also available at:" -ForegroundColor Green
Write-Host "  http://localhost:$Port" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (-not $NoQR) {
    Write-Host "Generating QR code for mobile preview..." -ForegroundColor Yellow

    # Try to install and use qrcode-terminal
    $qrExists = Get-Command "npx" -ErrorAction SilentlyContinue
    if ($qrExists) {
        npx -y qrcode-terminal "$url" 2>$null
        Write-Host ""
        Write-Host "Scan the QR code above with your mobile device" -ForegroundColor Cyan
        Write-Host "Make sure your device is on the same WiFi network" -ForegroundColor Cyan
    }
}

Write-Host ""
Write-Host "----------------------------------------" -ForegroundColor Gray
Write-Host "  Press Ctrl+C to stop the server" -ForegroundColor Gray
Write-Host "----------------------------------------" -ForegroundColor Gray

# Keep the script running
try {
    Wait-Process -Id $serverProcess.Id
} catch {
    Write-Host "Server stopped." -ForegroundColor Yellow
}
