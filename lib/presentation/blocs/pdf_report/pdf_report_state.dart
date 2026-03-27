import 'package:equatable/equatable.dart';

abstract class PdfReportState extends Equatable {
  const PdfReportState();

  @override
  List<Object?> get props => [];
}

class PdfReportInitial extends PdfReportState {
  const PdfReportInitial();
}

class PdfReportGenerating extends PdfReportState {
  const PdfReportGenerating();
}

class PdfReportGenerated extends PdfReportState {
  final String filePath;

  const PdfReportGenerated({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class PdfReportShared extends PdfReportState {
  const PdfReportShared();
}

class PdfReportError extends PdfReportState {
  final String message;

  const PdfReportError({required this.message});

  @override
  List<Object?> get props => [message];
}
