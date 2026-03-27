import 'package:equatable/equatable.dart';

abstract class ChartEvent extends Equatable {
  const ChartEvent();

  @override
  List<Object?> get props => [];
}

class ChartLoadWeight extends ChartEvent {
  final int petId;
  final int days;

  const ChartLoadWeight({required this.petId, this.days = 30});

  @override
  List<Object?> get props => [petId, days];
}

class ChartLoadFeeding extends ChartEvent {
  final int petId;
  final int days;

  const ChartLoadFeeding({required this.petId, this.days = 7});

  @override
  List<Object?> get props => [petId, days];
}

class ChartLoadAll extends ChartEvent {
  final int petId;

  const ChartLoadAll({required this.petId});

  @override
  List<Object?> get props => [petId];
}
