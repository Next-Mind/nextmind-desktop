import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:desktop_nextmind/core/utils/appRoutes.dart';

class SettingsLayout extends StatefulWidget {
  final Widget child;
  const SettingsLayout({super.key, required this.child});

  @override
  State<SettingsLayout> createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: Text("Configurações"),
        backgroundColor: AppColors.onErrorLight,
      ),
      body: Row(
        children: [
          // ==== Sidebar das Configurações ====
          Container(
            width: 220,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                // ==== Itens do menu lateral ====
                _SettingsMenuItem(
                  icon: Icons.person,
                  label: "Conta",
                  route: AppRoutes.accountSettings,
                  selected: currentRoute == AppRoutes.accountSettings,
                ),
                _SettingsMenuItem(
                  icon: Icons.settings,
                  label: "Sistema",
                  route: AppRoutes.systemSettings,
                  selected: currentRoute == AppRoutes.systemSettings,
                ),
                _SettingsMenuItem(
                  icon: Icons.notifications,
                  label: "Notificações",
                  route: AppRoutes.notificationSettings,
                  selected: currentRoute == AppRoutes.notificationSettings,
                ),
                _SettingsMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  label: "Privacidade",
                  route: AppRoutes.privacySettings,
                  selected: currentRoute == AppRoutes.privacySettings,
                ),

                const Spacer(),
              ],
            ),
          ),

          // ==== Conteúdo da Página ====
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

class _SettingsMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool selected;

  const _SettingsMenuItem({
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
              settings: RouteSettings(name: route),
              pageBuilder: (context, _, __) =>
                  AppRoutes.routes[route]!(context),
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
