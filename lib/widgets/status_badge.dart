/// Widget penanda status yang konsisten dengan style guide:
/// hijau = selesai, oranye = masih diproses/menunggu, merah = galat/ditolak.
///
/// Status tidak disampaikan hanya dengan warna — selalu disertai teks.
library;

import 'package:flutter/material.dart';

import '../core/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String status;

  Color get _color {
    switch (status) {
      case 'Selesai':
        return AppColors.statusSuccess;
      case 'Ditolak':
        return AppColors.statusError;
      case 'Diajukan':
      case 'Diverifikasi':
      case 'Diproses':
      default:
        return AppColors.statusWaiting;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color color = _color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
