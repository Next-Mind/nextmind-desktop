import 'package:desktop_nextmind/core/theme/app_colors.dart';
import 'package:desktop_nextmind/core/utils/appRoutes.dart';
import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/chart_data.dart';

class ChartStatusUsuarios extends StatelessWidget {
  final bool showDashboardButton;
  const ChartStatusUsuarios({super.key, this.showDashboardButton = false});

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
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Status de Usuários",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (showDashboardButton)
            IconButton(
              icon: const Icon(Icons.arrow_right),
              tooltip: "Ir para Dashboard",
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    settings: RouteSettings(
                      name: AppRoutes.dashboard,
                    ),
                    pageBuilder: (context, _, __) =>
                        AppRoutes.routes[AppRoutes.dashboard]!(context),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
            ),
        ],
      ),
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
