import 'package:desktop_nextmind/ui/app/widgets/setting_section.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

class SystemSettings extends StatefulWidget {
  final Function(bool)? toggleTheme;
  final bool? isDarkMode;
  const SystemSettings({super.key, this.toggleTheme, this.isDarkMode});

  @override
  State<SystemSettings> createState() => _SystemSettingsState();
}

class _SystemSettingsState extends State<SystemSettings> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingSection(
              title: "Tema",
              children: [
                SettingTile(
                  icon: Icons.dark_mode,
                  title: "Modo Escuro",
                  subtitle: "Ativar/desativar tema escuro",
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (val) {
                      setState(() {
                        isDarkMode = val;
                      });
                      widget.toggleTheme?.call(val);
                    },
                  ),
                ),
              ],
            ),
            SettingSection(
              title: "Atualizações",
              children: [
                SettingTile(
                  icon: Icons.system_update_alt,
                  title: "Verificar Atualizações",
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // lógica de verificação de update
                  },
                ),
                SettingTile(
                  icon: Icons.info_outline,
                  title: "Versão do Sistema",
                  subtitle: "1.0.0",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
