class AppRoutes {
  AppRoutes._();

  // Onboarding
  static const String onboarding = '/onboarding';

  // Main tabs
  static const String dashboard = '/';
  static const String pets = '/pets';
  static const String reminders = '/reminders';

  // Pet routes
  static const String petDetail = '/pets/:id';
  static const String petAdd = '/pets/add';
  static const String petEdit = '/pets/:id/edit';
  static const String petCharts = '/pets/:id/charts';

  // Feeding routes
  static const String feedingList = '/pets/:petId/feeding';
  static const String feedingAdd = '/pets/:petId/feeding/add';
  static const String foodScanner = '/food-scanner';
  static const String petFoods = '/pet-foods';
  static const String petFoodAdd = '/pet-foods/add';
  static const String petFoodEdit = '/pet-foods/:id/edit';

  // Health routes
  static const String healthList = '/pets/:petId/health';
  static const String healthAdd = '/pets/:petId/health/add';
  static const String healthEdit = '/pets/:petId/health/:id/edit';

  // Reminder routes
  static const String reminderAdd = '/reminder/add';
  static const String reminderEdit = '/reminder/:id/edit';

  // Helper methods
  static String petDetailPath(int id) => '/pets/$id';
  static String petEditPath(int id) => '/pets/$id/edit';
  static String petChartsPath(int id) => '/pets/$id/charts';
  static String feedingListPath(int petId) => '/pets/$petId/feeding';
  static String feedingAddPath(int petId) => '/pets/$petId/feeding/add';
  static String foodScannerPath(int? petId) =>
      petId != null ? '/food-scanner?petId=$petId' : '/food-scanner';
  static String petFoodEditPath(int id) => '/pet-foods/$id/edit';
  static String healthListPath(int petId) => '/pets/$petId/health';
  static String healthAddPath(int petId) => '/pets/$petId/health/add';
  static String healthEditPath(int petId, int id) =>
      '/pets/$petId/health/$id/edit';
  static String reminderAddPath(int? petId) =>
      petId != null ? '/reminder/add?petId=$petId' : '/reminder/add';
  static String reminderEditPath(int id) => '/reminder/$id/edit';
}
