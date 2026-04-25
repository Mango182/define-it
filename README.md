# Define It

A Flutter application for looking up word definitions with pronunciations, audio playback, and bookmarking capabilities.

## Features

- **Word Search** - Look up definitions for any word using a dictionary API
- **Audio Pronunciation** - Listen to word pronunciations with built-in audio playback
- **Bookmark Favorites** - Save your favorite words for quick access
- **Search History** - Keep track of recently searched words
- **Dark/Light Theme** - Toggle between dark and light modes
- **Offline Access** - Store bookmarked words in local SQLite database
- **Cross-Platform** - Built for iOS and Android

## Screenshots

| Home Screen | Bookmarks | Settings |
|---|---|---|
| ![Home Screen](screenshots/home.png) | ![Bookmarks](screenshots/bookmarks.png) | ![Settings](screenshots/settings.png) |

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
├── database/                 # Local database
│   ├── dao/                  # Data Access Objects
│   └── entities/             # Database models
├── services/                 # Business logic
├── models/                   # Data models
├── providers/                # State providers
└── widgets/                  # Reusable components
```

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK included with Flutter
- An IDE (VS Code, Android Studio, or Xcode)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Mango182/define-it.git
   cd define-it/define_it
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Floor database code**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Building for Release

### Android
```bash
flutter build apk --release
# or for app bundle
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release --no-codesign
```
For installable iOS builds, Apple code signing is required.

## Key Dependencies

| Package | Purpose |
|---------|---------|
| `provider` | State management |
| `floor` | ORM for SQLite database |
| `http` | HTTP requests for API calls |
| `audioplayers` | Audio playback |
| `shared_preferences` | Simple key-value storage |
| `fluttertoast` | Toast notifications |

## Credits
- **App Icon Artwork** - Created by [ChristM103](https://github.com/christM103)

## Version 

Current Version: 1.0.0

## License

This is a personal project. All rights reserved.
