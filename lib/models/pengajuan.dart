/// Model data pengajuan layanan administrasi.
///
/// Struktur mengikuti kebutuhan data Minggu 1: data pengajuan,
/// nomor tracking, jenis layanan, status, tahapan, catatan,
/// dan riwayat perubahan status.
library;

class Pengajuan {
  const Pengajuan({
    required this.nomorTracking,
    required this.jenisLayanan,
    required this.status,
    this.catatan = '',
    this.riwayatStatus = const [],
  });

  final String nomorTracking;
  final String jenisLayanan;
  final String status;
  final String catatan;

  /// Urutan perubahan status, mis. ['Diajukan — 10 Oktober 2026'].
  final List<String> riwayatStatus;

  /// Tahapan saat ini dalam workflow (indeks 0 = Diajukan).
  int get tahap {
    final int index = statusIndex(status);
    return index < 0 ? 0 : index;
  }

  /// Status berikutnya dalam workflow, null bila sudah Selesai.
  String? get statusBerikutnya {
    final int index = statusIndex(status);
    if (index < 0 || index >= statusWorkflow.length - 1) return null;
    return statusWorkflow[index + 1];
  }

  bool get sudahSelesai => status == statusWorkflow.last;

  Pengajuan copyWith({
    String? jenisLayanan,
    String? status,
    String? catatan,
    List<String>? riwayatStatus,
  }) {
    return Pengajuan(
      nomorTracking: nomorTracking,
      jenisLayanan: jenisLayanan ?? this.jenisLayanan,
      status: status ?? this.status,
      catatan: catatan ?? this.catatan,
      riwayatStatus: riwayatStatus ?? this.riwayatStatus,
    );
  }

  static int statusIndex(String status) {
    for (int i = 0; i < statusWorkflow.length; i++) {
      if (statusWorkflow[i] == status) return i;
    }
    return -1;
  }

  static const List<String> statusWorkflow = [
    'Diajukan',
    'Diverifikasi',
    'Diproses',
    'Selesai',
  ];
}
