import 'package:desktop_nextmind/ui/app/widgets/setting_section.dart';
import 'package:desktop_nextmind/ui/app/widgets/setting_tile.dart';
import 'package:flutter/material.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingSection(
              title: "Notificações",
              children: [
                SettingTile(
                  icon: Icons.notifications_active_outlined,
                  title: "Notificações Push",
                  trailing: Switch(
                    value: true,
                    onChanged: (val) {
                      // habilitar/desabilitar push
                    },
                  ),
                ),
                SettingTile(
                  icon: Icons.email_outlined,
                  title: "Notificações por E-mail",
                  trailing: Switch(
                    value: false,
                    onChanged: (val) {
                      // habilitar/desabilitar email
                    },
                  ),
                ),
                SettingTile(
                  icon: Icons.sms_outlined,
                  title: "Notificações por SMS",
                  trailing: Switch(
                    value: false,
                    onChanged: (val) {
                      // habilitar/desabilitar sms
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
