import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/ui/app/screens/layout/main_layout.dart';
import 'package:desktop_nextmind/ui/app/screens/menu/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animação da logo
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(_controller);

    _controller.forward();

    _checkUser();
  }

  Future<void> _checkUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString("user");

    await Future.delayed(const Duration(seconds: 5)); // tempo da splash reduzido

    if (!mounted) return;

    if (raw != null) {
      try {
        final decoded = jsonDecode(raw);
        final data = decoded is Map && decoded.containsKey("data")
            ? decoded["data"]
            : decoded;

        final user = UserModel.fromJson(Map<String, dynamic>.from(data));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainLayout(child: HomeScreen(user: user)),
          ),
        );
        return;
      } catch (e) {
        debugPrint("Erro ao carregar usuário da Splash: $e");
      }
    }

    // Se não houver usuário → vai para login
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logotipo_nextmind.png', // logo
                  width: 300,
                  height: 300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
