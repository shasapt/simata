/// H1 — Beranda (Must).
/// Wireframe: nama SIMATA, penjelasan singkat, tombol utama
/// "Lacak Pengajuan", dan tautan kecil "Akses Petugas".
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key, this.onLacak, this.onPetugas});

  /// Aksi tombol utama: berpindah ke tab Tracking Pengajuan.
  final VoidCallback? onLacak;

  /// Aksi tautan kecil: berpindah ke tab Petugas.
  final VoidCallback? onPetugas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
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
                  'Pantau status dan tahapan pengajuan layanan '
                  'administrasi Anda menggunakan nomor tracking, '
                  'tanpa perlu menanyakan petugas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: onLacak,
                  icon: const Icon(Icons.search),
                  label: const Text('Lacak Pengajuan'),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Cara kerja',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                const _LangkahCard(
                  nomor: '1',
                  judul: 'Terima nomor tracking',
                  isi: 'Setiap pengajuan yang dicatat petugas '
                      'memiliki nomor tracking.',
                ),
                const SizedBox(height: 8),
                const _LangkahCard(
                  nomor: '2',
                  judul: 'Masukkan nomor tracking',
                  isi: 'Buka Tracking Pengajuan, lalu masukkan '
                      'nomor tracking Anda.',
                ),
                const SizedBox(height: 8),
                const _LangkahCard(
                  nomor: '3',
                  judul: 'Pantau status',
                  isi: 'Lihat status terkini dan tahapan proses '
                      'pengajuan Anda.',
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton.icon(
                    onPressed: onPetugas,
                    icon: const Icon(Icons.badge_outlined, size: 18),
                    label: const Text('Akses Petugas'),
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

class _LangkahCard extends StatelessWidget {
  const _LangkahCard({
    required this.nomor,
    required this.judul,
    required this.isi,
  });

  final String nomor;
  final String judul;
  final String isi;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Text(
                nomor,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(isi, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
