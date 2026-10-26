/// Palet warna style guide mini SIMATA (Modul Minggu 4).
///
/// Warna primer  : #2563EB (aksi utama / penanda aktif)
/// Teks          : #111827
/// Latar         : #F9FAFB
/// Garis/netral  : #D1D5DB
/// Status        : hijau #16A34A (berhasil/selesai),
///                 oranye #F59E0B (menunggu/diproses),
///                 merah #DC2626 (galat/ditolak)
library;

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2563EB);
  static const Color textPrimary = Color(0xFF111827);
  static const Color background = Color(0xFFF9FAFB);
  static const Color neutral = Color(0xFFD1D5DB);

  static const Color statusSuccess = Color(0xFF16A34A);
  static const Color statusWaiting = Color(0xFFF59E0B);
  static const Color statusError = Color(0xFFDC2626);
}
