class AppFormatException implements Exception {
  final String message;
  const AppFormatException([this.message = "Please enter a valid format."]);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }

  factory AppFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid_json':
        return const AppFormatException('Please enter a valid JSON format');
      case 'invalid_date':
        return const AppFormatException('Please enter a valid date');
      case 'invalid_number':
        return const AppFormatException('Please enter a valid number');
      case 'invalid_email':
        return const AppFormatException('Please enter a valid email address');
      case 'invalid_phone':
        return const AppFormatException('Please enter a valid phone number');
      case 'invalid_url':
        return const AppFormatException('Please enter a valid URL');
      case 'invalid_time':
        return const AppFormatException('Please enter a valid time');
      case 'invalid_currency':
        return const AppFormatException('Please enter a valid currency amount');
      case 'invalid_ip':
        return const AppFormatException('Please enter a valid IP address');
      case 'invalid_file':
        return const AppFormatException('Please select a valid file format');
      case 'invalid_color':
        return const AppFormatException('Please enter a valid color code');
      case 'invalid_uuid':
        return const AppFormatException('Please enter a valid UUID');
      default:
        return const AppFormatException('Please enter a valid format');
    }
  }
}
