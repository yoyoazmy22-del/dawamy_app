# Dawamy - Shift Scheduler Reimagined

> A premium, production-ready mobile application for workforce shift scheduling. Built with Flutter, Clean Architecture, and modern UI/UX principles.

![Version](https://img.shields.io/badge/version-1.0.0-blueviolet)
![Flutter](https://img.shields.io/badge/Flutter-3.1+-blue)
![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen)

---

## ✨ Features

### Core
- 📅 **Interactive Calendar** - Monthly view with color-coded shifts, tap-to-inspect
- ⚙️ **Shift Patterns** - Create repeating schedules (work/off day cycles)
- 💾 **Offline-First** - Fully functional without internet (Hive local database)
- ☁️ **Cloud Sync** - Firebase integration with Pro plan
- 🛒 **Store Link** - Save and open your online store
- 👤 **Profile** - Theme settings, sync controls, subscription management

### Premium UI/UX
- Dark/Light mode with custom design system
- Glassmorphism cards and smooth animations (Flutter Animate)
- Skeleton loaders, micro-interactions, page transitions
- Haptic feedback support
- Responsive layout (Mobile & Tablet)
- Custom animated bottom navigation

### Architecture
- Clean Architecture (Feature-based modules)
- Repository pattern with dependency injection
- State management with Riverpod
- Offline-first with sync conflict handling
- Retry mechanism and error states

---

## 📱 Screens

| Screen | Description |
|--------|-------------|
| **Calendar** | Monthly grid with shift indicators, stats cards, day detail bottom sheet |
| **Shifts** | Create and manage repeating shift patterns (5/2, 4/3, etc.) |
| **Store** | Save your online store URL and open in browser |
| **Profile** | Theme toggle, sync controls, upgrade to Pro |

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (3.1.0 or higher)
- Node.js (18.x or higher) - for fallback backend
- Android Studio / Xcode (for mobile builds)
- Firebase project (optional, for cloud features)

### 1. Setup Flutter App

```bash
cd dawamy_app

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Run for web
flutter run -d chrome
```

### 2. Setup Fallback Backend (Optional)

```bash
cd backend

# Install dependencies
npm install

# Start server
npm start
# Server runs on http://localhost:3000
```

### 3. Web Preview with QR

```bash
cd dawamy_app

# Build web and serve with QR
powershell -ExecutionPolicy Bypass -File scripts/serve_web.ps1

# Or manually:
flutter build web
npx serve build/web -l 4173 --cors
```

---

## 🌐 Web Preview & QR System

The project includes a built-in web preview system:

1. **Auto-detect** your local network IP
2. **Serve** the Flutter web build
3. **Generate** a working QR code
4. **Scan** with your mobile device (same WiFi)

```bash
# Full auto setup
cd dawamy_app
.\scripts\serve_web.ps1

# Release mode
.\scripts\serve_web.ps1 -Release

# Without QR
.\scripts\serve_web.ps1 -NoQR
```

---

## 📁 Project Structure

```
dawamy/
├── dawamy_app/          # Flutter Application
│   ├── lib/
│   │   ├── core/        # Shared infrastructure
│   │   │   ├── constants/
│   │   │   ├── theme/   # Light/Dark theme, typography
│   │   │   ├── utils/   # Responsive, date utils, validators
│   │   │   ├── widgets/ # Reusable components
│   │   │   └── errors/  # Failure types
│   │   ├── features/    # Feature modules
│   │   │   ├── calendar/
│   │   │   ├── shifts/
│   │   │   ├── store/
│   │   │   ├── auth/
│   │   │   ├── profile/
│   │   │   └── sync/
│   │   ├── services/    # HTTP, Firebase, Hive
│   │   ├── di/          # Dependency injection
│   │   ├── app.dart     # App shell
│   │   └── main.dart    # Entry point
│   └── scripts/         # Web preview & QR
├── backend/             # Node.js Fallback Backend
│   └── src/
│       ├── config/
│       ├── controllers/
│       ├── routes/
│       ├── services/
│       └── middleware/
└── README.md
```

---

## 🔌 API Endpoints (Backend)

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/health` | Server health check |
| `GET` | `/api/sync?userId=xxx` | Get user sync data |
| `POST` | `/api/sync` | Save user sync data |

---

## 💳 Subscription Model

### Free Plan
- Monthly calendar view
- Basic shift scheduling
- Local storage only
- Store link saving

### Pro Plan
- Everything in Free
- Cloud sync (Firebase)
- Multi-device access
- Backup & restore
- Shift analytics
- Priority support

---

## 🔥 Firebase Integration

The app is pre-configured for Firebase. To enable:

1. Create a Firebase project
2. Add Android/iOS/Web apps
3. Download `google-services.json` / `GoogleService-Info.plist`
4. Place in respective platform folders
5. Update `.env` with Firebase config

### Cloud Data Model

```json
{
  "userId": "string",
  "username": "string",
  "email": "string",
  "subscriptionPlan": "free | pro",
  "monthlyShiftConfigs": {},
  "overtimeStats": {},
  "storeUrl": "string",
  "preferences": {},
  "lastSyncAt": "timestamp"
}
```

---

## 🎨 Design System

- **Typography**: Inter (300-700 weight)
- **Colors**: Purple primary (#6C5CE7), Teal secondary (#00CEC9)
- **Components**: Glass cards, skeleton loaders, animated nav
- **Animations**: Flutter Animate, smooth transitions, micro-interactions

---

## 🧪 Testing

```bash
# Run tests
cd dawamy_app
flutter test

# Lint
flutter analyze
```

---

## 🏗️ Production Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

---

## 📄 Environment Configuration

Copy `.env.example` to `.env` and configure:

```
API_BASE_URL=http://192.168.1.5:3000/api
USE_FALLBACK_BACKEND=true
```

---

## 🤝 Contributing

This is an MVP/prototype. Contributions and suggestions are welcome.

---

## 📝 License

MIT

---

<div align="center">
  <strong>Dawamy</strong> — Shift Scheduling, Reimagined.
</div>
