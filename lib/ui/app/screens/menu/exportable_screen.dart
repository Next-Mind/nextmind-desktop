import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ExportableScreen extends StatefulWidget {
  const ExportableScreen({super.key});

  @override
  State<ExportableScreen> createState() => _ExportableScreenState();
}

class _ExportableScreenState extends State<ExportableScreen> {
  String selectedUserType = "Todos";
  String selectedStatus = "Todos";

  final List<Map<String, String>> allUsers = [
    {"name": "João Silva", "role": "Admin", "status": "Ativo"},
    {"name": "Maria Souza", "role": "Psicólogo", "status": "Ativo"},
    {"name": "Carlos Lima", "role": "Aluno", "status": "Inativo"},
    {"name": "Ana Paula", "role": "Admin", "status": "Banido"},
    {"name": "Pedro Santos", "role": "Psicólogo", "status": "Ativo"},
  ];

  List<Map<String, String>> get filteredUsers {
    return allUsers.where((user) {
      final roleMatch = selectedUserType == "Todos" || user["role"] == selectedUserType;
      final statusMatch = selectedStatus == "Todos" || user["status"] == selectedStatus;
      return roleMatch && statusMatch;
    }).toList();
  }

  int get totalBanidos =>
      filteredUsers.where((u) => u["status"] == "Banido").length;
  int get totalUsers => filteredUsers.length;

  void exportPDF() async {
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
          SnackBar(content: Text("PDF exportado com sucesso!")),
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
              // Filtros no topo
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  DropdownButton<String>(
                    value: selectedUserType,
                    items: ["Todos", "Admin", "Psicólogo", "Aluno"]
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUserType = value!;
                      });
                    },
                    dropdownColor: theme.cardColor,
                  ),
                  DropdownButton<String>(
                    value: selectedStatus,
                    items: ["Todos", "Ativo", "Inativo", "Banido"]
                        .map((status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value!;
                      });
                    },
                    dropdownColor: theme.cardColor,
                  ),
                  ElevatedButton.icon(
                    onPressed: filteredUsers.isNotEmpty ? exportPDF : null,
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("Exportar PDF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondaryFixedDim,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Cards resumo
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatCard(theme, "Tipo", selectedUserType, Icons.person),
                  _buildStatCard(theme, "Banidos", totalBanidos.toString(), Icons.block),
                  _buildStatCard(theme, "Total", totalUsers.toString(), Icons.list),
                ],
              ),
              const SizedBox(height: 20),

              // Lista de usuários filtrados
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: filteredUsers.isEmpty
                      ? Center(
                          child: Text(
                            "Nenhum usuário encontrado com os filtros selecionados.",
                            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        )
                      : ListView.separated(
                          itemCount: filteredUsers.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            return ListTile(
                              title: Text(user["name"]!),
                              subtitle: Text("${user["role"]} - ${user["status"]}"),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(ThemeData theme, String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: theme.colorScheme.primary),
            const SizedBox(height: 8),
            Text(value,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
