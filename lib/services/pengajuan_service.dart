/// Service akses data pengajuan (versi simulasi / in-memory).
///
/// Data disimpan di memori sehingga perubahan status dan pengajuan baru
/// hilang saat aplikasi ditutup. Penggantian ke Cloud Firestore
/// dikerjakan pada tahap berikutnya (di luar Minggu 6–7).
library;

import '../models/pengajuan.dart';

class PengajuanService {
  PengajuanService._();

  /// Instance tunggal agar seluruh halaman memakai data yang sama.
  static final PengajuanService instance = PengajuanService._();

  final List<Pengajuan> _data = [
    const Pengajuan(
      nomorTracking: 'SIMATA-001',
      jenisLayanan: 'Permohonan Surat Keterangan',
      status: 'Diajukan',
      catatan: 'Pengajuan sedang menunggu verifikasi petugas.',
      riwayatStatus: ['Diajukan — 10 Oktober 2026'],
    ),
    const Pengajuan(
      nomorTracking: 'SIMATA-002',
      jenisLayanan: 'Permohonan Legalisasi Dokumen',
      status: 'Diverifikasi',
      catatan: 'Dokumen telah diverifikasi, menunggu proses lanjutan.',
      riwayatStatus: [
        'Diajukan — 12 Oktober 2026',
        'Diverifikasi — 14 Oktober 2026',
      ],
    ),
    const Pengajuan(
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

  int _urutan = 3;

  static const List<String> _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String _tanggalSekarang() {
    final DateTime now = DateTime.now();
    return '${now.day} ${_namaBulan[now.month - 1]} ${now.year}';
  }

  /// Mencari pengajuan berdasarkan nomor tracking.
  /// Mengembalikan null bila nomor tidak ditemukan.
  Future<Pengajuan?> cariByNomorTracking(String nomorTracking) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final String query = nomorTracking.trim().toUpperCase();
    for (final Pengajuan p in _data) {
      if (p.nomorTracking.toUpperCase() == query) return p;
    }
    return null;
  }

  /// Daftar seluruh pengajuan (halaman Kelola Pengajuan petugas).
  Future<List<Pengajuan>> daftarPengajuan() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return List<Pengajuan>.unmodifiable(_data);
  }

  /// Menambah pengajuan baru dan menghasilkan nomor tracking.
  Future<Pengajuan> tambahPengajuan({
    required String jenisLayanan,
    String catatan = '',
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _urutan++;
    final String nomor =
        'SIMATA-${_urutan.toString().padLeft(3, '0')}';
    final Pengajuan baru = Pengajuan(
      nomorTracking: nomor,
      jenisLayanan: jenisLayanan,
      status: Pengajuan.statusWorkflow.first,
      catatan: catatan,
      riwayatStatus: ['Diajukan — ${_tanggalSekarang()}'],
    );
    _data.insert(0, baru);
    return baru;
  }

  /// Memajukan status pengajuan satu langkah sesuai workflow.
  /// Mengembalikan pengajuan terbaru (tidak berubah bila sudah Selesai).
  Future<Pengajuan> majukanStatus(Pengajuan pengajuan) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final int index = _data.indexWhere(
      (Pengajuan p) => p.nomorTracking == pengajuan.nomorTracking,
    );
    if (index < 0) return pengajuan;

    final Pengajuan sekarang = _data[index];
    final String? berikutnya = sekarang.statusBerikutnya;
    if (berikutnya == null) return sekarang;

    final Pengajuan diperbarui = sekarang.copyWith(
      status: berikutnya,
      riwayatStatus: [
        ...sekarang.riwayatStatus,
        '$berikutnya — ${_tanggalSekarang()}',
      ],
    );
    _data[index] = diperbarui;
    return diperbarui;
  }
}
