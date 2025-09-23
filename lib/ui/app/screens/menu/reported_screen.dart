import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/ui/app/widgets/stat_card.dart';
import 'package:flutter/material.dart';

class ReportedScreen extends StatefulWidget {
  const ReportedScreen({super.key});

  @override
  State<ReportedScreen> createState() => _ReportedScreenState();
}

class _ReportedScreenState extends State<ReportedScreen> {
  String? selectedUser;
  bool showBanned = false;

  List<Map<String, String>> users = [
    {"name": "João Silva", "status": "reportado", "lastReport": "2025-09-18"},
    {"name": "Maria Souza", "status": "banido", "lastReport": "2025-09-17"},
    {"name": "Carlos Lima", "status": "reportado", "lastReport": "2025-09-16"},
    {"name": "Ana Paula", "status": "reportado", "lastReport": "2025-09-15"},
    {"name": "Pedro Santos", "status": "banido", "lastReport": "2025-09-14"},
  ];

  List<Map<String, String>> get filteredUsers => users
      .where((u) =>
          showBanned ? u["status"] == "banido" : u["status"] == "reportado")
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Row(
          children: [
            /// COLUNA DE USUÁRIOS BANIDOS/REPORTADOS
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  /// Toggle Banned / Reported
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ToggleButtons(
                      isSelected: [!showBanned, showBanned],
                      onPressed: (index) {
                        setState(() {
                          showBanned = index == 1;
                          selectedUser = null;
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      selectedColor: Theme.of(context).colorScheme.primaryFixed,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.2),
                      children: const [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Reportados"),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Banidos"),
                        ),
                      ],
                    ),
                  ),

                  /// Lista de usuários
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final isSelected = selectedUser == user["name"];
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
                              user["name"]!,
                              style: TextStyle(
                                color: isSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.color,
                              ),
                            ),
                            subtitle:
                                Text("Último report: ${user["lastReport"]}"),
                            onTap: () {
                              setState(() {
                                selectedUser = user["name"];
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// DETALHES DO USUÁRIO
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
                              icon: Icons.report,
                              title: "Reports",
                              value: selectedUser != null ? "5" : "0",
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth / 3 - 16,
                            child: StatCard(
                              icon: Icons.block,
                              title: "Status",
                              value: selectedUser != null
                                  ? (showBanned ? "Banido" : "Ativo")
                                  : "-",
                              color: showBanned ? Colors.grey : Colors.green,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),

                  /// CONTEÚDO DO REPORT
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        width: double.infinity,
                        child: selectedUser == null
                            ? const Center(
                                child: Text(
                                  "Selecione um usuário para visualizar o conteúdo",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(3, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Text(
                                        "Report ${index + 1}: Motivo do report do usuário. "
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                                        "Maecenas elementum magna eget odio aliquet, ac gravida erat egestas. "
                                        "Sed scelerisque, lacus vitae interdum dignissim, orci nibh venenatis dui, "
                                        "vitae egestas lorem lacus at sapien.",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                      ),
                    ),
                  ),

                  /// BOTÕES DE AÇÃO
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: LayoutBuilder(builder: (context, constraints) {
                      double buttonWidth =
                          (constraints.maxWidth - 16) / 3; // até 3 botões
                      return Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: [
                          SizedBox(
                            width: buttonWidth > 250 ? 250 : buttonWidth,
                            child: ElevatedButton(
                              onPressed: selectedUser != null
                                  ? () {
                                      // Banir usuário
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                              ),
                              child: Text(
                                "Banir",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: buttonWidth > 250 ? 250 : buttonWidth,
                            child: ElevatedButton(
                              onPressed: selectedUser != null && showBanned
                                  ? () {
                                      // Desbanir usuário
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryFixedDim,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                              ),
                              child: Text(
                                "Desbanir",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: buttonWidth > 250 ? 250 : buttonWidth,
                            child: ElevatedButton(
                              onPressed: selectedUser != null
                                  ? () {
                                      // Marcar como resolvido
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 20),
                              ),
                              child: Text(
                                "Resolvido  ",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryFixed),
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
