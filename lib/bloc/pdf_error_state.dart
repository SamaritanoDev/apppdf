import 'package:apppdf/bloc/pdf_state.dart';

class PdfErrorState extends PdfState {
  PdfErrorState({required this.errorMessage});

  final String errorMessage;
}
