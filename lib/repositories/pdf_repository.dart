import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfRepository {
  Future<PdfDocument> openPdf(String path) async {
    final file = File(path);
    final bytes = await file.readAsBytes();
    print(bytes);
    final document = PdfDocument(inputBytes: bytes);
    return document;
  }

  // Future<void> savePdf(PdfDocument pdfDocument) async {
  //   final bytes = pdfDocument.save();
  //   final file = File(pdfDocument.save() as String);
  //   await file.writeAsBytes(bytes as List<int>);
  // }
  Future<void> savePdf(PdfDocument pdfDocument) async {
    final bytes = pdfDocument.save();
    final downloadsDirectory = await getExternalStorageDirectory();
    final file = File('${downloadsDirectory!.path}/mi_pdf_guardado.pdf');
    await file.writeAsBytes(bytes as List<int>);
  }

  Future<void> editPdf(PdfDocument pdfDocument) async {
    // Implementar la edición del PDF
  }
}
