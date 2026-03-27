import 'package:equatable/equatable.dart';

class WellnessScore extends Equatable {
  final int petId;
  final int totalScore;
  final int feedingScore;
  final int weightScore;
  final int activityScore;
  final String? feedingNote;
  final String? weightNote;
  final String? activityNote;

  const WellnessScore({
    required this.petId,
    required this.totalScore,
    required this.feedingScore,
    required this.weightScore,
    required this.activityScore,
    this.feedingNote,
    this.weightNote,
    this.activityNote,
  });

  WellnessLevel get level {
    if (totalScore >= 80) return WellnessLevel.excellent;
    if (totalScore >= 50) return WellnessLevel.good;
    return WellnessLevel.needsAttention;
  }

  @override
  List<Object?> get props => [
        petId,
        totalScore,
        feedingScore,
        weightScore,
        activityScore,
        feedingNote,
        weightNote,
        activityNote,
      ];
}

enum WellnessLevel {
  excellent,
  good,
  needsAttention,
}

extension WellnessLevelExtension on WellnessLevel {
  String get displayName {
    switch (this) {
      case WellnessLevel.excellent:
        return 'Excellent';
      case WellnessLevel.good:
        return 'Good';
      case WellnessLevel.needsAttention:
        return 'Needs Attention';
    }
  }
}
