import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/core/utils/user_storage.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_section.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final loadedUser = await UserStorage.loadUser();
    setState(() {
      user = loadedUser;
    });
  }

  Future<void> _logout(BuildContext context) async {
    await UserStorage.clearUser(); // limpa o usuário salvo
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token"); // se você salva o token separadamente
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SettingSection(
                    title: "Informações de Conta",
                    children: [
                      SettingTile(
                        icon: Icons.person,
                        title: "Nome",
                        subtitle: user!.name,
                      ),
                      SettingTile(
                        icon: Icons.email,
                        title: "Email",
                        subtitle: user!.email,
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
                        onTap: () => _logout(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
