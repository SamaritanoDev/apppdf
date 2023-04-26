import 'dart:io';
import 'package:apppdf/bloc/pdf_event.dart';
import 'package:apppdf/bloc/pdf_state.dart';
import 'package:apppdf/models/pdf_model.dart';
import 'package:apppdf/repositories/pdf_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfBloc extends Bloc<PdfEvent, PdfState> {
  PdfBloc({required this.repository}) : super(InitialPdfState()) {
    on<OpenPdfEvent>((event, emit) async {
      PdfDocument pdfDocument;
      emit(LoadingPdfState());
      try {
        final result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null) {
          final path = result.files.single.path!;
          final bytes = result.files.single.bytes!;
          final pdfModel = PdfModel(
            name: result.files.single.name,
            path: path,
            bytes: bytes,
          );
          pdfDocument = await repository.openPdf(path);
          emit(LoadedPdfState(pdfDocument, pdf: pdfModel));
        }
      } catch (e) {
        emit(PdfErrorState(errorMessage: e.toString()));
      }
    });
  }

  final PdfRepository repository;

  Stream<PdfState> mapEventToState(PdfEvent event) async* {
    PdfDocument pdfDocument;
    if (event is OpenPdfEvent) {
      yield LoadingPdfState();
      try {
        final bytes = await File(event.path).readAsBytes();
        final pdfModel = PdfModel(
          name: 'prueba.pdf',
          path: 'assets/documents/prueba.pdf',
          bytes: bytes,
        );
        pdfDocument = await repository.openPdf(event.path);
        yield LoadedPdfState(pdfDocument, pdf: pdfModel);
      } catch (e) {
        yield PdfErrorState(errorMessage: e.toString());
      }
    } else if (event is EditPdfEvent) {
      yield LoadingPdfState();
      try {
        final pdf = event.pdfDocument;
        final page = pdf.pages[0];
        final graphics = page.graphics;
        final brush = PdfSolidBrush(PdfColor(255, 0, 0));
        graphics.drawString(
          'Texto de prueba',
          PdfStandardFont(PdfFontFamily.helvetica, 30),
          brush: brush,
          bounds: Rect.fromLTWH(0, 0, page.size.width, page.size.height),
        );
        yield LoadedPdfState(pdf, pdf: null);
      } catch (e) {
        yield PdfErrorState(errorMessage: e.toString());
      }
    } else if (event is SavePdfEvent) {
      yield LoadingPdfState();
      try {
        final pdf = event.pdfDocument;
        await repository.savePdf(pdf);
        yield SavedPdfState();
      } catch (e) {
        yield PdfErrorState(errorMessage: e.toString());
      }
    } else if (event is CancelPdfEvent) {
      yield CancelledPdfState();
    }
  }
}
