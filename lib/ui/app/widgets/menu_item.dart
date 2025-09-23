import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool selected;
  final Object? arguments;

  const MenuItem({
    required this.icon,
    required this.label,
    required this.route,
    required this.selected,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!selected) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              settings: RouteSettings(
                name: route,
                arguments: arguments,
              ),
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
          color: selected ? Theme.of(context).colorScheme.tertiary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.scrim,),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: selected ? Theme.of(context).colorScheme.tertiaryContainer : Theme.of(context).colorScheme.scrim,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
