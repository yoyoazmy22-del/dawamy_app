#!/usr/bin/env bash
# Dawamy - Web Preview & QR System (Mac/Linux)
# Detects local IP, serves Flutter web, generates QR code

set -e

PORT=${1:-4173}
BUILD_MODE=${2:-debug}

if ! command -v flutter &> /dev/null; then
    echo "Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "========================================"
echo "   DAWAMY - Web Preview System"
echo "========================================"
echo ""

echo "Building Flutter web app ($BUILD_MODE mode)..."
if [ "$BUILD_MODE" = "release" ]; then
    flutter build web --release
else
    flutter build web --debug
fi
echo "Build complete!"
echo ""

# Detect local IP
IP=$(ipconfig getifaddr en0 2>/dev/null || ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -1)
if [ -z "$IP" ]; then
    IP="localhost"
fi

echo "Detected IP: $IP"
echo ""

# Install serve if needed
if ! command -v npx &> /dev/null; then
    echo "npx is required. Installing..."
    npm install -g npx
fi

echo "Starting server..."
npx serve build/web -l $PORT --cors &
SERVER_PID=$!

sleep 2

URL="http://$IP:$PORT"
echo ""
echo "========================================"
echo "  Local server running at:"
echo "  $URL"
echo ""
echo "  Also available at:"
echo "  http://localhost:$PORT"
echo "========================================"
echo ""

if command -v qrcode &> /dev/null; then
    echo "QR Code for mobile preview:"
    npx -y qrcode-terminal "$URL" 2>/dev/null || true
    echo ""
    echo "Scan the QR code with your mobile device"
    echo "(Must be on the same WiFi network)"
fi

echo ""
echo "----------------------------------------"
echo "  Press Ctrl+C to stop the server"
echo "----------------------------------------"

trap "kill $SERVER_PID 2>/dev/null; exit" SIGINT SIGTERM
wait $SERVER_PID
