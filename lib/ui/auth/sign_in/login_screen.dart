// ignore_for_file: use_build_context_synchronously, avoid_print, deprecated_member_use

import 'dart:convert';

import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/ui/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true; 

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);

      try {
        final response = await AuthService.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        print("Resposta da API: $response");

        if (response.containsKey("token")) {
          final token = response["token"];
          final user = UserModel.fromJson(response["data"]); // usa o modelo

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", token);
          await prefs.setString("user", jsonEncode(user.toJson()));

          print("Usuário logado: ${user.name}, token: $token");
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Falha no login")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ocorreu um erro ao fazer login")),
        );
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo e nome
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logotipo_nextmind.png",
                    height: 500,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Formulário
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Campo de email
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "email@example.com",
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: const Color.fromARGB(108, 234, 232, 232),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) => value != null && value.contains("@") ? null : "Digite um email válido",
                    ),
                    const SizedBox(height: 20),

                    // Campo de senha
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Digite sua senha",
                        prefixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: const Color.fromARGB(108, 234, 232, 232),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          }, 
                        )
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite sua senha!";
                        }
                        if (value.length < 8) {
                          return "A senha deve ser maior que 8 caracteres!";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),

                    // Manter conectado e esqueceu senha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked, 
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                              checkColor: AppColors.onPrimaryLight,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (states) {
                                  if (states.contains(MaterialState.selected)) {
                                  return AppColors.primaryLight; // quando marcado
                                }
                                return AppColors.onPrimaryLight; 
                                },
                              ),
                            ),
                            const Text("Mantenha Conectado", style: TextStyle(color: AppColors.primaryLight),),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Esqueceu a senha?", style: TextStyle(color: AppColors.primaryLight),),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Botão Entrar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(  
                        onPressed: () {
                          _loading ? null : _login();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: _loading ? const CircularProgressIndicator(color: Colors.white) : Text("ENTRAR", style: TextStyle(fontSize: 16, color: AppColors.onPrimaryLight),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Botão Criar Conta
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/cadastro');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "CRIAR CONTA",    
                          style: TextStyle(fontSize: 16,color: AppColors.onPrimaryLight),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}