/// H1 — Beranda (Must).
/// Wireframe: nama SIMATA, penjelasan singkat, tombol utama
/// "Lacak Pengajuan", dan tautan kecil "Akses Petugas".
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                AppConstants.appName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pantau status dan tahapan pengajuan '
                'layanan administrasi Anda menggunakan '
                'nomor tracking, tanpa perlu menanyakan '
                'petugas.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/tracking'),
                child: const Text('Lacak Pengajuan'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/login-petugas'),
                child: const Text('Akses Petugas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
