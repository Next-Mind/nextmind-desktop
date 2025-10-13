import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PsychologistCard extends StatefulWidget {
  final String name;
  final String documentUrl;
  final bool read;
  final Future<void> Function()? onApprove;
  final Future<void> Function()? onReject;
  final ValueChanged<bool> onReadChange;

  const PsychologistCard({
    super.key,
    required this.name,
    required this.documentUrl,
    required this.read,
    required this.onApprove,
    required this.onReject,
    required this.onReadChange,
  });

  @override
  State<PsychologistCard> createState() => _PsychologistCardState();
}

class _PsychologistCardState extends State<PsychologistCard> {
  void _openPdf() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                Expanded(
                  child: SfPdfViewer.network(widget.documentUrl),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check_circle_outline),
                    onPressed: () {
                      Navigator.pop(context);
                      widget.onReadChange(true);
                    },
                    label: const Text("Marcar como Lido"),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  onPressed: widget.documentUrl.isNotEmpty ? _openPdf : null,
                  label: const Text("Ver Documento"),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.check,
                        color: (widget.read && widget.documentUrl.isNotEmpty)
                            ? Theme.of(context).colorScheme.primaryFixed
                            : Theme.of(context).disabledColor,
                      ),
                      onPressed: (widget.read && widget.documentUrl.isNotEmpty)
                          ? () async {
                              if (widget.onApprove != null)
                                await widget.onApprove!();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                      ),
                      label: Text(
                        "Aprovar",
                        style: TextStyle(
                          color: (widget.read && widget.documentUrl.isNotEmpty)
                              ? Theme.of(context).colorScheme.primaryFixed
                              : Theme.of(context).disabledColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                      onPressed: widget.onReject != null ? () async { await widget.onReject!(); } : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      label: Text(
                        "Rejeitar",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
