class AppConstants {
  AppConstants._();

  static const String appName = 'Pet Log';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'pet_log_db';

  // Kcal recommendations per kg body weight per day
  static const Map<String, double> dailyKcalPerKg = {
    'dog_puppy': 50.0,
    'dog_adult': 30.0,
    'dog_senior': 25.0,
    'cat_kitten': 60.0,
    'cat_adult': 40.0,
    'cat_senior': 35.0,
  };

  // Image
  static const int maxImageWidth = 800;
  static const int maxImageHeight = 800;
  static const int imageQuality = 85;

  // Notifications
  static const String notificationChannelId = 'pet_log_reminders';
  static const String notificationChannelName = 'Pet Log Reminders';
  static const String notificationChannelDescription =
      'Notifications for pet care reminders';
}
