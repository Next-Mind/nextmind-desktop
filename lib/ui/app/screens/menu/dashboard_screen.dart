import 'package:desktop_nextmind/data/service/dashboard_service.dart';
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
  int totalAdmins = 0;
  int totalUsuarios = 0;

  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final results = await Future.wait([
        _service.fetchCount("admin/count/students"),
        _service.fetchCount("admin/count/psychologists"),
        _service.fetchCount("admin/count/admins"),
        _service.fetchCount("admin/count/all"),
      ]);

      if (!mounted) return;

      setState(() {
        totalAlunos = results[0];
        totalPsicologos = results[1];
        totalAdmins = results[2];
        totalUsuarios = results[3];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar dados do dashboard: $e");
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 8),
                        const Text(
                          "Erro ao carregar dados do dashboard",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _fetchDashboardData,
                          child: const Text("Tentar novamente"),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const Text(
                        "Relatório Geral",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
                            icon: Icons.person,
                            value: totalUsuarios.toString(),
                            label: "Usuários",
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
