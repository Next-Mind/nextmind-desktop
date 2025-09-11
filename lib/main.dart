// ignore_for_file: unused_local_variable

import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/util.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o gerenciador de janela (somente desktop)
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1000, 600),       // tamanho inicial da janela
    minimumSize: Size(860, 560), // tamanho mínimo permitido
    // maximumSize: Size(1600, 1200), // opcional: tamanho máximo
    center: true,                // abre centralizada
    backgroundColor: Colors.transparent,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(context, "Roboto", "Inter");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextMind Desktop',
      theme: AppTheme.light(textTheme),
      darkTheme: AppTheme.dark(textTheme),
      // themeMode: brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
