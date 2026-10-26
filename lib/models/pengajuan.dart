/// Model data pengajuan layanan administrasi.
///
/// Struktur mengikuti kebutuhan data Minggu 1: data pengajuan,
/// nomor tracking, jenis layanan, status, tahapan, catatan,
/// dan riwayat perubahan status.
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

  /// Urutan perubahan status, mis. ['Diajukan (10 Okt)', 'Diverifikasi (12 Okt)'].
  final List<String> riwayatStatus;

  /// Tahapan saat ini dalam workflow (indeks 0 = Diajukan).
  int get tahap {
    final int index = statusIndex(status);
    return index < 0 ? 0 : index;
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
