import 'package:desktop_nextmind/ui/app/widgets/setting_section.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

class PrivacySettings extends StatelessWidget {
  const PrivacySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingSection(
              title: "Privacidade da Conta",
              children: [
                SettingTile(
                  icon: Icons.visibility_outlined,
                  title: "Mostrar status online",
                  trailing: Switch(
                    value: true,
                    onChanged: (val) {
                      // alterar status online
                    },
                  ),
                ),
                SettingTile(
                  icon: Icons.lock_outline,
                  title: "Conta Privada",
                  trailing: Switch(
                    value: false,
                    onChanged: (val) {
                      // conta privada/pública
                    },
                  ),
                ),
              ],
            ),
            SettingSection(
              title: "Dados e Permissões",
              children: [
                SettingTile(
                  icon: Icons.security,
                  title: "Gerenciar Permissões",
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // abrir página de permissões
                  },
                ),
                SettingTile(
                  icon: Icons.delete_forever,
                  title: "Excluir Conta",
                  subtitle: "Esta ação não pode ser desfeita",
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  onTap: () {
                    // confirmar exclusão de conta
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
