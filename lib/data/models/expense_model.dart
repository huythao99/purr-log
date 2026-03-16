import 'package:isar/isar.dart';

part 'expense_model.g.dart';

@collection
class Expense {
  Id id = Isar.autoIncrement;

  @Index()
  late int petId;

  @enumerated
  late ExpenseCategory category;

  late double amount;

  String? description;

  String? vendor;

  String? receiptPath;

  @Index()
  late DateTime expenseDate;

  late DateTime createdAt;
}

enum ExpenseCategory {
  food,
  vet,
  medication,
  supplies,
  grooming,
  insurance,
  training,
  toys,
  accessories,
  other,
}

extension ExpenseCategoryExtension on ExpenseCategory {
  String get displayName {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.vet:
        return 'Veterinary';
      case ExpenseCategory.medication:
        return 'Medication';
      case ExpenseCategory.supplies:
        return 'Supplies';
      case ExpenseCategory.grooming:
        return 'Grooming';
      case ExpenseCategory.insurance:
        return 'Insurance';
      case ExpenseCategory.training:
        return 'Training';
      case ExpenseCategory.toys:
        return 'Toys';
      case ExpenseCategory.accessories:
        return 'Accessories';
      case ExpenseCategory.other:
        return 'Other';
    }
  }

  String get icon {
    switch (this) {
      case ExpenseCategory.food:
        return '🍖';
      case ExpenseCategory.vet:
        return '🏥';
      case ExpenseCategory.medication:
        return '💊';
      case ExpenseCategory.supplies:
        return '📦';
      case ExpenseCategory.grooming:
        return '✂️';
      case ExpenseCategory.insurance:
        return '📄';
      case ExpenseCategory.training:
        return '🎓';
      case ExpenseCategory.toys:
        return '🧸';
      case ExpenseCategory.accessories:
        return '🎀';
      case ExpenseCategory.other:
        return '💰';
    }
  }
}
