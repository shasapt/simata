/// H4 — Login Petugas (Should).
/// Login email/password khusus petugas, berada di luar alur utama
/// masyarakat. Pada tahap Minggu 6–7 autentikasi masih simulasi
/// (tanpa Firebase).
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

class LoginPetugasPage extends StatefulWidget {
  const LoginPetugasPage({super.key});

  @override
  State<LoginPetugasPage> createState() => _LoginPetugasPageState();
}

class _LoginPetugasPageState extends State<LoginPetugasPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _memproses = false;
  bool _passwordTersembunyi = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _memproses = true);
    // Simulasi proses autentikasi. Firebase Authentication
    // dikerjakan pada tahap berikutnya.
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    setState(() => _memproses = false);
    await Navigator.pushNamed(context, '/kelola-pengajuan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageLoginPetugas)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Icon(
                  Icons.admin_panel_settings_outlined,
                  size: 56,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Masuk sebagai Petugas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Kelola data pengajuan dan perbarui status '
                  'sesuai alur layanan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                            validator: (String? value) {
                              final String email = (value ?? '').trim();
                              if (email.isEmpty) {
                                return 'Email wajib diisi.';
                              }
                              if (!email.contains('@') ||
                                  !email.contains('.')) {
                                return 'Format email belum benar.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _passwordTersembunyi,
                            decoration: InputDecoration(
                              labelText: 'Kata Sandi',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                tooltip: _passwordTersembunyi
                                    ? 'Tampilkan kata sandi'
                                    : 'Sembunyikan kata sandi',
                                icon: Icon(
                                  _passwordTersembunyi
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () => setState(
                                  () => _passwordTersembunyi =
                                      !_passwordTersembunyi,
                                ),
                              ),
                            ),
                            validator: (String? value) =>
                                (value == null || value.isEmpty)
                                    ? 'Kata sandi wajib diisi.'
                                    : null,
                          ),
                          const SizedBox(height: 24),
                          FilledButton(
                            onPressed: _memproses ? null : _login,
                            child: _memproses
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Masuk'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tahap Minggu 6–7: login masih simulasi, belum '
                  'terhubung ke Firebase Authentication.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.neutral,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
