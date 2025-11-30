import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/data/models/user_model.dart';
import 'package:desktop_nextmind/data/service/dashboard_service.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_novos_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/chart_status_usuarios.dart';
import 'package:desktop_nextmind/ui/app/widgets/info_card.dart';
import 'package:desktop_nextmind/ui/app/widgets/atividades_recentes.dart';
import 'package:desktop_nextmind/ui/app/widgets/quick_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserModel? user;
  const HomeScreen({super.key, this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardService _service =
      DashboardService(baseUrl: "https://api.nextmind.sbs");

  int totalAlunos = 0;
  int totalPsicologos = 0;
  int totalAdmins = 0;

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
      ]);

      if (!mounted) return;

      setState(() {
        totalAlunos = results[0];
        totalPsicologos = results[1];
        totalAdmins = results[2];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Erro ao carregar dados da Home: $e");
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
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
                            "Erro ao carregar dados da Home",
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Olá, ${widget.user?.name ?? 'Usuário'} 👋",
                                    style:
                                        theme.textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Papel: ${widget.user?.roles ?? '[N/D]'}",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.onSurface
                                          .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none),
                              onPressed: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Linha de cards resumo (dinâmico)
                        Row(
                          children: [
                            InfoCard(
                              icon: Icons.admin_panel_settings,
                              value: totalAlunos.toString(),
                              label: "Alunos",
                            ),
                            InfoCard(
                              icon: Icons.psychology,
                              value: totalPsicologos.toString(),
                              label: "Psicólogos",
                            ),
                            const InfoCard(
                              icon: Icons.school,
                              value: "8", // estático por enquanto
                              label: "Chamados",
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Botões rápidos
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            QuickButton(
                              icon: Icons.person_add,
                              label: "Aprovar Usuário",
                              color: AppColors.primaryLight,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    settings: RouteSettings(
                                        name: AppRoutes.management),
                                    pageBuilder: (context, _, __) => AppRoutes
                                        .routes[AppRoutes.management]!(context),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                            QuickButton(
                              icon: Icons.file_download,
                              label: "Exportar Relatório",
                              color: AppColors.primaryLight,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    settings: RouteSettings(
                                        name: AppRoutes.reports),
                                    pageBuilder: (context, _, __) => AppRoutes
                                        .routes[AppRoutes.reports]!(context),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                            QuickButton(
                              icon: Icons.support_agent,
                              label: "Ver Chamados",
                              color: AppColors.primaryLight,
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    settings: RouteSettings(
                                        name: AppRoutes.support),
                                    pageBuilder: (context, _, __) => AppRoutes
                                        .routes[AppRoutes.support]!(context),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Gráficos lado a lado
                        Expanded(
                          child: Row(
                            children: const [
                              Expanded(child: ChartStatusUsuarios(showDashboardButton: true,)),
                              SizedBox(width: 16),
                              Expanded(child: ChartNovosUsuarios()),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Log de atividades
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: AtividadesRecentes(),
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
