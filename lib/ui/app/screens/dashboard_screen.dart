import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            const Text(
              "Relatório Geral",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Linha de Cards: Alunos | Psicólogos | Admin | Chamados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard(Icons.school, "1250", "Alunos"),
                _buildInfoCard(Icons.psychology, "130", "Psicólogos"),
                _buildInfoCard(Icons.admin_panel_settings, "7", "Administradores"),
                _buildInfoCard(Icons.support_agent, "14", "Chamados"),
              ],
            ),

            const SizedBox(height: 20),

            // Linha de Gráficos 1: Novos usuários | Status Usuário
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildChartCard(
                      "Novos Usuários por Mês",
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[
                          LineSeries<_ChartData, String>(
                            dataSource: [
                              _ChartData("Jan", 120),
                              _ChartData("Fev", 150),
                              _ChartData("Mar", 180),
                              _ChartData("Abr", 200),
                            ],
                            xValueMapper: (data, _) => data.label,
                            yValueMapper: (data, _) => data.value,
                            markerSettings: const MarkerSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildChartCard(
                      "Status de Usuários",
                      SfCircularChart(
                        legend: Legend(isVisible: true),
                        series: <CircularSeries>[
                          PieSeries<_ChartData, String>(
                            dataSource: [
                              _ChartData("Ativos", 80),
                              _ChartData("Banidos", 10),
                              _ChartData("Reportados", 15),
                            ],
                            xValueMapper: (data, _) => data.label,
                            yValueMapper: (data, _) => data.value,
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Linha de Gráficos 2: Chamadas abertas | Atividades recentes
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: _buildChartCard(
                      "Chamadas Abertas por Dia",
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <CartesianSeries>[
                          ColumnSeries<_ChartData, String>(
                            dataSource: [
                              _ChartData("Seg", 5),
                              _ChartData("Ter", 8),
                              _ChartData("Qua", 6),
                              _ChartData("Qui", 10),
                              _ChartData("Sex", 7),
                            ],
                            xValueMapper: (data, _) => data.label,
                            yValueMapper: (data, _) => data.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildChartCard(
                      "Atividades Recentes",
                      ListView(
                        children: const [
                          ListTile(
                            leading: Icon(Icons.check_circle, color: Colors.green),
                            title: Text("Novo aluno cadastrado"),
                          ),
                          ListTile(
                            leading: Icon(Icons.report, color: Colors.orange),
                            title: Text("Usuário reportado"),
                          ),
                          ListTile(
                            leading: Icon(Icons.warning, color: Colors.red),
                            title: Text("Conta banida"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar os cards pequenos de informações
  Widget _buildInfoCard(IconData icon, String value, String label) {
    return Expanded(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.blueAccent),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(label, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  // Função para criar os cards que contêm gráficos ou listas
  Widget _buildChartCard(String title, Widget content) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}

// Classe para dados de gráficos
class _ChartData {
  final String label;
  final int value;
  _ChartData(this.label, this.value);
}
