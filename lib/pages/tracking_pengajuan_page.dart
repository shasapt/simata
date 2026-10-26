/// H2 — Tracking Pengajuan (Must).
/// Wireframe: kolom nomor tracking, tombol "Cari Pengajuan",
/// petunjuk singkat. Keadaan alternatif:
/// 1) nomor kosong -> "Nomor tracking wajib diisi."
/// 2) nomor tidak ditemukan -> "Data pengajuan tidak ditemukan."
///
/// TODO (Minggu 6–7): lengkapi UI sesuai wireframe Figma.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_colors.dart';
import '../models/pengajuan.dart';
import '../services/pengajuan_service.dart';

class TrackingPengajuanPage extends StatefulWidget {
  const TrackingPengajuanPage({super.key});

  @override
  State<TrackingPengajuanPage> createState() => _TrackingPengajuanPageState();
}

class _TrackingPengajuanPageState extends State<TrackingPengajuanPage> {
  final TextEditingController _nomorController = TextEditingController();
  final PengajuanService _service = const PengajuanService();

  bool _searching = false;
  String? _error;

  @override
  void dispose() {
    _nomorController.dispose();
    super.dispose();
  }

  Future<void> _cariPengajuan() async {
    final String nomor = _nomorController.text.trim();

    // Alur alternatif 1: nomor kosong.
    if (nomor.isEmpty) {
      setState(() => _error = 'Nomor tracking wajib diisi.');
      return;
    }

    setState(() {
      _searching = true;
      _error = null;
    });

    final Pengajuan? hasil = await _service.cariByNomorTracking(nomor);

    if (!mounted) return;

    // Alur alternatif 2: nomor tidak ditemukan.
    if (hasil == null) {
      setState(() {
        _searching = false;
        _error = 'Data pengajuan tidak ditemukan.';
      });
      return;
    }

    setState(() => _searching = false);
    Navigator.pushNamed(
      context,
      '/detail-status',
      arguments: hasil,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageTracking)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Masukkan nomor tracking pengajuan Anda untuk '
                  'melihat status dan tahapan proses.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 24),
                Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _nomorController,
                          textCapitalization:
                              TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'Nomor Tracking',
                            hintText: 'Contoh: SIMATA-001',
                            errorText: _error,
                            prefixIcon: const Icon(Icons.tag),
                          ),
                          onSubmitted: (_) => _cariPengajuan(),
                        ),
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _searching ? null : _cariPengajuan,
                          child: _searching
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Cari Pengajuan'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nomor tracking contoh (data simulasi): '
                  'SIMATA-001, SIMATA-002, SIMATA-003',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: AppColors.neutral),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
