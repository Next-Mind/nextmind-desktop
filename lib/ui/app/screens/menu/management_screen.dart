import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:desktop_nextmind/ui/app/view_models/management_view_model.dart';
import 'package:desktop_nextmind/ui/app/widgets/psychologist_card.dart';
import 'package:desktop_nextmind/ui/app/widgets/invite_admin_tab.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ManagementViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _viewModel = ManagementViewModel();
    Future.microtask(() => _viewModel.fetchPending());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagementViewModel>.value(
      value: _viewModel,
      child: Consumer<ManagementViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            appBar: AppBar(
              centerTitle: true,
              title: Text("Gerenciamento",
                  style: Theme.of(context).textTheme.titleLarge),
              bottom: TabBar(
                controller: _tabController,
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                tabs: const [
                  Tab(text: "Psicólogos Pendentes"),
                  Tab(text: "Convidar Admin"),
                ],
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                if (vm.isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (vm.error != null)
                  Center(
                      child: Text(vm.error!,
                          style: const TextStyle(color: Colors.red)))
                else if (vm.pending.isEmpty)
                  const Center(child: Text("Nenhum psicólogo pendente."))
                else
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: vm.pending.length,
                    itemBuilder: (context, index) {
                      final p = vm.pending[index];
                      final docUrl = p.documents.isNotEmpty
                          ? p.documents[0].temporaryUrl
                          : null;

                      final isRead = vm.isRead(p.id);

                      return PsychologistCard(
                        name: p.psychologist,
                        documentUrl: docUrl ?? '',
                        read: isRead,
                        onReadChange: (value) => vm.markAsRead(p.id, value),
                        onApprove: isRead
                            ? () async {
                                final ok = await showDialog<bool>(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text("Aprovar psicólogo"),
                                    content: Text(
                                        "Deseja aprovar ${p.psychologist}?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, false),
                                          child: const Text("Cancelar")),
                                      ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(ctx, true),
                                          child: const Text("Confirmar")),
                                    ],
                                  ),
                                );
                                if (ok == true) {
                                  try {
                                    await vm.approvePsychologist(p);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "✅ Psicólogo aprovado com sucesso")),
                                    );
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Erro ao aprovar: $e")),
                                    );
                                  }
                                }
                              }
                            : null,
                        onReject: () async {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text("Rejeitar psicólogo"),
                              content:
                                  Text("Deseja rejeitar ${p.psychologist}?"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text("Cancelar")),
                                ElevatedButton(
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text("Confirmar")),
                              ],
                            ),
                          );

                          if (ok != true) return;

                          try {
                            // Se não existe documento, apenas rejeita sem acessar arquivos
                            if (p.documents.isEmpty) {
                              await vm.rejectPsychologist(p,
                                  skipDocumentCheck: true);
                            } else {
                              await vm.rejectPsychologist(p);
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "❌ Psicólogo reprovado com sucesso")),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Erro ao reprovar: $e")),
                            );
                          }
                        },
                      );
                    },
                  ),
                const InviteAdminTab(),
              ],
            ),
          );
        },
      ),
    );
  }
}
