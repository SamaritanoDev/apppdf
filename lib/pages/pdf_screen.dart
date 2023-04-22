import 'package:apppdf/models/pdf_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatefulWidget {
  const PdfScreen({super.key, required this.pdfModel});
  final PdfModel pdfModel;

  @override
  // ignore: library_private_types_in_public_api
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfModel.name),
      ),
      body: SfPdfViewer.network(
        widget.pdfModel.path,
        controller: _pdfViewerController,
      ),
    );
  }
}
