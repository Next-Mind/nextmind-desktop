import 'package:flutter/material.dart';

class ChartCard extends StatelessWidget {
  final String title;
  final Widget content;
  final bool showFilter;
  final String? filtroAtual;
  final Function(String)? onFiltroChange;

  const ChartCard({
    super.key,
    required this.title,
    required this.content,
    this.showFilter = true,
    this.filtroAtual,
    this.onFiltroChange,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    if (showFilter && filtroAtual != null) ...[
                      const SizedBox(width: 8),
                      Text("($filtroAtual)",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.blueGrey,
                              fontStyle: FontStyle.italic)),
                    ]
                  ],
                ),
                if (showFilter && onFiltroChange != null)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                    initialValue: filtroAtual,
                    onSelected: (value) => onFiltroChange!(value),
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: "7 dias", child: Text("Últimos 7 dias")),
                      PopupMenuItem(value: "30 dias", child: Text("Últimos 30 dias")),
                      PopupMenuItem(value: "6 meses", child: Text("Últimos 6 meses")),
                      PopupMenuItem(value: "12 meses", child: Text("Últimos 12 meses")),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
