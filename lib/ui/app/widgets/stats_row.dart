import 'package:desktop_nextmind/ui/app/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class StatsRow extends StatelessWidget {
  final ThemeData theme;
  final String selectedUserType;
  final int totalBanidos;
  final int totalUsers;

  const StatsRow({
    super.key,
    required this.theme,
    required this.selectedUserType,
    required this.totalBanidos,
    required this.totalUsers,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StatCard(icon: Icons.category, title: "Tipo", value: selectedUserType, color: theme.colorScheme.primary),
        StatCard(icon: Icons.block, title: "Banidos", value: totalBanidos.toString(), color: theme.colorScheme.error),
        StatCard(icon: Icons.people, title: "Total", value: totalUsers.toString(), color: theme.colorScheme.primary),
      ],
    );
  }
}
