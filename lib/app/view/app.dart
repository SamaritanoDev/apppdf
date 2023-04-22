import 'package:apppdf/models/pdf_model.dart';
import 'package:apppdf/pages/home_page.dart';
import 'package:apppdf/pages/pdf_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Editor',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/pdf_screen': (context) => PdfScreen(
              pdfModel: PdfModel(name: '', path: '', bytes: []),
            ),
      },
    );
  }
}
