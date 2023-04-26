// ignore_for_file: library_private_types_in_public_api

import 'package:apppdf/bloc/pdf_bloc.dart';
import 'package:apppdf/bloc/pdf_event.dart';
import 'package:apppdf/bloc/pdf_state.dart';
import 'package:apppdf/models/pdf_model.dart';
import 'package:apppdf/pages/pdf_screen.dart';
import 'package:apppdf/repositories/pdf_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PdfBloc _pdfBloc;

  @override
  void initState() {
    super.initState();
    _pdfBloc = PdfBloc(repository: PdfRepository());
  }

  @override
  void dispose() {
    _pdfBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Editor'),
      ),
      body: BlocBuilder<PdfBloc, PdfState>(
        bloc: _pdfBloc,
        builder: (context, state) {
          if (state is InitialPdfState) {
            return _buildInitial();
          } else if (state is LoadingPdfState) {
            return _buildLoading();
          } else if (state is LoadedPdfState) {
            return _buildLoaded(state.pdf);
          } else if (state is SavedPdfState) {
            return _buildSaved();
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFileChooser,
        tooltip: 'Open PDF',
        child: const Icon(Icons.file_download),
      ),
      // ElevatedButton(
      //   onPressed: () async {
      //     final event = await OpenPdfEvent().selectFile();
      //     context.read<PdfBloc>().add(event);
      //   },
      //   child: Text('Seleccionar archivo'),
      // ),
    );
  }

  Widget _buildInitial() {
    return const Center(
      child: Text('Open a PDF to start editing'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoaded(PdfModel pdf) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<PdfScreen>(
            builder: (_) => PdfScreen(pdfModel: pdf),
          ),
        );

      },
      child: SfPdfViewer.network(
        pdf.path,
        enableDocumentLinkAnnotation: false,
        canShowScrollHead: false,
      ),
    );
  }

  Widget _buildSaved() {
    return const Center(
      child: Text('PDF Saved'),
    );
  }

  Future<void> _showFileChooser() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      final path = result.files.single.path!;
      _pdfBloc.add(OpenPdfEvent(path: path));
    }
  }
}
