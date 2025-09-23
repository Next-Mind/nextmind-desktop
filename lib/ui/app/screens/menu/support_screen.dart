import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/ui/app/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  String? selectedEmail;
  List<String> emails = [
    "Bug no botão de login",
    "Erro no dashboard",
    "Sugestão de melhoria",
    "Tela de loading trava às vezes",
    "Bug no botão de Cadastro",
    "Erro no Management",
  ];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Row(
          children: [
            /// COLUNA DA LISTA DE EMAILS
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: ListView.builder(
                itemCount: emails.length,
                itemBuilder: (context, index) {
                  final email = emails[index];
                  final bool isSelected = selectedEmail == email;

                  return Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.4)
                          : null,
                      border: isSelected
                          ? Border(
                              left: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                width: 4,
                              ),
                            )
                          : null,
                    ),
                    child: ListTile(
                      title: Text(
                        email,
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedEmail = email;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            /// CONTEÚDO DO CHAMADO + AÇÕES
            Expanded(
              child: Column(
                children: [
                  /// CARDS DE ESTATÍSTICAS RESPONSIVOS
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth / 3 - 16,
                            child: StatCard(
                                icon: Icons.check,
                                title: "Resolvidos",
                                value: "12",
                                color: Colors.green),
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 3 - 16,
                            child: StatCard(
                                icon: Icons.mark_email_read_outlined,
                                title: "Abertos",
                                value: "8",
                                color: Colors.blue),
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 3 - 16,
                            child: StatCard(
                                icon: Icons.pending_actions,
                                title: "Pendentes",
                                value: "3",
                                color: Colors.orange),
                          ),
                        ],
                      );
                    }),
                  ),

                  /// CONTEÚDO DO CHAMADO
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: selectedEmail == null
                          ? const Center(
                              child: Text(
                                "Selecione um chamado para visualizar o conteúdo",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          : SingleChildScrollView(
                              child: Text(
                                "Conteúdo do chamado:\n\n$selectedEmail\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas elementum magna eget odio aliquet, ac gravida erat egestas. Sed scelerisque, lacus vitae interdum dignissim, orci nibh venenatis dui, vitae egestas lorem lacus at sapien. Praesent risus ipsum, commodo vel tincidunt a, tempor in ligula. In at metus a odio accumsan convallis. Praesent id vulputate lorem. Nam consectetur viverra purus sed porttitor. Fusce luctus mauris venenatis volutpat molestie. Etiam efficitur faucibus elit, ac consequat odio. Mauris ac ante dapibus, facilisis risus euismod, hendrerit sem. Nunc et maximus velit, non consectetur justo.",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                    ),
                  ),

                  /// BOTÕES CENTRALIZADOS RESPONSIVOS
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: LayoutBuilder(builder: (context, constraints) {
                      double buttonWidth =
                          (constraints.maxWidth - 16) / 2; // divide espaço
                      return Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: buttonWidth > 250 ? 250 : buttonWidth,
                            child: ElevatedButton.icon(
                              onPressed: selectedEmail != null
                                  ? () {
                                      // lógica para marcar como concluído
                                    }
                                  : null,
                              icon: Icon(
                                Icons.check_circle,
                                color: Theme.of(context).colorScheme.primaryFixed,
                              ),
                              label: Text(
                                "Marcar como Concluído",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primaryFixed),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: buttonWidth > 250 ? 250 : buttonWidth,
                            child: ElevatedButton.icon(
                              onPressed: selectedEmail != null
                                  ? () {
                                      // lógica para marcar como pendente
                                    }
                                  : null,
                              icon: Icon(
                                Icons.pending_actions,
                                color: Theme.of(context).colorScheme.primaryFixed,
                              ),
                              label: Text(
                                "Marcar como Pendente",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primaryFixed),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondaryFixedDim,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
