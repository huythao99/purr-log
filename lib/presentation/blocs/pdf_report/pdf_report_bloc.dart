import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/pdf_report_service.dart';
import '../../../core/services/share_service.dart';
import '../../../data/repositories/pet_repository.dart';
import '../../../data/repositories/feeding_repository.dart';
import '../../../data/repositories/health_repository.dart';
import 'pdf_report_event.dart';
import 'pdf_report_state.dart';

class PdfReportBloc extends Bloc<PdfReportEvent, PdfReportState> {
  final PdfReportService _pdfReportService;
  final ShareService _shareService;
  final PetRepository _petRepository;
  final FeedingRepository _feedingRepository;
  final HealthRepository _healthRepository;

  PdfReportBloc(
    this._pdfReportService,
    this._shareService,
    this._petRepository,
    this._feedingRepository,
    this._healthRepository,
  ) : super(const PdfReportInitial()) {
    on<PdfReportGenerate>(_onGenerate);
    on<PdfReportShare>(_onShare);
    on<PdfReportReset>(_onReset);
  }

  Future<void> _onGenerate(
    PdfReportGenerate event,
    Emitter<PdfReportState> emit,
  ) async {
    emit(const PdfReportGenerating());

    try {
      final pet = await _petRepository.getPetById(event.petId);
      if (pet == null) {
        emit(const PdfReportError(message: 'Pet not found'));
        return;
      }

      final weightRecords = await _healthRepository.getWeightRecordsForPet(event.petId);
      final healthRecords = await _healthRepository.getHealthRecordsForPet(event.petId);
      final feedingLogs = await _feedingRepository.getFeedingLogsForPet(event.petId);

      final filePath = await _pdfReportService.generateHealthReport(
        pet: pet,
        weightRecords: weightRecords,
        healthRecords: healthRecords,
        feedingLogs: feedingLogs,
      );

      emit(PdfReportGenerated(filePath: filePath));

      // Auto-share after generation
      await _shareService.shareFile(
        filePath,
        subject: '${pet.name} Health Report',
      );

      emit(const PdfReportShared());
    } catch (e) {
      emit(PdfReportError(message: e.toString()));
    }
  }

  Future<void> _onShare(
    PdfReportShare event,
    Emitter<PdfReportState> emit,
  ) async {
    try {
      await _shareService.shareFile(event.filePath);
      emit(const PdfReportShared());
    } catch (e) {
      emit(PdfReportError(message: e.toString()));
    }
  }

  void _onReset(PdfReportReset event, Emitter<PdfReportState> emit) {
    emit(const PdfReportInitial());
  }
}
