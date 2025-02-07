class AppPlatformException implements Exception {
  final String message;
  final String userMessage;
  const AppPlatformException(
      [this.message = "Platform error occurred.",
      this.userMessage = "Something went wrong. Please try again."]);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }

  factory AppPlatformException.fromCode(String code) {
    switch (code) {
      case 'PERMISSION_DENIED':
        return const AppPlatformException('Permission denied',
            'Please grant the required permissions to use this feature.');
      case 'NETWORK_ERROR':
        return const AppPlatformException('Network error occurred',
            'Please check your internet connection and try again.');
      case 'DEVICE_ERROR':
        return const AppPlatformException('Device error occurred',
            'There seems to be an issue with your device. Please restart the app.');
      case 'LOCATION_ERROR':
        return const AppPlatformException('Location service error',
            'Please enable location services to use this feature.');
      case 'CAMERA_ERROR':
        return const AppPlatformException('Camera access error',
            'Unable to access camera. Please check camera permissions.');
      case 'STORAGE_ERROR':
        return const AppPlatformException('Storage access error',
            'Unable to access storage. Please check storage permissions.');
      case 'MICROPHONE_ERROR':
        return const AppPlatformException('Microphone access error',
            'Unable to access microphone. Please check microphone permissions.');
      case 'BLUETOOTH_ERROR':
        return const AppPlatformException('Bluetooth error occurred',
            'Please check if Bluetooth is enabled and try again.');
      case 'NOTIFICATION_ERROR':
        return const AppPlatformException('Notification error occurred',
            'Unable to show notifications. Please check notification permissions.');
      case 'BIOMETRIC_ERROR':
        return const AppPlatformException('Biometric authentication error',
            'Biometric authentication failed. Please try again or use an alternative method.');
      case 'BATTERY_ERROR':
        return const AppPlatformException('Battery optimization error',
            'Please disable battery optimization for this app to work properly.');
      case 'SCREEN_CAPTURE_ERROR':
        return const AppPlatformException('Screen capture error',
            'Unable to capture screen. Please check permissions.');
      case 'AUDIO_ERROR':
        return const AppPlatformException('Audio playback error',
            'Unable to play audio. Please check your device settings.');
      case 'SENSOR_ERROR':
        return const AppPlatformException('Device sensor error',
            'Unable to access device sensors. Please check your device settings.');
      case 'NFC_ERROR':
        return const AppPlatformException('NFC operation error',
            'NFC operation failed. Please ensure NFC is enabled and try again.');
      case 'WIFI_ERROR':
        return const AppPlatformException('WiFi connection error',
            'Please check your WiFi connection and try again.');
      case 'GPS_ERROR':
        return const AppPlatformException('GPS service error',
            'Unable to access GPS. Please enable GPS and try again.');
      case 'ACCELEROMETER_ERROR':
        return const AppPlatformException('Accelerometer error',
            'Unable to access accelerometer. Please check your device settings.');
      default:
        return const AppPlatformException("Platform error occurred",
            "Something went wrong. Please try again.");
    }
  }
}
