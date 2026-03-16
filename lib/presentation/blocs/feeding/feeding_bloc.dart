import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/feeding_repository.dart';
import 'feeding_event.dart';
import 'feeding_state.dart';

class FeedingBloc extends Bloc<FeedingEvent, FeedingState> {
  final FeedingRepository _feedingRepository;
  int? _currentPetId;

  FeedingBloc(this._feedingRepository) : super(const FeedingInitial()) {
    on<FeedingLoadLogs>(_onLoadLogs);
    on<FeedingAddLog>(_onAddLog);
    on<FeedingDeleteLog>(_onDeleteLog);
    on<FeedingLoadFoods>(_onLoadFoods);
  }

  Future<void> _onLoadLogs(FeedingLoadLogs event, Emitter<FeedingState> emit) async {
    emit(const FeedingLoading());
    _currentPetId = event.petId;
    try {
      final logs = await _feedingRepository.getFeedingLogsForPet(event.petId);
      final todayKcal = await _feedingRepository.getTotalKcalForDate(
        event.petId,
        DateTime.now(),
      );
      emit(FeedingLogsLoaded(logs: logs, todayTotalKcal: todayKcal));
    } catch (e) {
      emit(FeedingError(e.toString()));
    }
  }

  Future<void> _onAddLog(FeedingAddLog event, Emitter<FeedingState> emit) async {
    try {
      await _feedingRepository.addFeedingLog(event.log);
      emit(const FeedingOperationSuccess('Feeding log added'));
      if (_currentPetId != null) {
        add(FeedingLoadLogs(_currentPetId!));
      }
    } catch (e) {
      emit(FeedingError(e.toString()));
    }
  }

  Future<void> _onDeleteLog(FeedingDeleteLog event, Emitter<FeedingState> emit) async {
    try {
      await _feedingRepository.deleteFeedingLog(event.logId);
      emit(const FeedingOperationSuccess('Feeding log deleted'));
      if (_currentPetId != null) {
        add(FeedingLoadLogs(_currentPetId!));
      }
    } catch (e) {
      emit(FeedingError(e.toString()));
    }
  }

  Future<void> _onLoadFoods(FeedingLoadFoods event, Emitter<FeedingState> emit) async {
    emit(const FeedingLoading());
    try {
      final foods = await _feedingRepository.getAllPetFoods();
      emit(FeedingFoodsLoaded(foods));
    } catch (e) {
      emit(FeedingError(e.toString()));
    }
  }
}
