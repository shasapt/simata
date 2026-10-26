/// H6 — Riwayat Status (Should).
/// Menampilkan urutan perubahan status pengajuan dari data tersimpan.
/// Dibuka dari Detail Status Pengajuan / Kelola Pengajuan.
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

    final List<String> riwayat = pengajuan.riwayatStatus.reversed.toList();

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageRiwayatStatus)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                pengajuan.nomorTracking,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(pengajuan.jenisLayanan),
                            ],
                          ),
                        ),
                        StatusBadge(status: pengajuan.status),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (riwayat.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Text('Belum ada riwayat perubahan status.'),
                    ),
                  )
                else
                  for (int i = 0; i < riwayat.length; i++)
                    _BarisRiwayat(
                      entri: riwayat[i],
                      terbaru: i == 0,
                      terakhir: i == riwayat.length - 1,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BarisRiwayat extends StatelessWidget {
  const _BarisRiwayat({
    required this.entri,
    required this.terbaru,
    required this.terakhir,
  });

  final String entri;
  final bool terbaru;
  final bool terakhir;

  @override
  Widget build(BuildContext context) {
    // Format data: "Diverifikasi — 14 Oktober 2026".
    final List<String> bagian = entri.split(' — ');
    final String status = bagian.first;
    final String tanggal = bagian.length > 1 ? bagian.sublist(1).join(' — ') : '';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: terbaru ? AppColors.primary : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
              ),
              if (!terakhir)
                const Expanded(
                  child: SizedBox(
                    width: 2,
                    child: ColoredBox(color: AppColors.neutral),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: terakhir ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              terbaru ? FontWeight.bold : FontWeight.normal,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (terbaru) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Terbaru',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (tanggal.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      tanggal,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.neutral,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
