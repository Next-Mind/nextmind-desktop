import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';

class ChartChamadas extends StatefulWidget {
  const ChartChamadas({super.key});

  @override
  State<ChartChamadas> createState() => _ChartChamadasState();
}

class _ChartChamadasState extends State<ChartChamadas> {
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
        dados.add(ChartData("${dia.day}/${dia.month}", 5 + i));
      }
    } else {
      for (int i = 11; i >= 0; i--) {
        final mes = DateTime(agora.year, agora.month - i, 1);
        dados.add(ChartData("${mes.month}/${mes.year}", 8 + i * 2));
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
      title: "Chamadas",
      filtroAtual: filtro,
      onFiltroChange: _gerarDados,
      content: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            color: AppColors.primaryLight,
            dataSource: data,
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.value,
          ),
        ],
      ),
    );
  }
}
