import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'pages/beranda_page.dart';
import 'pages/detail_status_pengajuan_page.dart';
import 'pages/kelola_pengajuan_page.dart';
import 'pages/login_petugas_page.dart';
import 'pages/riwayat_status_page.dart';
import 'pages/tracking_pengajuan_page.dart';

void main() {
  runApp(const SimataApp());
}

/// Root aplikasi SIMATA.
class SimataApp extends StatelessWidget {
  const SimataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.light,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const BerandaPage(),
        '/tracking': (BuildContext context) =>
            const TrackingPengajuanPage(),
        '/detail-status': (BuildContext context) =>
            const DetailStatusPengajuanPage(),
        '/login-petugas': (BuildContext context) =>
            const LoginPetugasPage(),
        '/kelola-pengajuan': (BuildContext context) =>
            const KelolaPengajuanPage(),
        '/riwayat-status': (BuildContext context) =>
            const RiwayatStatusPage(),
      },
    );
  }
}
