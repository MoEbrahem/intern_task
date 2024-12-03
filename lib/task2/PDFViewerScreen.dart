import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfpath;
  const PDFViewerScreen({super.key, required this.pdfpath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View PDF'),
      ),
      body: PDFView(
        
        filePath: pdfpath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          print(error.toString());
        },
      ),
    );
  }
}
