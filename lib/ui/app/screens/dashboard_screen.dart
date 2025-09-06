import 'package:desktop_nextmind/ui/app/widgets/atividades_recentes.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_chamadas.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_novos_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_status_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/info_card.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Relatório Geral",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Linha de cards resumo
            Row(
              children: const [
                InfoCard(icon: Icons.school, value: "1250", label: "Alunos"),
                InfoCard(icon: Icons.psychology, value: "130", label: "Psicólogos"),
                InfoCard(icon: Icons.admin_panel_settings, value: "7", label: "Admins"),
                InfoCard(icon: Icons.support_agent, value: "14", label: "Chamados"),
              ],
            ),
            const SizedBox(height: 20),

            // Gráficos (linha 1)
            Expanded(
              child: Row(
                children: const [
                  Expanded(child: ChartNovosUsuarios()),
                  SizedBox(width: 16),
                  Expanded(child: ChartStatusUsuarios()),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Gráficos (linha 2)
            Expanded(
              child: Row(
                children: const [
                  Expanded(child: ChartChamadas()),
                  SizedBox(width: 16),
                  Expanded(child: AtividadesRecentes()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
