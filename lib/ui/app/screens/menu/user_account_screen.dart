import 'package:desktop_nextmind/ui/app/widgets/card_text.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/user_model.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:intl/intl.dart'; // Para formatar a data

class UserAccountScreen extends StatelessWidget {
  final UserModel? user;
  const UserAccountScreen({super.key, this.user});
  String formatCpf(String? cpf) {
    if (cpf == null || cpf.length != 11) return "Não informado";
    return "${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}";
  }

  String formatDate(dynamic date) {
    if (date == null) return "Não informado";
    if (date is DateTime) {
      return DateFormat('dd/MM/yyyy').format(date);
    }
    return date.toString();
  }

  String formatRoles(dynamic roles) {
    if (roles == null) return "Não informado";
    if (roles is List) {
      return roles.join(", ");
    }
    return roles.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        title: const Text(
          "Minha Conta",
        ),
        backgroundColor: AppColors.onErrorLight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox.expand(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage:
                          (user?.photoUrl != null && user!.photoUrl.isNotEmpty)
                              ? NetworkImage(user!.photoUrl)
                              : null,
                      child: (user?.photoUrl == null || user!.photoUrl.isEmpty)
                          ? const Icon(
                              Icons.person,
                              size: 90,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user?.name ?? 'Nome não encontrado',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      formatRoles(user?.roles),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          48,
                      // altura da tela menos appBar e padding do body
                    ),
                    child: IntrinsicHeight(
                      // faz a coluna ocupar a altura mínima necessária
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // centraliza verticalmente
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Informações Gerais",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            const SizedBox(height: 15),
                            CardText(
                                title: "Email",
                                info: user?.email ?? "Não informado"),
                            const SizedBox(height: 15),
                            CardText(title: "CPF", info: formatCpf(user?.cpf)),
                            const SizedBox(height: 15),
                            CardText(
                                title: "Data de Nascimento",
                                info: formatDate(user?.birthDate)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
