# Pet Log - Project Documentation

## Overview

Pet Log is an offline-first Flutter application for pet owners to track their pets' health, feeding, activities, and expenses. The app uses Isar database for local storage and works without an internet connection.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.11+ |
| Language | Dart 3.0+ |
| Database | Isar 3.1.0 |
| State Management | flutter_bloc 8.1.0 |
| Dependency Injection | get_it + injectable |
| Routing | go_router 14.0.0 |
| Barcode Scanner | mobile_scanner 5.0.0 |
| OCR | google_mlkit_text_recognition 0.11.0 |
| Local Notifications | flutter_local_notifications 17.0.0 |
| Image Picker | image_picker 1.0.0 |
| Charts | fl_chart 0.68.0 |

## Architecture

This project follows **Clean Architecture** with BLoC pattern:

```
lib/
├── core/                       # Core utilities and configurations
│   ├── constants/              # App constants, enums
│   ├── di/                     # Dependency injection setup
│   ├── errors/                 # Exceptions and failures
│   ├── router/                 # GoRouter configuration
│   ├── theme/                  # App theme, colors, text styles
│   └── utils/                  # Helper functions, extensions
│
├── data/                       # Data layer
│   ├── datasources/            # Local data sources (Isar)
│   ├── models/                 # Isar collection models
│   └── repositories/           # Repository implementations
│
├── domain/                     # Domain layer
│   ├── entities/               # Business entities
│   ├── repositories/           # Repository interfaces
│   └── usecases/               # Business logic use cases
│
└── presentation/               # Presentation layer
    ├── blocs/                  # BLoC state management
    │   ├── pet/
    │   ├── feeding/
    │   ├── food_scanner/
    │   ├── health/
    │   └── reminder/
    ├── pages/                  # Screen widgets
    └── widgets/                # Reusable UI components
```

## Features

### Phase 1 - MVP

| Feature | Description | Status |
|---------|-------------|--------|
| Pet Profile CRUD | Add/edit/delete pets with photo | Pending |
| Dashboard | Overview of all pets with quick stats | Pending |
| Feeding Log | Log daily meals with kcal tracking | Pending |
| Food Scanner | Scan barcode/nutrition label for kcal | Pending |
| Health Records | Vaccination, vet visits, medications | Pending |
| Reminders | Local notifications for tasks | Pending |

### Phase 2 - Enhanced

| Feature | Description | Status |
|---------|-------------|--------|
| Weight Tracking | Log weight with chart visualization | Pending |
| Activity Log | Walks, exercise, playtime tracking | Pending |
| Photo Gallery | Store pet photos locally | Pending |
| Grooming Records | Bath, haircut, nail trim logs | Pending |
| Search & Filter | Search logs by date, type, pet | Pending |

### Phase 3 - Advanced

| Feature | Description | Status |
|---------|-------------|--------|
| Expense Tracking | Track costs (food, vet, supplies) | Pending |
| Reports & Charts | Health trends, expense summaries | Pending |
| Data Export | Export to PDF/CSV | Pending |
| Backup/Restore | Export/import Isar DB file | Pending |
| Multi-language | i18n support | Pending |

## Database Schema (Isar Collections)

### Pet
```dart
@collection
class Pet {
  Id id = Isar.autoIncrement;
  String name;
  String species;          // dog, cat, bird, etc.
  String? breed;
  DateTime? dateOfBirth;
  double? weight;          // in kg
  String? photoPath;
  DateTime createdAt;
  DateTime updatedAt;
}
```

### PetFood
```dart
@collection
class PetFood {
  Id id = Isar.autoIncrement;
  String name;
  String? brand;
  String? barcode;
  double kcalPer100g;
  String? photoPath;
  DateTime createdAt;
}
```

### FeedingLog
```dart
@collection
class FeedingLog {
  Id id = Isar.autoIncrement;
  int petId;
  int? petFoodId;
  String? foodName;        // if manual entry
  double portionGrams;
  double totalKcal;
  DateTime feedingTime;
  String? notes;
  DateTime createdAt;
}
```

### HealthRecord
```dart
@collection
class HealthRecord {
  Id id = Isar.autoIncrement;
  int petId;
  String type;             // vaccination, vet_visit, medication, checkup
  String title;
  String? description;
  DateTime recordDate;
  DateTime? nextDueDate;
  String? documentPath;
  DateTime createdAt;
}
```

### Reminder
```dart
@collection
class Reminder {
  Id id = Isar.autoIncrement;
  int petId;
  String title;
  String? description;
  String type;             // feeding, medication, vet, grooming, other
  DateTime reminderTime;
  bool isRecurring;
  String? recurringPattern; // daily, weekly, monthly
  bool isActive;
  DateTime createdAt;
}
```

### Activity
```dart
@collection
class Activity {
  Id id = Isar.autoIncrement;
  int petId;
  String type;             // walk, play, training, grooming
  int durationMinutes;
  String? notes;
  DateTime activityDate;
  DateTime createdAt;
}
```

### Expense
```dart
@collection
class Expense {
  Id id = Isar.autoIncrement;
  int petId;
  String category;         // food, vet, supplies, grooming, other
  double amount;
  String? description;
  DateTime expenseDate;
  DateTime createdAt;
}
```

## Coding Conventions

### Naming
- **Files**: snake_case (e.g., `pet_bloc.dart`, `feeding_repository.dart`)
- **Classes**: PascalCase (e.g., `PetBloc`, `FeedingRepository`)
- **Variables/Functions**: camelCase (e.g., `petName`, `getFeedingLogs()`)
- **Constants**: camelCase or SCREAMING_SNAKE_CASE for global constants

### BLoC Pattern
- Events: Past tense verbs (e.g., `PetAdded`, `FeedingLogDeleted`)
- States: Noun + Status (e.g., `PetLoadInProgress`, `PetLoadSuccess`)
- Use `freezed` for immutable state classes

### File Organization
- One class per file
- Group related files in feature folders
- Keep widgets small and reusable

### Imports
- Use relative imports within the same feature
- Use package imports for cross-feature dependencies
- Order: dart, flutter, packages, local

## Commands

```bash
# Run the app
flutter run

# Generate Isar schemas
dart run build_runner build

# Watch for code generation
dart run build_runner watch

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .
```

## Environment Setup

1. Flutter SDK 3.11+
2. Dart SDK 3.0+
3. Android Studio / VS Code with Flutter extensions
4. For iOS: Xcode 15+, CocoaPods

## Dependencies to Add

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

  # Database
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  path_provider: ^2.1.0

  # State Management
  flutter_bloc: ^8.1.0
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.6.0
  injectable: ^2.3.0

  # Routing
  go_router: ^14.0.0

  # Scanner & OCR
  mobile_scanner: ^5.0.0
  google_mlkit_text_recognition: ^0.11.0

  # Notifications
  flutter_local_notifications: ^17.0.0
  timezone: ^0.9.0

  # UI & Utils
  image_picker: ^1.0.0
  fl_chart: ^0.68.0
  intl: ^0.19.0
  cached_network_image: ^3.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.0
  isar_generator: ^3.1.0
  injectable_generator: ^2.4.0
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
```

## Notes

- All data is stored locally using Isar database
- No internet connection required
- Photos are stored in app documents directory
- Reminders use local notifications
- Food scanner supports barcode and OCR for nutrition labels
