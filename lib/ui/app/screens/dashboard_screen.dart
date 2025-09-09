import 'package:desktop_nextmind/ui/app/service/dashboard_service.dart';
import 'package:desktop_nextmind/ui/app/widgets/atividades_recentes.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_chamadas.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_novos_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_status_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/info_card.dart';
import 'package:flutter/material.dart'; 

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardService _service =
      DashboardService(baseUrl: "https://api-staging.nextmind.tech");

  int totalAlunos = 0;
  int totalPsicologos = 0;
  int totalUsuarios = 0;
  int totalAdmins = 0;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      final results = await Future.wait([
        _service.fetchCount("alunos/total"),
        _service.fetchCount("psicologos/total"),
        _service.fetchCount("admins/total"),
        _service.fetchCount("chamados/total"),
      ]);

      setState(() {
        totalAlunos = results[0];
        totalPsicologos = results[1];
        totalAdmins = results[2];
        totalUsuarios = results[3];
      });
    } catch (e) {
      debugPrint("Erro ao carregar dados do dashboard: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Relatório Geral",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Linha de cards resumo
            Row(
              children: [
                InfoCard(
                  icon: Icons.school,
                  value: totalAlunos.toString(),
                  label: "Alunos",
                ),
                InfoCard(
                  icon: Icons.psychology,
                  value: totalPsicologos.toString(),
                  label: "Psicólogos",
                ),
                InfoCard(
                  icon: Icons.admin_panel_settings,
                  value: totalAdmins.toString(),
                  label: "Admins",
                ),
                InfoCard(
                  icon: Icons.support_agent,
                  value: totalUsuarios.toString(),
                  label: "Chamados",
                ),
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