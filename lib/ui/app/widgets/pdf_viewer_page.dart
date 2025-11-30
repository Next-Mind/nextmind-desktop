import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../data/repositories/document_repository.dart';

class PdfViewerPage extends StatefulWidget {
  final String temporaryUrl;
  final String token;

  const PdfViewerPage({
    super.key,
    required this.temporaryUrl,
    required this.token,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late Future<Uint8List> _pdfFuture;

  @override
  void initState() {
    super.initState();
    _pdfFuture = DocumentRepository(token: widget.token)
        .fetchPdfBytes(widget.temporaryUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Visualizar Documento")),
      body: FutureBuilder<Uint8List>(
        future: _pdfFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao carregar PDF: ${snapshot.error}"),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text("Nenhum documento encontrado."));
          }

          return SfPdfViewer.memory(snapshot.data!);
        },
      ),
    );
  }
}
