import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfReportGenerator {
  static Future<void> exportUserReport({
    required BuildContext context,
    required List<Map<String, String>> users,
    required String userType,
  }) async {
    final pdf = pw.Document();
    final file = File('assets/images/header_pdf.png');
    if (!file.existsSync()) {
      throw Exception("Arquivo de header não encontrado!");
    }
    final headerImage = pw.MemoryImage(file.readAsBytesSync());

    pdf.addPage(
      pw.MultiPage(
        pageTheme: _buildPageTheme(),
        header: (context) => _buildHeader(headerImage),
        footer: (context) => _buildFooter(context),
        build: (pw.Context context) => [
          pw.SizedBox(height: 20),
          _buildTitle('RELATÓRIO DE USUÁRIOS - ${userType.toUpperCase()}'),
          pw.SizedBox(height: 24),
          _buildBody(users),
        ],
      ),
    );

    // Escolher local de salvamento
    String? path = await FilePicker.platform.saveFile(
      dialogTitle: 'Salvar PDF',
      fileName: 'relatorio_usuarios.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (path != null) {
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PDF exportado com sucesso!')),
      );
    }
  }

  static pw.Widget _buildHeader(pw.ImageProvider headerImage) {
    return pw.Container(
      height: 100,
      width: double.infinity,
      child: pw.FittedBox(
        fit: pw.BoxFit.cover,
        child: pw.Image(headerImage),
      ),
    );
  }

  static pw.Widget _buildTitle(String title) {
    return pw.Text(
      title,
      style: pw.TextStyle(
        color: PdfColor.fromInt(0xFF3EAF6C),
        fontSize: 18,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  static pw.Widget _buildBody(List<Map<String, String>> users) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
        borderRadius: pw.BorderRadius.circular(12),
      ),
      child: pw.Table.fromTextArray(
        headers: ["Nome", "Cargo", "Status"],
        headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
        headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.black,
        ),
        data: users
            .map((u) => [u["name"] ?? "", u["role"] ?? "", u["status"] ?? ""])
            .toList(),
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 16),
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColor.fromInt(0xFF3EAF6C)),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            "@nextmind.ctl",
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColor.fromInt(0xFF3EAF6C),
            ),
          ),
          pw.Text(
            "Página ${context.pageNumber} de ${context.pagesCount}",
            style: pw.TextStyle(
              fontSize: 10,
              color: PdfColor.fromInt(0xFF3EAF6C),
            ),
          ),
        ],
      ),
    );
  }

  static pw.PageTheme _buildPageTheme() {
    return pw.PageTheme(
      margin: const pw.EdgeInsets.all(32),
      theme: pw.ThemeData.withFont(
        base: pw.Font.helvetica(),
      ),
      buildBackground: (context) => pw.Container(
        color: PdfColors.white,
      ),
    );
  }
}
