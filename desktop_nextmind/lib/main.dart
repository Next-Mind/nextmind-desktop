import 'package:desktop_nextmind/ui/login/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/util.dart';

void main() {
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
      title: 'Flutter Demo',
      theme: AppTheme.light(textTheme),
      darkTheme: AppTheme.dark(textTheme),
      themeMode: brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      home: LoginScreen(),
    );
  }
}
