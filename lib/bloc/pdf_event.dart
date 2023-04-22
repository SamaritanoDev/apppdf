import 'package:syncfusion_flutter_pdf/pdf.dart';

abstract class PdfEvent {}

class OpenPdfEvent extends PdfEvent {
  OpenPdfEvent({required this.path});
  final String path;
}

class EditPdfEvent extends PdfEvent {
  EditPdfEvent(this.pdfDocument);
  final PdfDocument pdfDocument;
}

class SavePdfEvent extends PdfEvent {
  SavePdfEvent(this.pdfDocument);
  final PdfDocument pdfDocument;

  PdfDocument get pdf => pdfDocument;
}
