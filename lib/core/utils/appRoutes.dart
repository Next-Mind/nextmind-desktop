// ignore_for_file: file_names

import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/main.dart';
import 'package:desktop_nextmind/ui/app/screens/layout/settings_layout.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/user_account_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/settings/account_settings.dart';
import 'package:desktop_nextmind/ui/app/screens/settings/notification_settings.dart';
import 'package:desktop_nextmind/ui/app/screens/settings/privacy_settings.dart';
import 'package:desktop_nextmind/ui/app/screens/settings/system_settings.dart';
import 'package:desktop_nextmind/ui/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/dashboard_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/exportable_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/home_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/layout/main_layout.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/management_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/reported_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/support_screen.dart';
import 'package:desktop_nextmind/ui/auth/sign_in/login_screen.dart';
import 'package:desktop_nextmind/ui/auth/sign_up/cadastro_screens.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String cadastro = '/cadastro';
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String management = '/management';
  static const String reported = '/reported';
  static const String support = '/support';
  static const String reports = '/reports';
  static const String userAccount = '/userAccount';
  static const String settings = '/settings';
  static const String accountSettings = '/accountSettings';
  static const String notificationSettings = '/notificationSettings';
  static const String privacySettings = '/privacySettings';
  static const String systemSettings = '/systemSettings';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    cadastro: (context) => const CadastroScreen(),
    login: (context) => const LoginScreen(),

    // ====== ROTAS DO MENU ======
    home: (context) {
      return MainLayout(child: HomeScreen(user: ModalRoute.of(context)?.settings.arguments as UserModel?,));
    },
    dashboard: (context) => const MainLayout(child: DashboardScreen()),
    management: (context) => const MainLayout(child: ManagementScreen()),
    reported: (context) => const MainLayout(child: ReportedScreen()),
    support: (context) => const MainLayout(child: SupportScreen()),
    reports: (context) => const MainLayout(child: ExportableScreen()),

    userAccount: (context) {
      final user = ModalRoute.of(context)?.settings.arguments as UserModel?;
      return UserAccountScreen(user: user);
    },

    // ====== ROTAS DE CONFIGURAÇÃO ======
    accountSettings: (context) => SettingsLayout(child: AccountSettings()),

    notificationSettings: (context) =>
        const SettingsLayout(child: NotificationSettings()),

    privacySettings: (context) =>
        const SettingsLayout(child: PrivacySettings()),

    systemSettings: (context) {
      final appState = MyApp.of(context);
      return SettingsLayout(
        child: SystemSettings(
          toggleTheme: appState?.toggleTheme,
          isDarkMode: appState?.themeMode == ThemeMode.dark,
        ),
      );
    },
  };
}
