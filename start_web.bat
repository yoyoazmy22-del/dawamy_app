@echo off
cd /d "E:\app\dawamy\dawamy_app\build\web"
echo ========================================
echo   DAWAMY - Web Preview
echo ========================================
echo.
echo Your IP addresses:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /R "IPv4"') do (
    echo   http://%%a:4173
)
echo   http://localhost:4173
echo.
echo ========================================
echo   Press Ctrl+C to stop the server
echo ========================================
echo.
node server.js
pause
