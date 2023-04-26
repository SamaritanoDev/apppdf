import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

abstract class PdfEvent {}

class OpenPdfEvent extends PdfEvent {

  OpenPdfEvent({required this.path});
  final String path;

  static Future<OpenPdfEvent> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final file = File(result.files.single.path!);
      if (file.path.endsWith('.pdf')) {
        // El usuario seleccionó un archivo PDF
        return OpenPdfEvent(path: file.path);
      } else {
        // El usuario seleccionó un archivo que no es PDF
        throw Exception('El archivo seleccionado no es un PDF');
      }
    } else {
      // El usuario canceló la selección del archivo
      throw Exception('No se seleccionó ningún archivo');
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

class CancelPdfEvent extends PdfEvent {}
