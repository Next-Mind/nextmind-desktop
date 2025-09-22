import 'package:flutter/material.dart';
import 'package:desktop_nextmind/ui/app/widgets/admin_card.dart';
import 'package:desktop_nextmind/ui/app/widgets/psychologist_card.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> pendingPsychologists = [
    {
      "name": "Dr. João Silva",
      "documentUrl": "https://eppg.fgv.br/sites/default/files/teste.pdf",
      "read": false
    },
    {
      "name": "Dra. Maria Souza",
      "documentUrl": "https://eppg.fgv.br/sites/default/files/teste.pdf",
      "read": false
    },
  ];

  final List<Map<String, dynamic>> pendingAdmins = [
    {
      "name": "Carlos Lima",
      "email": "carlos@email.com",
      "role": "Administrador",
      "createdAt": "2025-09-10",
      "reviewed": false
    },
    {
      "name": "Ana Paula",
      "email": "ana@email.com",
      "role": "Administrador",
      "createdAt": "2025-09-15",
      "reviewed": false
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
            Tab(text: "Admins Pendentes"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: pendingPsychologists.map((p) {
              return PsychologistCard(
                name: p["name"],
                documentUrl: p["documentUrl"],
                read: p["read"],
                onReadChange: (value) {
                  setState(() {
                    p["read"] = value;
                  });
                },
                onApprove: () {
                  debugPrint("✅ Psicólogo ${p["name"]} aprovado");
                },
                onReject: () {
                  debugPrint("❌ Psicólogo ${p["name"]} rejeitado");
                },
              );
            }).toList(),
          ),
          ListView(
            children: pendingAdmins.map((a) {
              return AdminCard(
                name: a["name"],
                email: a["email"],
                role: a["role"],
                createdAt: a["createdAt"],
                reviewed: a["reviewed"],
                onReview: () {
                  setState(() {
                    a["reviewed"] = true;
                  });
                },
                onApprove: () {
                  debugPrint("✅ Admin ${a["name"]} aprovado");
                },
                onReject: () {
                  debugPrint("❌ Admin ${a["name"]} rejeitado");
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
