/// Konstanta global aplikasi SIMATA.
class AppConstants {
  AppConstants._();

  static const String appName = 'SIMATA';
  static const String appFullName =
      'SIMATA — Sistem Informasi Monitoring Administrasi dan Tracking';

  /// Alur workflow status pengajuan (Minggu 3).
  /// Diajukan -> Diverifikasi -> Diproses -> Selesai
  static const List<String> statusWorkflow = [
    'Diajukan',
    'Diverifikasi',
    'Diproses',
    'Selesai',
  ];

  /// Nama halaman final (harus konsisten di flow, sitemap, menu, judul layar).
  static const String pageBeranda = 'Beranda';
  static const String pageTracking = 'Tracking Pengajuan';
  static const String pageDetailStatus = 'Detail Status Pengajuan';
  static const String pageLoginPetugas = 'Login Petugas';
  static const String pageKelolaPengajuan = 'Kelola Pengajuan';
  static const String pageRiwayatStatus = 'Riwayat Status';
}
