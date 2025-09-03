import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Campo de email
                    TextField(
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
                    ),
                    const SizedBox(height: 20),

                    // Campo de senha
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Digite sua senha",
                        prefixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: const Color.fromARGB(108, 234, 232, 232),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
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
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 16, color: AppColors.onPrimaryLight),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Botão Criar Conta
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cadastro');
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
          ],
        ),
      ),
    );
  }
}
