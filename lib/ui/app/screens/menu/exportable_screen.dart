import 'dart:io';
import 'package:desktop_nextmind/ui/app/widgets/filters_bar.dart';
import 'package:desktop_nextmind/ui/app/widgets/stat_card.dart';
import 'package:desktop_nextmind/ui/app/widgets/stats_row.dart';
import 'package:desktop_nextmind/ui/app/widgets/users_list.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportableScreen extends StatefulWidget {
  const ExportableScreen({super.key});

  @override
  State<ExportableScreen> createState() => _ExportableScreenState();
}

class _ExportableScreenState extends State<ExportableScreen> {
  String selectedUserType = "Todos";
  String selectedStatus = "Todos";

  // MOCK
  final List<Map<String, String>> allUsers = [
    {"name": "João Silva", "role": "Admin", "status": "Ativo"},
    {"name": "Maria Souza", "role": "Psicólogo", "status": "Ativo"},
    {"name": "Carlos Lima", "role": "Aluno", "status": "Banido"},
    {"name": "Ana Paula", "role": "Admin", "status": "Banido"},
    {"name": "Pedro Santos", "role": "Psicólogo", "status": "Ativo"},
  ];

  // FILTROS
  List<Map<String, String>> get filteredUsers {
    return allUsers.where((user) {
      final roleMatch = selectedUserType == "Todos" || user["role"] == selectedUserType;
      final statusMatch = selectedStatus == "Todos" || user["status"] == selectedStatus;
      return roleMatch && statusMatch;
    }).toList();
  }

  int get totalBanidos => filteredUsers.where((u) => u["status"] == "Banido").length;
  int get totalUsers => filteredUsers.length;

  // EXPORT PDF
  Future<void> exportPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Relatório de Usuários - $selectedUserType",
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),
              pw.Table.fromTextArray(
                headers: ["Nome", "Cargo", "Status"],
                data: filteredUsers.map((e) => [e["name"], e["role"], e["status"]]).toList(),
              ),
            ],
          );
        },
      ),
    );

    String? path = await FilePicker.platform.saveFile(
      dialogTitle: 'Salvar PDF',
      fileName: 'usuarios_filtrados.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (path != null) {
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("PDF exportado com sucesso!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              FiltersBar(
                theme: theme,
                selectedUserType: selectedUserType,
                selectedStatus: selectedStatus,
                onUserTypeChanged: (value) => setState(() => selectedUserType = value),
                onStatusChanged: (value) => setState(() => selectedStatus = value),
                onExportPressed: filteredUsers.isNotEmpty ? exportPDF : null,
              ),
              const SizedBox(height: 16),
              StatsRow(
                theme: theme,
                selectedUserType: selectedUserType,
                totalBanidos: totalBanidos,
                totalUsers: totalUsers,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: UsersList(theme: theme, users: filteredUsers),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
