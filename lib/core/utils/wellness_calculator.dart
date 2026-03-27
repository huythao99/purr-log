import '../../data/models/pet_model.dart';
import '../../data/models/weight_record_model.dart';
import '../../domain/entities/wellness_score.dart';
import '../constants/app_constants.dart';

class WellnessCalculator {
  WellnessCalculator._();

  static WellnessScore calculate({
    required Pet pet,
    required double todayKcal,
    required double recommendedKcal,
    required int todayActivityMinutes,
    required List<WeightRecord> recentWeightRecords,
  }) {
    final feedingResult = _calculateFeedingScore(todayKcal, recommendedKcal);
    final weightResult = _calculateWeightScore(pet, recentWeightRecords);
    final activityResult = _calculateActivityScore(pet.species, todayActivityMinutes);

    final totalScore = (feedingResult.score * 0.4 +
            weightResult.score * 0.3 +
            activityResult.score * 0.3)
        .round();

    return WellnessScore(
      petId: pet.id,
      totalScore: totalScore.clamp(0, 100),
      feedingScore: feedingResult.score,
      weightScore: weightResult.score,
      activityScore: activityResult.score,
      feedingNote: feedingResult.note,
      weightNote: weightResult.note,
      activityNote: activityResult.note,
    );
  }

  static _ScoreResult _calculateFeedingScore(double todayKcal, double recommendedKcal) {
    if (recommendedKcal <= 0) {
      return _ScoreResult(50, 'Set pet weight for accurate tracking');
    }

    final ratio = todayKcal / recommendedKcal;

    if (ratio >= 0.9 && ratio <= 1.1) {
      return _ScoreResult(100, 'Perfect calorie intake');
    } else if (ratio >= 0.8 && ratio <= 1.2) {
      return _ScoreResult(80, ratio < 1 ? 'Slightly under target' : 'Slightly over target');
    } else if (ratio >= 0.6 && ratio <= 1.4) {
      return _ScoreResult(60, ratio < 1 ? 'Below target' : 'Above target');
    } else if (ratio < 0.6) {
      return _ScoreResult(40, 'Needs more food today');
    } else {
      return _ScoreResult(40, 'Overfeeding detected');
    }
  }

  static _ScoreResult _calculateWeightScore(Pet pet, List<WeightRecord> records) {
    if (records.isEmpty) {
      return _ScoreResult(50, 'No weight records yet');
    }

    if (records.length < 2) {
      return _ScoreResult(70, 'Need more weight records');
    }

    // Get records from the last 30 days
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final recentRecords = records.where((r) => r.recordDate.isAfter(thirtyDaysAgo)).toList();

    if (recentRecords.length < 2) {
      return _ScoreResult(70, 'Need recent weight records');
    }

    final firstWeight = recentRecords.last.weight;
    final latestWeight = recentRecords.first.weight;
    final change = ((latestWeight - firstWeight) / firstWeight).abs();

    if (change <= 0.05) {
      return _ScoreResult(100, 'Weight stable');
    } else if (change <= 0.10) {
      return _ScoreResult(75, latestWeight > firstWeight ? 'Slight weight gain' : 'Slight weight loss');
    } else {
      return _ScoreResult(50, latestWeight > firstWeight ? 'Significant weight gain' : 'Significant weight loss');
    }
  }

  static _ScoreResult _calculateActivityScore(PetSpecies species, int todayMinutes) {
    final speciesKey = species.name;
    final recommendedMinutes = AppConstants.dailyActivityMinutes[speciesKey] ?? 15;

    if (recommendedMinutes == 0) {
      return _ScoreResult(100, 'No activity needed');
    }

    final ratio = todayMinutes / recommendedMinutes;

    if (ratio >= 1.0) {
      return _ScoreResult(100, 'Great activity level!');
    } else if (ratio >= 0.75) {
      return _ScoreResult(85, 'Good activity');
    } else if (ratio >= 0.5) {
      return _ScoreResult(65, 'Could use more activity');
    } else if (ratio >= 0.25) {
      return _ScoreResult(45, 'Low activity today');
    } else {
      return _ScoreResult(25, 'Needs more exercise');
    }
  }
}

class _ScoreResult {
  final int score;
  final String note;

  _ScoreResult(this.score, this.note);
}
