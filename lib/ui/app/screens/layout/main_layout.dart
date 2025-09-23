// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';
import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/home_screen.dart';
import 'package:desktop_nextmind/ui/app/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString("user");
    if (raw != null) {
      try {
        final decoded = jsonDecode(raw);
        final data = decoded is Map && decoded.containsKey("data")
            ? decoded["data"]
            : decoded;
        setState(() {
          user = UserModel.fromJson(Map<String, dynamic>.from(data));
        });
      } catch (e) {
        debugPrint("Erro ao decodificar usuário: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Row(
        children: [
          // ==== Sidebar ====
          Container(
            width: 220,
            color: Theme.of(context).colorScheme.onPrimary,
            child: Column(
              children: [
                // Cabeçalho com foto e nome
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.userAccount,
                        arguments: user,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey.shade300,
                            child: ClipOval(
                              child: Image.network(
                                user?.photoUrl ??
                                    "https://via.placeholder.com/150",
                                fit: BoxFit.cover,
                                width: 32,
                                height: 32,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 18,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              user?.name ?? "Usuário",
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),

                // ==== Itens de menu ====
                MenuItem(
                  icon: Icons.home_outlined,
                  label: "Home",
                  route: AppRoutes.home,
                  selected: currentRoute == AppRoutes.home,
                  arguments: user,
                ),
                MenuItem(
                  icon: Icons.dashboard_outlined,
                  label: "Dashboard",
                  route: AppRoutes.dashboard,
                  selected: currentRoute == AppRoutes.dashboard,
                ),
                MenuItem(
                  icon: Icons.work_outline,
                  label: "Management",
                  route: AppRoutes.management,
                  selected: currentRoute == AppRoutes.management,
                ),
                MenuItem(
                  icon: Icons.flag_outlined,
                  label: "Reported",
                  route: AppRoutes.reported,
                  selected: currentRoute == AppRoutes.reported,
                ),
                MenuItem(
                  icon: Icons.support_agent_outlined,
                  label: "Support",
                  route: AppRoutes.support,
                  selected: currentRoute == AppRoutes.support,
                ),
                MenuItem(
                  icon: Icons.file_download_outlined,
                  label: "Reports",
                  route: AppRoutes.reports,
                  selected: currentRoute == AppRoutes.reports,
                ),

                const Spacer(),

                // ==== Settings ====
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.accountSettings,
                      arguments: user,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Icon(Icons.settings,
                              color: Theme.of(context).colorScheme.scrim),
                          const SizedBox(width: 8),
                          const Text("Settings"),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          // ==== Conteúdo principal ====
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Builder(
                builder: (context) {
                  if (widget.child is HomeScreen) {
                    return HomeScreen(user: user);
                  }
                  return widget.child;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
