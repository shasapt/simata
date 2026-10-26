/// H6 — Riwayat Status (Should).
/// Menampilkan urutan perubahan status pengajuan dari data tersimpan.
/// Dibuka dari Detail Status Pengajuan / Kelola Pengajuan.
///
/// TODO (Minggu 8+): ambil riwayat dari koleksi Firestore.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../models/pengajuan.dart';
import '../widgets/status_badge.dart';

class RiwayatStatusPage extends StatelessWidget {
  const RiwayatStatusPage({super.key});

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
      appBar: AppBar(title: const Text(AppConstants.pageRiwayatStatus)),
      body: pengajuan.riwayatStatus.isEmpty
          ? const Center(
              child: Text('Belum ada riwayat perubahan status.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: pengajuan.riwayatStatus.length,
              itemBuilder: (BuildContext context, int index) {
                final String entri = pengajuan.riwayatStatus[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        if (index != pengajuan.riwayatStatus.length - 1)
                          Container(
                            width: 2,
                            height: 40,
                            color: AppColors.neutral,
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          entri,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: StatusBadge(status: pengajuan.status),
        ),
      ),
    );
  }
}
