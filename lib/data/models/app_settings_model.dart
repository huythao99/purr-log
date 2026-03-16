import 'package:isar/isar.dart';

part 'app_settings_model.g.dart';

@collection
class AppSettings {
  Id id = 0; // Single settings record

  late bool onboardingCompleted;

  late bool notificationsEnabled;

  late DateTime createdAt;

  late DateTime updatedAt;
}
