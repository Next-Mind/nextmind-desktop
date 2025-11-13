import 'package:desktop_nextmind/ui/app/screens/menu/psychologist_documents_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              title: Text(
                "Gerenciamento",
                style: Theme.of(context).textTheme.titleLarge,
              ),
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
                    child: Text(
                      vm.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                else if (vm.pending.isEmpty)
                  const Center(child: Text("Nenhum psicólogo pendente."))
                else
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: vm.pending.length,
                          itemBuilder: (context, index) {
                            final p = vm.pending[index];
                            final docUrl = p.documents.isNotEmpty
                                ? (p.documents[0].temporaryUrl ?? '')
                                : '';
                            final docId = p.documents.isNotEmpty
                                ? (p.documents[0].id is int
                                    ? p.documents[0].id as int
                                    : int.tryParse(p.documents[0].id.toString()) ?? 0)
                                : 0;
                            final isRead = vm.isRead(p.id);

                            return PsychologistCard(
                              name: p.psychologist,
                              documentId: docId,
                              documentUrl: docUrl,
                              read: isRead,
                              onReadChange: (value) =>
                                  vm.markAsRead(p.id, value),
                              onTap: () async {
                                if (p.documents.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Nenhum documento disponível"),
                                    ),
                                  );
                                  return;
                                }

                                final prefs =
                                    await SharedPreferences.getInstance();
                                final token = prefs.getString("token");

                                if (token == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Token não encontrado")),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PsychologistDocumentsScreen(
                                      documents: p.documents,
                                      token: token,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
