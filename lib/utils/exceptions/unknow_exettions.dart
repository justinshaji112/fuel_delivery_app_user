class AppUnknownException implements Exception {
  final String message;
  const AppUnknownException(
      [this.message = "An unknown error occurred. Please try again later."]);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }

  factory AppUnknownException.fromCode(String code) {
    switch (code) {
      case 'INTERNAL_ERROR':
        return const AppUnknownException(
            'Something went wrong internally. Please try again later.');
      case 'SERVER_ERROR':
        return const AppUnknownException(
            'Unable to connect to server. Please check your internet connection and try again.');
      case 'TIMEOUT_ERROR':
        return const AppUnknownException(
            'Request took too long to respond. Please check your internet connection and try again.');
      case 'UNEXPECTED_ERROR':
        return const AppUnknownException(
            'Something unexpected happened. Please try again later.');
      case 'DATA_PARSING_ERROR':
        return const AppUnknownException(
            'Unable to process the data. Please try again later.');
      case 'CACHE_ERROR':
        return const AppUnknownException(
            'Unable to access local storage. Please restart the app and try again.');
      case 'MEMORY_ERROR':
        return const AppUnknownException(
            'Your device is running low on memory. Please close some apps and try again.');
      case 'INITIALIZATION_ERROR':
        return const AppUnknownException(
            'Unable to start the application properly. Please restart the app.');
      case 'DEPENDENCY_ERROR':
        return const AppUnknownException(
            'Some app components failed to load. Please reinstall the app.');
      case 'STATE_ERROR':
        return const AppUnknownException(
            'The app is in an invalid state. Please restart the app and try again.');
      default:
        return const AppUnknownException(
            "An unknown error occurred. Please try again later.");
    }
  }
}
