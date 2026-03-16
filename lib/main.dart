import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/services/app_open_ad_service.dart';
import 'core/services/remote_config_service.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/notification_service.dart';
import 'data/datasources/database_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Mobile Ads SDK
  await MobileAds.instance.initialize();

  // Initialize dependency injection
  await configureDependencies();

  // Initialize Remote Config
  await getIt<RemoteConfigService>().initialize();

  // Initialize App Open Ads
  await getIt<AppOpenAdService>().initialize();

  // Initialize database
  final dbService = getIt<DatabaseService>();
  await dbService.initialize();

  // Check if onboarding is completed
  final showOnboarding = !(await dbService.isOnboardingCompleted());

  // Initialize notifications (only request permissions after onboarding)
  await getIt<NotificationService>().initialize();

  runApp(PetLogApp(showOnboarding: showOnboarding));
}

class PetLogApp extends StatelessWidget {
  final bool showOnboarding;
  late final GoRouter _router;

  PetLogApp({super.key, required this.showOnboarding}) {
    _router = AppRouter.createRouter(showOnboarding: showOnboarding);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pet Log',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
