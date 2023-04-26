import 'package:apppdf/models/pdf_model.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

abstract class PdfState {}

class InitialPdfState extends PdfState {}

class EmptyPdfState extends PdfState {}

class LoadingPdfState extends PdfState {}

class LoadedPdfState extends PdfState {
  LoadedPdfState(this.pdfDocument, {required this.pdf});
  final PdfModel pdf;
  final PdfDocument pdfDocument;
}

class SavedPdfState extends PdfState {}

class PdfErrorState extends PdfState {
  PdfErrorState({required this.errorMessage});

  final String errorMessage;
}

class CancelledPdfState extends PdfState {}

// class LoadedPdfState extends PdfState {
//   LoadedPdfState(this.pdfDocument, {required this.pdf});
//   final PdfModel pdf;
//   final PdfDocument pdfDocument;
// }
