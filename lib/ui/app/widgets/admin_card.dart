import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AdminCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final bool reviewed;
  final VoidCallback onReview;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const AdminCard({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.reviewed,
    required this.onReview,
    required this.onApprove,
    required this.onReject,
  });

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Detalhes do Admin"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: $name"),
            Text("Email: $email"),
            Text("Cargo Solicitado: $role"),
            Text("Data de Cadastro: $createdAt"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onReview();
            },
            child: const Text("Marcar como Revisado"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color getTextColor(bool enabled) =>
        enabled ? Theme.of(context).colorScheme.primaryFixed : Theme.of(context).disabledColor;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            Text(email, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () => _showDetails(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  label: const Text("Ver Dados"),
                ),
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.check, color: getTextColor(reviewed)),
                      onPressed: reviewed ? onApprove : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryLight,
                      ),
                      label: Text("Aprovar", style: TextStyle(color: getTextColor(reviewed))),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.close, color: getTextColor(reviewed)),
                      onPressed: reviewed ? onReject : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      label: Text("Rejeitar", style: TextStyle(color: getTextColor(reviewed))),
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
