import 'dart:io';
import 'package:apppdf/bloc/pdf_event.dart';
import 'package:apppdf/bloc/pdf_state.dart';
import 'package:apppdf/models/pdf_model.dart';
import 'package:apppdf/repositories/pdf_repository.dart';
import 'package:bloc/bloc.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc({required this.repository}) : super(InitialPdfState());
  final PdfRepository repository;

  Stream<PdfState> mapEventToState(PdfEvent event) async* {
    if (event is OpenPdfEvent) {
      yield LoadingPdfState();
      try {
        final bytes = await File(event.path).readAsBytes();
        final pdfModel = PdfModel(
          name: 'prueba.pdf',
          path: 'assets/documents/prueba.pdf',
          bytes: bytes,
        );
        final pdfDocument = await repository.openPdf(event.path);
        yield LoadedPdfState(pdfDocument, pdf: pdfModel);
      } catch (e) {
        // Manejar el error
      }
    } else if (event is EditPdfEvent) {
      final pdfDocument = event.pdfDocument;
      // Implementar la edición del PDF
    } else if (event is SavePdfEvent) {
      yield LoadingPdfState();
      try {
        final pdfDocument = event.pdf;
        await repository.savePdf(pdfDocument);
        yield SavedPdfState();
      } catch (e) {
        // Manejar el error
      }
    }
  }
}
