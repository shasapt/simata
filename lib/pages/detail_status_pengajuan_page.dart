/// H3 — Detail Status Pengajuan (Must).
/// Wireframe: nomor tracking, jenis layanan, status terkini,
/// dan catatan informasi. Tombol "Lacak Pengajuan Lain"
/// kembali ke Tracking Pengajuan.
///
/// TODO (Minggu 6–7): lengkapi UI sesuai wireframe Figma.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../models/pengajuan.dart';
import '../widgets/status_badge.dart';

class DetailStatusPengajuanPage extends StatelessWidget {
  const DetailStatusPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pengajuan pengajuan =
        ModalRoute.of(context)?.settings.arguments as Pengajuan? ??
            const Pengajuan(
              nomorTracking: '-',
              jenisLayanan: '-',
              status: 'Diajukan',
            );

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageDetailStatus)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pengajuan.nomorTracking,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Jenis Layanan: ${pengajuan.jenisLayanan}'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('Status: '),
                        StatusBadge(status: pengajuan.status),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text('Tahap ${pengajuan.tahap + 1} dari 4'),
                    if (pengajuan.catatan.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        pengajuan.catatan,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () =>
                  Navigator.popUntil(context, ModalRoute.withName('/')),
              child: const Text('Lacak Pengajuan Lain'),
            ),
          ],
        ),
      ),
    );
  }
}
