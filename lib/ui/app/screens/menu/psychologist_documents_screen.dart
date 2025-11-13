import 'dart:convert';
import 'package:desktop_nextmind/ui/app/widgets/pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:desktop_nextmind/data/models/document_model.dart';
import 'package:http/http.dart' as http;

class PsychologistDocumentsScreen extends StatefulWidget {
  final List<DocumentModel> documents;
  final String token;

  const PsychologistDocumentsScreen({
    super.key,
    required this.documents,
    required this.token,
  });

  @override
  State<PsychologistDocumentsScreen> createState() =>
      _PsychologistDocumentsScreenState();
}

class _PsychologistDocumentsScreenState
    extends State<PsychologistDocumentsScreen> {
  final Map<String, bool> _readDocs = {};

  String _getTypeName(String type) {
    switch (type) {
      case 'crp_card':
        return 'Carteira do CRP';
      case 'id_front':
        return 'Documento (Frente)';
      case 'id_back':
        return 'Documento (Verso)';
      case 'proof_of_address':
        return 'Comprovante de Endereço';
      default:
        return type;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'crp_card':
        return Icons.badge;
      case 'id_front':
        return Icons.credit_card;
      case 'id_back':
        return Icons.credit_card_outlined;
      case 'proof_of_address':
        return Icons.home;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> _approveDocument(String id) async {
    final url = Uri.parse(
        'https://api.nextmind.sbs/admin/psychologists/documents/$id/approve');
    final response = await http.patch(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Documento aprovado com sucesso")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao aprovar documento: ${response.body}")),
      );
    }
  }

  Future<void> _rejectDocument(String id) async {
    final controller = TextEditingController();
    final reason = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Motivo da Reprovação"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: "Descreva o motivo",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text),
            child: const Text("Enviar"),
          ),
        ],
      ),
    );

    if (reason == null || reason.isEmpty) return;

    final url = Uri.parse(
        'https://api.nextmind.sbs/admin/psychologists/documents/$id/repprove');
    final response = await http.patch(
      url,
      headers: {
        'Authorization': 'Bearer ${widget.token}',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'rejection_reason': reason}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Documento reprovado com sucesso")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao reprovar: ${response.body}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentos do Psicólogo")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.documents.length,
        itemBuilder: (context, index) {
          final doc = widget.documents[index];
          final isRead = _readDocs[doc.id] ?? false;

          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _getTypeIcon(doc.type),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getTypeName(doc.type),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Status: ${doc.status}",
                              style: TextStyle(
                                color: doc.status == 'pending'
                                    ? Colors.orange
                                    : doc.status == 'approved'
                                        ? Colors.green
                                        : Colors.red,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PdfViewerPage(
                                          temporaryUrl: doc.temporaryUrl,
                                          token: widget.token,
                                        ),
                                      ),
                                    );
                                    setState(() => _readDocs[doc.id] = true);
                                  },
                                  child: Text("Visualizar PDF")),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed:
                                isRead ? () => _approveDocument(doc.id) : null,
                            icon: const Icon(Icons.check, color: Colors.white,),
                            label: const Text("Aprovar", style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: () => _rejectDocument(doc.id),
                            icon: const Icon(Icons.close, color: Colors.white,),
                            label: const Text("Reprovar", style: TextStyle(color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
