import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';

class ChartStatusUsuarios extends StatelessWidget {
  const ChartStatusUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> statusUsuarios = [
      ChartData("Ativos", 80),
      ChartData("Banidos", 10),
      ChartData("Reportados", 15),
    ];

    final List<Color> barColors = [
      AppColors.primaryLight,
      AppColors.onPrimaryContainerLight,
      AppColors.onPrimaryLight,
    ];

    return ChartCard(
      title: "Status de Usuários",
      showFilter: false,
      content: SfCircularChart(
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<ChartData, String>(
            dataSource: statusUsuarios,
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.value,
            pointColorMapper: (datum, index) => barColors[index],
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}
