import 'package:equatable/equatable.dart';

abstract class PdfReportEvent extends Equatable {
  const PdfReportEvent();

  @override
  List<Object?> get props => [];
}

class PdfReportGenerate extends PdfReportEvent {
  final int petId;

  const PdfReportGenerate({required this.petId});

  @override
  List<Object?> get props => [petId];
}

class PdfReportShare extends PdfReportEvent {
  final String filePath;

  const PdfReportShare({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class PdfReportReset extends PdfReportEvent {
  const PdfReportReset();
}
