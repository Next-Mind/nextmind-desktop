import 'package:desktop_nextmind/data/service/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:desktop_nextmind/core/theme/app_colors.dart';

class InviteAdminTab extends StatefulWidget {
  const InviteAdminTab({super.key});

  @override
  State<InviteAdminTab> createState() => _InviteAdminTabState();
}

class _InviteAdminTabState extends State<InviteAdminTab> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AdminService _adminService = AdminService();

  bool _isLoading = false;

  Future<void> _confirmAndInvite() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirmar convite"),
        content: Text("Deseja realmente enviar um convite para $email?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text("Confirmar"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);

    final result = await _adminService.inviteAdmin(email);

    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result["message"])),
    );

    if (result["success"]) {
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Convide novos administradores",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail do administrador",
                filled: true,
                fillColor: AppColors.onErrorLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) => value != null && value.contains("@")
                  ? null
                  : "Digite um e-mail válido!",
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _confirmAndInvite,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send_rounded),
              label: Text(
                _isLoading ? "Enviando convite..." : "Enviar convite",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
