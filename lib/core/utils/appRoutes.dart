import 'package:desktop_nextmind/ui/app/screens/dashboard_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/exportable_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/home_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/layout/main_layout.dart';
import 'package:desktop_nextmind/ui/app/screens/management_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/reported_screen.dart';
import 'package:desktop_nextmind/ui/app/screens/support_screen.dart';
import 'package:desktop_nextmind/ui/auth/sign_up/widgets/cadastro_screen.dart';
import 'package:desktop_nextmind/ui/auth/sign_in/widgets/login_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String cadastro = '/cadastro';
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String management = '/management';
  static const String reported = '/reported';
  static const String support = '/support';
  static const String reports = '/reports';

  static Map<String, WidgetBuilder> routes = {
    cadastro: (context) => const CadastroScreen(),
    login: (context) => const LoginScreen(),
    home: (context) => const MainLayout(child: HomeScreen()),
    dashboard: (context) => const MainLayout(child: DashboardScreen()),
    management: (context) => const MainLayout(child: ManagementScreen()),
    reported: (context) => const MainLayout(child: ReportedScreen()),
    support: (context) => const MainLayout(child: SupportScreen()),
    reports: (context) => const MainLayout(child: ExportableScreen()),
  };
}