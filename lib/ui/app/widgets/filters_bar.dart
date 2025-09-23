import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FiltersBar extends StatelessWidget {
  final ThemeData theme;
  final String selectedUserType;
  final String selectedStatus;
  final ValueChanged<String> onUserTypeChanged;
  final ValueChanged<String> onStatusChanged;
  final VoidCallback? onExportPressed;

  const FiltersBar({
    super.key,
    required this.theme,
    required this.selectedUserType,
    required this.selectedStatus,
    required this.onUserTypeChanged,
    required this.onStatusChanged,
    required this.onExportPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        DropdownButton<String>(
          value: selectedUserType,
          items: ["Todos", "Admin", "Psicólogo", "Aluno"]
              .map((role) => DropdownMenuItem(value: role, child: Text(role)))
              .toList(),
          onChanged: (value) => onUserTypeChanged(value!),
          dropdownColor: theme.cardColor,
        ),
        DropdownButton<String>(
          value: selectedStatus,
          items: ["Todos", "Ativo", "Banido"]
              .map((status) => DropdownMenuItem(value: status, child: Text(status)))
              .toList(),
          onChanged: (value) => onStatusChanged(value!),
          dropdownColor: theme.cardColor,
        ),
        ElevatedButton.icon(
          onPressed: onExportPressed,
          icon: Icon(Icons.picture_as_pdf, color: Theme.of(context).colorScheme.primaryFixed,),
          label: Text("Exportar PDF", style: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
          ),
        ),
      ],
    );
  }
}
