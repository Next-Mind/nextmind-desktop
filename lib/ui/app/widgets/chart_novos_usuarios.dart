import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';

class ChartNovosUsuarios extends StatefulWidget {
  const ChartNovosUsuarios({super.key});

  @override
  State<ChartNovosUsuarios> createState() => _ChartNovosUsuariosState();
}

class _ChartNovosUsuariosState extends State<ChartNovosUsuarios> {
  String filtro = "12 meses";
  List<ChartData> data = [];

  @override
  void initState() {
    super.initState();
    _gerarDados(filtro);
  }

  void _gerarDados(String filtro) {
    final agora = DateTime.now();
    List<ChartData> dados = [];

    if (filtro == "7 dias") {
      for (int i = 6; i >= 0; i--) {
        final dia = agora.subtract(Duration(days: i));
        dados.add(ChartData("${dia.day}/${dia.month}", 20 + i * 5));
      }
    } else {
      for (int i = 11; i >= 0; i--) {
        final mes = DateTime(agora.year, agora.month - i, 1);
        dados.add(ChartData("${mes.month}/${mes.year}", 100 + i * 20));
      }
    }

    setState(() {
      data = dados;
      this.filtro = filtro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: "Novos Usuários",
      filtroAtual: filtro,
      onFiltroChange: _gerarDados,
      content: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          LineSeries<ChartData, String>(
            color: AppColors.primaryLight,
            dataSource: data,
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.value,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
