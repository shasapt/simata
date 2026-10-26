/// H5 — Kelola Pengajuan (Should / jalur petugas).
/// Daftar pengajuan; tambah data; ubah status sesuai workflow.
/// Contoh status simulasi: Diajukan -> Diverifikasi -> Diproses -> Selesai.
///
/// TODO (Minggu 8+): CRUD Firestore + pencegahan perpindahan
/// status yang tidak sesuai alur workflow.
library;

import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../models/pengajuan.dart';
import '../services/pengajuan_service.dart';
import '../widgets/status_badge.dart';

class KelolaPengajuanPage extends StatelessWidget {
  const KelolaPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PengajuanService service = const PengajuanService();

    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.pageKelolaPengajuan)),
      body: FutureBuilder<List<Pengajuan>>(
        future: service.daftarPengajuan(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Pengajuan>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final List<Pengajuan> daftar = snapshot.data ?? <Pengajuan>[];
          if (daftar.isEmpty) {
            return const Center(
              child: Text('Belum ada pengajuan.'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: daftar.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final Pengajuan p = daftar[index];
              return Card(
                child: ListTile(
                  title: Text(p.nomorTracking),
                  subtitle: Text(p.jenisLayanan),
                  trailing: StatusBadge(status: p.status),
                  onTap: () {
                    // TODO: buka detail/ubah status sesuai workflow.
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: form tambah pengajuan + generate nomor tracking.
        },
        label: const Text('Tambah Pengajuan'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
