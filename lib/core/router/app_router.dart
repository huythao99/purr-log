import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/pages/onboarding/onboarding_page.dart';
import '../../presentation/pages/dashboard/dashboard_page.dart';
import '../../presentation/pages/pet/pet_list_page.dart';
import '../../presentation/pages/pet/pet_detail_page.dart';
import '../../presentation/pages/pet/pet_form_page.dart';
import '../../presentation/pages/feeding/feeding_list_page.dart';
import '../../presentation/pages/feeding/feeding_form_page.dart';
import '../../presentation/pages/feeding/food_scanner_page.dart';
import '../../presentation/pages/feeding/pet_food_list_page.dart';
import '../../presentation/pages/feeding/pet_food_form_page.dart';
import '../../presentation/pages/health/health_list_page.dart';
import '../../presentation/pages/health/health_form_page.dart';
import '../../presentation/pages/reminder/reminder_list_page.dart';
import '../../presentation/pages/reminder/reminder_form_page.dart';
import 'app_routes.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter createRouter({required bool showOnboarding}) {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: showOnboarding ? AppRoutes.onboarding : AppRoutes.dashboard,
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingPage(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (context, state) => const DashboardPage(),
            ),
            GoRoute(
              path: AppRoutes.pets,
              builder: (context, state) => const PetListPage(),
            ),
            GoRoute(
              path: AppRoutes.reminders,
              builder: (context, state) => const ReminderListPage(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.petAdd,
          builder: (context, state) => const PetFormPage(),
        ),
        GoRoute(
          path: AppRoutes.petDetail,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['id']!);
            return PetDetailPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.petEdit,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['id']!);
            return PetFormPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.feedingList,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['petId']!);
            return FeedingListPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.feedingAdd,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['petId']!);
            return FeedingFormPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.foodScanner,
          builder: (context, state) {
            final petId = int.tryParse(state.uri.queryParameters['petId'] ?? '');
            return FoodScannerPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.petFoods,
          builder: (context, state) => const PetFoodListPage(),
        ),
        GoRoute(
          path: AppRoutes.petFoodAdd,
          builder: (context, state) => const PetFoodFormPage(),
        ),
        GoRoute(
          path: AppRoutes.petFoodEdit,
          builder: (context, state) {
            final foodId = int.parse(state.pathParameters['id']!);
            return PetFoodFormPage(foodId: foodId);
          },
        ),
        GoRoute(
          path: AppRoutes.healthList,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['petId']!);
            return HealthListPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.healthAdd,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['petId']!);
            return HealthFormPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.healthEdit,
          builder: (context, state) {
            final petId = int.parse(state.pathParameters['petId']!);
            final recordId = int.parse(state.pathParameters['id']!);
            return HealthFormPage(petId: petId, recordId: recordId);
          },
        ),
        GoRoute(
          path: AppRoutes.reminderAdd,
          builder: (context, state) {
            final petId = int.tryParse(state.uri.queryParameters['petId'] ?? '');
            return ReminderFormPage(petId: petId);
          },
        ),
        GoRoute(
          path: AppRoutes.reminderEdit,
          builder: (context, state) {
            final reminderId = int.parse(state.pathParameters['id']!);
            return ReminderFormPage(reminderId: reminderId);
          },
        ),
      ],
    );
  }
}

class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              context.go(AppRoutes.dashboard);
              break;
            case 1:
              context.go(AppRoutes.pets);
              break;
            case 2:
              context.go(AppRoutes.reminders);
              break;
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets_outlined),
            selectedIcon: Icon(Icons.pets),
            label: 'Pets',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Reminders',
          ),
        ],
      ),
    );
  }
}
