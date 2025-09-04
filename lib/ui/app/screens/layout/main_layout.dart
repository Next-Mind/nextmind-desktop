// ignore_for_file: unnecessary_string_interpolations

import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String? userName;
  String? photoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString("user");

  if (userString != null) {
    try {
      final user = jsonDecode(userString);

      setState(() {
        userName = user["name"];
        photoUrl = user["photo_url"];
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
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              children: [
                // Cabeçalho usuário
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.grey.shade300,
                        child: ClipOval(
                          child: photoUrl != null
                              ? Image.network(
                                  photoUrl!,
                                  fit: BoxFit.cover,
                                  width: 28,
                                  height: 28,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.person, size: 16, color: Colors.white);
                                  },
                                )
                              : const Icon(Icons.person, size: 16, color: Colors.white),
                        ),
                      ),

                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          userName ?? "Usuário",
                          style: const TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis, // evita quebrar layout
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),

                // Itens do menu
                _MenuItem(
                  icon: Icons.home_outlined,
                  label: "Home",
                  route: AppRoutes.home,
                  selected: currentRoute == AppRoutes.home,
                ),
                _MenuItem(
                  icon: Icons.dashboard_outlined,
                  label: "Dashboard",
                  route: AppRoutes.dashboard,
                  selected: currentRoute == AppRoutes.dashboard,
                ),
                _MenuItem(
                  icon: Icons.work_outline,
                  label: "Management",
                  route: AppRoutes.management,
                  selected: currentRoute == AppRoutes.management,
                ),
                _MenuItem(
                  icon: Icons.flag_outlined,
                  label: "Reported",
                  route: AppRoutes.reported,
                  selected: currentRoute == AppRoutes.reported,
                ),
                _MenuItem(
                  icon: Icons.support_agent_outlined,
                  label: "Support",
                  route: AppRoutes.support,
                  selected: currentRoute == AppRoutes.support,
                ),
                _MenuItem(
                  icon: Icons.file_download_outlined,
                  label: "Reports",
                  route: AppRoutes.reports,
                  selected: currentRoute == AppRoutes.reports,
                ),

                const Spacer(),

                // Settings
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: const [
                      Icon(Icons.settings, color: Colors.black87),
                      SizedBox(width: 8),
                      Text("Settings"),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Conteúdo principal
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool selected;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!selected) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              settings: RouteSettings(name: route), // mantém o nome da rota
              pageBuilder: (context, _, __) => AppRoutes.routes[route]!(context),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: selected ? Colors.teal.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.teal : Colors.black87),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.teal : Colors.black87,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
