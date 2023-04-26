import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

abstract class PdfEvent {}

class OpenPdfEvent extends PdfEvent {
  OpenPdfEvent({required this.path});
  final String path;

  Future<OpenPdfEvent> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path!;
      return OpenPdfEvent(path: path);
    } else {
      throw Exception('No se seleccionó ningún archivo.');
    }
  }
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
