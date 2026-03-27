import 'package:equatable/equatable.dart';

class WeightChartData extends Equatable {
  final DateTime date;
  final double weight;

  const WeightChartData({
    required this.date,
    required this.weight,
  });

  @override
  List<Object?> get props => [date, weight];
}

class FeedingChartData extends Equatable {
  final DateTime date;
  final double totalKcal;
  final double recommendedKcal;

  const FeedingChartData({
    required this.date,
    required this.totalKcal,
    required this.recommendedKcal,
  });

  double get percentage =>
      recommendedKcal > 0 ? (totalKcal / recommendedKcal * 100) : 0;

  @override
  List<Object?> get props => [date, totalKcal, recommendedKcal];
}
