import 'package:flutter/material.dart';

class PsychologistCard extends StatelessWidget {
  final String name;
  final String documentUrl;
  final int documentId;
  final bool read;
  final ValueChanged<bool> onReadChange;
  final VoidCallback? onTap; // ✅ Novo parâmetro para abrir docs

  const PsychologistCard({
    super.key,
    required this.name,
    required this.documentUrl,
    required this.documentId,
    required this.read,
    required this.onReadChange,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
        onTap: onTap,
      ),
    );
  }
}
