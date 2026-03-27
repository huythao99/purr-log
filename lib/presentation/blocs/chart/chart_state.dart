import 'package:equatable/equatable.dart';

import '../../../domain/entities/chart_data.dart';

abstract class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object?> get props => [];
}

class ChartInitial extends ChartState {
  const ChartInitial();
}

class ChartLoading extends ChartState {
  const ChartLoading();
}

class ChartLoaded extends ChartState {
  final List<WeightChartData> weightData;
  final List<FeedingChartData> feedingData;

  const ChartLoaded({
    required this.weightData,
    required this.feedingData,
  });

  @override
  List<Object?> get props => [weightData, feedingData];
}

class ChartError extends ChartState {
  final String message;

  const ChartError(this.message);

  @override
  List<Object?> get props => [message];
}
