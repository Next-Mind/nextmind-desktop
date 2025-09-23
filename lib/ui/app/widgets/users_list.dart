import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final ThemeData theme;
  final List<Map<String, String>> users;

  const UsersList({
    super.key,
    required this.theme,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: users.isEmpty
          ? Center(
              child: Text(
                "Nenhum usuário encontrado com os filtros selecionados.",
                style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.separated(
              itemCount: users.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user["name"]!),
                  subtitle: Text("${user["role"]} - ${user["status"]}"),
                );
              },
            ),
    );
  }
}
