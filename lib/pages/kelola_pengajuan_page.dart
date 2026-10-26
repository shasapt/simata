/// H5 — Kelola Pengajuan (Should / jalur petugas).
/// Daftar pengajuan, tambah pengajuan baru, dan majukan status
/// mengikuti workflow: Diajukan -> Diverifikasi -> Diproses -> Selesai.
///
/// Data masih simulasi (in-memory); Cloud Firestore menyusul.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../models/pengajuan.dart';
import '../services/pengajuan_service.dart';
import '../widgets/status_badge.dart';

class KelolaPengajuanPage extends StatefulWidget {
  const KelolaPengajuanPage({super.key});

  @override
  State<KelolaPengajuanPage> createState() => _KelolaPengajuanPageState();
}

class _KelolaPengajuanPageState extends State<KelolaPengajuanPage> {
  final PengajuanService _service = PengajuanService.instance;

  List<Pengajuan> _daftar = [];
  bool _memuat = true;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  Future<void> _muatData() async {
    final List<Pengajuan> data = await _service.daftarPengajuan();
    if (!mounted) return;
    setState(() {
      _daftar = data;
      _memuat = false;
    });
  }

  void _pesan(String teks) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(teks)));
  }

  Future<void> _bukaDetail(Pengajuan pengajuan) async {
    final String? aksi = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) =>
          _DetailPengajuanSheet(pengajuan: pengajuan),
    );
    if (!mounted || aksi == null) return;

    if (aksi == 'riwayat') {
      await Navigator.pushNamed(
        context,
        '/riwayat-status',
        arguments: pengajuan,
      );
      return;
    }

    if (aksi == 'majukan') {
      final Pengajuan terbaru = await _service.majukanStatus(pengajuan);
      if (!mounted) return;
      await _muatData();
      if (!mounted) return;
      _pesan(
        terbaru.status == pengajuan.status
            ? 'Status sudah berada di tahap akhir.'
            : '${terbaru.nomorTracking} kini berstatus ${terbaru.status}.',
      );
    }
  }

  Future<void> _tambahPengajuan() async {
    final Pengajuan? baru = await showDialog<Pengajuan>(
      context: context,
      builder: (BuildContext dialogContext) =>
          const _FormTambahPengajuan(),
    );
    if (baru == null || !mounted) return;

    await _muatData();
    if (!mounted) return;
    _pesan(
      'Pengajuan tersimpan dengan nomor tracking '
      '${baru.nomorTracking}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.pageKelolaPengajuan),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: _memuat
              ? const Center(child: CircularProgressIndicator())
              : _daftar.isEmpty
                  ? const Center(
                      child: Text(
                        'Belum ada pengajuan. '
                        'Tambahkan pengajuan pertama.',
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _muatData,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _daftar.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(height: 8),
                        itemBuilder: (BuildContext context, int index) {
                          final Pengajuan p = _daftar[index];
                          return Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              title: Text(
                                p.nomorTracking,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(p.jenisLayanan),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tahap ${p.tahap + 1} dari '
                                      '${Pengajuan.statusWorkflow.length}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.neutral,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: StatusBadge(status: p.status),
                              onTap: () => _bukaDetail(p),
                            ),
                          );
                        },
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahPengajuan,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Pengajuan'),
      ),
    );
  }
}

/// Lembar detail pengajuan pada halaman Kelola Pengajuan.
class _DetailPengajuanSheet extends StatelessWidget {
  const _DetailPengajuanSheet({required this.pengajuan});

  final Pengajuan pengajuan;

  @override
  Widget build(BuildContext context) {
    final String? berikutnya = pengajuan.statusBerikutnya;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    pengajuan.nomorTracking,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
            if (pengajuan.catatan.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                pengajuan.catatan,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context, 'riwayat'),
              icon: const Icon(Icons.history, size: 18),
              label: const Text('Lihat Riwayat Status'),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: berikutnya == null
                  ? null
                  : () => Navigator.pop(context, 'majukan'),
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: Text(
                berikutnya == null
                    ? 'Sudah tahap akhir'
                    : 'Ubah ke $berikutnya',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dialog form tambah pengajuan baru.
class _FormTambahPengajuan extends StatefulWidget {
  const _FormTambahPengajuan();

  @override
  State<_FormTambahPengajuan> createState() => _FormTambahPengajuanState();
}

class _FormTambahPengajuanState extends State<_FormTambahPengajuan> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _jenisController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();

  bool _menyimpan = false;

  @override
  void dispose() {
    _jenisController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  Future<void> _simpan() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _menyimpan = true);
    final Pengajuan baru =
        await PengajuanService.instance.tambahPengajuan(
      jenisLayanan: _jenisController.text.trim(),
      catatan: _catatanController.text.trim(),
    );
    if (!mounted) return;
    Navigator.pop(context, baru);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Pengajuan'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _jenisController,
              decoration: const InputDecoration(
                labelText: 'Jenis Layanan',
                hintText: 'Contoh: Permohonan Surat Keterangan',
              ),
              validator: (String? value) =>
                  (value == null || value.trim().isEmpty)
                      ? 'Jenis layanan wajib diisi.'
                      : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _catatanController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nomor tracking dibuat otomatis oleh sistem.',
              style: TextStyle(fontSize: 12, color: AppColors.neutral),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _menyimpan ? null : () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        FilledButton(
          onPressed: _menyimpan ? null : _simpan,
          child: _menyimpan
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}
