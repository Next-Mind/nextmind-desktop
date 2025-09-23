 import 'package:desktop_nextmind/ui/app/widgets/chard_card.dart';
import 'package:flutter/material.dart';

class AtividadesRecentes extends StatelessWidget {
  const AtividadesRecentes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: "Atividades Recentes",
      showFilter: false,
      content: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.person_add_alt_1, color: Colors.blue),
            title: Text("Novo aluno cadastrado"),
            subtitle: Text("há 15 minutos"),
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline, color: Colors.green),
            title: Text("Psicólogo aprovou atendimento"),
            subtitle: Text("há 1 hora"),
          ),
          ListTile(
            leading: Icon(Icons.flag_outlined, color: Colors.orange),
            title: Text("Usuário reportado"),
            subtitle: Text("há 3 horas"),
          ),
          ListTile(
            leading: Icon(Icons.block, color: Colors.red),
            title: Text("Conta banida"),
            subtitle: Text("há 6 horas"),
          ),
        ],
      ),
    );
  }
}
