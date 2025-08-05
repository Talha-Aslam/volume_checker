# Volume Checker Using Methode Channels 

A Flutter application that demonstrates platform-specific native code integration by accessing the device's volume level through method channels.

## Overview

This project showcases how to communicate between Flutter and native Android code using MethodChannel. The app retrieves the current media volume level from the Android system and displays it in the Flutter UI.

## Features

- 📱 Cross-platform Flutter app
- 🔊 Real-time volume level detection
- 🔗 Native Android integration using MethodChannel
- 📊 Simple and clean user interface

## Screenshots

The app displays the current volume level and provides a button to refresh the volume information.

## Architecture

### Flutter Layer (Dart)
- **main.dart**: Contains the main Flutter application logic
- Uses `MethodChannel` to communicate with native Android code
- Handles platform exceptions gracefully

### Native Android Layer (Kotlin)
- **MainActivity.kt**: Implements the native Android functionality
- Uses `AudioManager` to access system volume levels
- Responds to Flutter method calls through MethodChannel

## Technical Implementation

### Method Channel Communication
- **Channel Name**: `samples.flutter.dev/volume`
- **Method**: `getVolume`
- **Return Type**: Integer (volume level)

### Android Permissions
The app uses the following Android system service:
- `AudioManager.STREAM_MUSIC` for media volume access

## Getting Started

### Prerequisites
- Flutter SDK (3.5.3 or higher)
- Android Studio or VS Code with Flutter extensions
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd volume_checker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK**
```bash
flutter build apk --release
```

**Android App Bundle**
```bash
flutter build appbundle --release
```

## Project Structure

```
volume_checker/
├── lib/
│   └── main.dart                 # Main Flutter application
├── android/
│   └── app/
│       └── src/
│           └── main/
│               └── kotlin/
│                   └── com/
│                       └── example/
│                           └── volume_checker/
│                               └── MainActivity.kt    # Native Android code
├── pubspec.yaml                  # Flutter dependencies
└── README.md                     # This file
```

## How It Works

1. **Flutter UI**: User taps the "Get Volume Level" button
2. **Method Channel**: Flutter calls the native `getVolume` method
3. **Native Android**: Kotlin code accesses the AudioManager service
4. **Volume Retrieval**: Gets current media stream volume level
5. **Response**: Returns volume level back to Flutter
6. **UI Update**: Flutter displays the volume level in the interface

## Code Examples

### Flutter Method Channel Call
```dart
static const volumeRoute = MethodChannel("samples.flutter.dev/volume");

Future<void> _getVolumeLevel() async {
  try {
    final int result = await volumeRoute.invokeMethod("getVolume");
    // Handle the result
  } on PlatformException catch (e) {
    // Handle platform-specific errors
  }
}
```

### Android Native Implementation
```kotlin
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, Volume_Channel)
    .setMethodCallHandler { call, result ->
        if (call.method == "getVolume") {
            val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
            result.success(currentVolume)
        } else {
            result.notImplemented()
        }
    }
```

## Supported Platforms

- ✅ Android
- ❌ iOS (not implemented)
- ❌ Web (not applicable)
- ❌ Desktop (not implemented)

## Error Handling

The app includes comprehensive error handling:
- Platform exception handling for method channel calls
- Graceful fallback when native methods fail
- User-friendly error messages

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Future Enhancements

- [ ] iOS implementation
- [ ] Volume control (set volume level)
- [ ] Real-time volume monitoring
- [ ] Volume slider UI component
- [ ] Multiple audio stream support

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Flutter team for the excellent framework
- Android AudioManager documentation
- Method Channel implementation examples

---

**Note**: This is a demonstration project for learning Flutter-native integration patterns.
