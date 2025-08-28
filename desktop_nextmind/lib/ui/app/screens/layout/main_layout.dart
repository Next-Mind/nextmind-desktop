import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

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
                // Cabeçalho
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(radius: 14, backgroundColor: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(child: Text("Nickname")),
                      Icon(Icons.arrow_drop_down),
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
              child: child,
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
          Navigator.pushReplacementNamed(context, route);
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
