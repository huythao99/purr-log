import 'package:get_it/get_it.dart';

import '../../data/datasources/database_service.dart';
import '../../data/repositories/pet_repository.dart';
import '../../data/repositories/feeding_repository.dart';
import '../../data/repositories/health_repository.dart';
import '../../data/repositories/reminder_repository.dart';
import '../../data/repositories/activity_repository.dart';
import '../services/remote_config_service.dart';
import '../services/app_open_ad_service.dart';
import '../services/pdf_report_service.dart';
import '../services/share_service.dart';
import '../utils/notification_service.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Services
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<RemoteConfigService>(() => RemoteConfigService());
  getIt.registerLazySingleton<AppOpenAdService>(
    () => AppOpenAdService(remoteConfigService: getIt<RemoteConfigService>()),
  );
  getIt.registerLazySingleton<PdfReportService>(() => PdfReportService());
  getIt.registerLazySingleton<ShareService>(() => ShareService());

  // Repositories
  getIt.registerLazySingleton<PetRepository>(
    () => PetRepository(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<FeedingRepository>(
    () => FeedingRepository(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<HealthRepository>(
    () => HealthRepository(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<ReminderRepository>(
    () => ReminderRepository(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<ActivityRepository>(
    () => ActivityRepository(getIt<DatabaseService>()),
  );
}
