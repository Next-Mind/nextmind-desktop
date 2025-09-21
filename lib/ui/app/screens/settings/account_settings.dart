import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_section.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends StatelessWidget {
  final UserModel? user;
  const AccountSettings({super.key, this.user});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("token");
    await prefs.remove("user");

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login, 
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingSection(
              title: "Informações de Conta",
              children: [
                SettingTile(
                  icon: Icons.person,
                  title: "Nome",
                  subtitle: user?.name ?? 'Nome não encontrado',
                ),
                SettingTile(
                  icon: Icons.email,
                  title: "Email",
                  subtitle: user?.email ?? "Não Informado",
                ),
              ],
            ),
            SettingSection(
              title: "Segurança",
              children: [
                SettingTile(
                  icon: Icons.lock,
                  title: "Alterar Senha",
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // navegar para tela de alterar senha
                  },
                ),
                SettingTile(
                  icon: Icons.logout,
                  title: "Sair da Conta",
                  trailing: const Icon(Icons.exit_to_app),
                  onTap: () {
                    _logout(context);
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
