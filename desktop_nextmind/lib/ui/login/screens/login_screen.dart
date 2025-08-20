import 'package:desktop_nextmind/ui/cadastro/screens/cadastro_screen.dart';
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
      backgroundColor: Colors.white,
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
                        fillColor: Colors.grey.shade200,
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
                        fillColor: Colors.grey.shade200,
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
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith<Color>(
                                (states) {
                                  if (states.contains(MaterialState.selected)) {
                                  return const Color(0xFF3CA668); // quando marcado
                                }
                                return Colors.white; 
                                },
                              ),
                            ),
                            const Text("Mantenha Conectado", style: TextStyle(color: Color(0xFF3CA668)),),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Esqueceu a senha?", style: TextStyle(color: Color(0xFF3CA668)),),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Botão Entrar
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(  
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3CA668),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Botão Criar Conta
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroScreen(),));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3CA668),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "CRIAR CONTA",    
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
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
