/// Service akses data pengajuan.
///
/// TODO (Minggu 8+): ganti implementasi mock dengan Cloud Firestore
/// (CRUD pengajuan + update status sesuai workflow).
library;

import '../models/pengajuan.dart';

class PengajuanService {
  const PengajuanService();

  /// Data simulasi sementara (sesuai batas proyek semester).
  static const List<Pengajuan> _mockData = [
    Pengajuan(
      nomorTracking: 'SIMATA-001',
      jenisLayanan: 'Permohonan Surat Keterangan',
      status: 'Diajukan',
      catatan: 'Pengajuan sedang menunggu verifikasi petugas.',
      riwayatStatus: ['Diajukan — 10 Oktober 2026'],
    ),
    Pengajuan(
      nomorTracking: 'SIMATA-002',
      jenisLayanan: 'Permohonan Legalisasi Dokumen',
      status: 'Diverifikasi',
      catatan: 'Dokumen telah diverifikasi, menunggu proses lanjutan.',
      riwayatStatus: [
        'Diajukan — 12 Oktober 2026',
        'Diverifikasi — 14 Oktober 2026',
      ],
    ),
    Pengajuan(
      nomorTracking: 'SIMATA-003',
      jenisLayanan: 'Permohonan Izin Kegiatan',
      status: 'Selesai',
      catatan: 'Izin kegiatan telah diterbitkan.',
      riwayatStatus: [
        'Diajukan — 1 Oktober 2026',
        'Diverifikasi — 3 Oktober 2026',
        'Diproses — 5 Oktober 2026',
        'Selesai — 8 Oktober 2026',
      ],
    ),
  ];

  /// Mencari pengajuan berdasarkan nomor tracking.
  /// Mengembalikan null bila nomor tidak ditemukan.
  Future<Pengajuan?> cariByNomorTracking(String nomorTracking) async {
    // Simulasi jeda jaringan kecil.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final String query = nomorTracking.trim().toUpperCase();
    for (final Pengajuan p in _mockData) {
      if (p.nomorTracking.toUpperCase() == query) return p;
    }
    return null;
  }

  /// Daftar seluruh pengajuan (untuk halaman Kelola Pengajuan petugas).
  Future<List<Pengajuan>> daftarPengajuan() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return _mockData;
  }
}
