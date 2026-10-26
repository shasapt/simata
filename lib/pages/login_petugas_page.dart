/// H4 — Login Petugas (Should).
/// Login email/password (Firebase Authentication) khusus petugas.
/// Berada di luar alur utama masyarakat.
///
/// TODO (Minggu 8+): hubungkan dengan Firebase Authentication.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';

class LoginPetugasPage extends StatefulWidget {
  const LoginPetugasPage({super.key});

  @override
  State<LoginPetugasPage> createState() => _LoginPetugasPageState();
}

class _LoginPetugasPageState extends State<LoginPetugasPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // TODO (Minggu 8+): Firebase Authentication email/password.
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, '/kelola-pengajuan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageLoginPetugas)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Masuk untuk mengelola data pengajuan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (String? value) =>
                      (value == null || value.isEmpty)
                          ? 'Email wajib diisi.'
                          : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Kata Sandi',
                  ),
                  validator: (String? value) =>
                      (value == null || value.isEmpty)
                          ? 'Kata sandi wajib diisi.'
                          : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _login,
                  child: const Text('Masuk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
