import 'package:desktop_nextmind/ui/app/view_models/audit_view_model.dart';
import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/audit_model.dart';

class AtividadesRecentes extends StatelessWidget {
  const AtividadesRecentes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuditViewModel()..loadAudits(),
      child: Consumer<AuditViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoading) {
            return const ChartCard(
              title: "Atividades Recentes",
              showFilter: false,
              content: Center(child: CircularProgressIndicator()),
            );
          }

          if (viewModel.error != null) {
            return ChartCard(
              title: "Atividades Recentes",
              showFilter: false,
              content: Center(child: Text("Erro: ${viewModel.error}")),
            );
          }

          final List<Audit> audits = viewModel.audits;

          if (audits.isEmpty) {
            return const ChartCard(
              title: "Atividades Recentes",
              showFilter: false,
              content: Center(child: Text("Nenhuma atividade recente.")),
            );
          }

          return ChartCard(
            title: "Atividades Recentes",
            showFilter: false,
            content: ListView.separated(
              itemCount: audits.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final audit = audits[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: audit.eventColor.withOpacity(0.15),
                    child: Icon(audit.eventIcon, color: audit.eventColor),
                  ),
                  title: Text(
                    audit.readableMessage,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    audit.createdAt != null
                        ? _formatDate(audit.createdAt!)
                        : "Data desconhecida",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String isoString) {
    try {
      final date = DateTime.parse(isoString).toLocal();
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year} às "
          "${date.hour.toString().padLeft(2, '0')}:"
          "${date.minute.toString().padLeft(2, '0')}";
    } catch (_) {
      return isoString;
    }
  }
}
