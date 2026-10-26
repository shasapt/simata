/// H3 — Detail Status Pengajuan (Must).
/// Wireframe: nomor tracking, jenis layanan, status terkini,
/// tahapan workflow, dan catatan informasi.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                pengajuan.nomorTracking,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            StatusBadge(status: pengajuan.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          pengajuan.jenisLayanan,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tahapan Pengajuan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (int i = 0;
                            i < AppConstants.statusWorkflow.length;
                            i++)
                          _LangkahWorkflow(
                            label: AppConstants.statusWorkflow[i],
                            selesai: i <= pengajuan.tahap,
                            aktif: i == pengajuan.tahap,
                            terakhir: i ==
                                AppConstants.statusWorkflow.length - 1,
                          ),
                      ],
                    ),
                  ),
                ),
                if (pengajuan.catatan.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Catatan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            pengajuan.catatan,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/riwayat-status',
                    arguments: pengajuan,
                  ),
                  child: const Text('Lihat Riwayat Status'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName('/')),
                  child: const Text('Lacak Pengajuan Lain'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Satu baris tahapan pada timeline workflow.
class _LangkahWorkflow extends StatelessWidget {
  const _LangkahWorkflow({
    required this.label,
    required this.selesai,
    required this.aktif,
    required this.terakhir,
  });

  final String label;
  final bool selesai;
  final bool aktif;
  final bool terakhir;

  @override
  Widget build(BuildContext context) {
    final Color warna = selesai ? AppColors.primary : AppColors.neutral;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: selesai ? warna : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: warna, width: 2),
                ),
                child: selesai
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              if (!terakhir)
                Expanded(
                  child: Container(
                    width: 2,
                    color: warna,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: terakhir ? 0 : 20),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: aktif ? FontWeight.bold : FontWeight.normal,
                  color: selesai ? AppColors.textPrimary : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
