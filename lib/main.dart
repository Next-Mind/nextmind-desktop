import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/ui/app/screens/settings/system_settings.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/util.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 600),
    minimumSize: Size(860, 560),
    center: true,
    backgroundColor: Colors.transparent,
    // fullScreen: true, Opção de fullscreen, ativar apenas para apresentações.
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.dark;

  void toggleTheme(bool isDark) {
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Roboto", "Inter");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextMind Desktop',
      theme: AppTheme.light(textTheme),
      darkTheme: AppTheme.dark(textTheme),
      themeMode: themeMode,
      initialRoute: AppRoutes.splash,
      routes: {
        ...AppRoutes.routes,
        AppRoutes.systemSettings: (context) =>
            SystemSettings(toggleTheme: toggleTheme),
      },
    );
  }
}
  
