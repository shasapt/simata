# SIMATA

**Sistem Informasi Monitoring Administrasi dan Tracking**

Aplikasi monitoring status pengajuan layanan administrasi. Masyarakat memantau
status dan tahapan pengajuan menggunakan **nomor tracking tanpa login**; petugas
masuk dengan email/password untuk mencatat pengajuan dan memperbarui status
sesuai workflow.

Proyek individu — Mobile and Web Application Development, Semester 7 (Ganjil 2026/2027).
Clarisha Ratna D.R.S / 23.01.55.0006 / Kelas A1.

## Tech stack

- Flutter + Dart (mobile & web)
- Firebase Spark: Authentication (email/password), Cloud Firestore, Hosting
- GitHub (version control), Figma (desain)

## Struktur folder

```
lib/
├── main.dart                  # Entry point + routing
├── core/
│   ├── constants/             # Nama app, workflow status, nama halaman final
│   └── theme/                 # Style guide mini (warna & tema Material 3)
├── models/                    # Model data (Pengajuan)
├── services/                  # Akses data (mock dulu, Firestore menyusul)
├── pages/                     # 6 halaman final sesuai sitemap Minggu 3
│   ├── beranda_page.dart
│   ├── tracking_pengajuan_page.dart
│   ├── detail_status_pengajuan_page.dart
│   ├── login_petugas_page.dart
│   ├── kelola_pengajuan_page.dart
│   └── riwayat_status_page.dart
└── widgets/                   # Widget reusable (StatusBadge)
```

## Alur inti

Beranda → Tracking Pengajuan → Detail Status Pengajuan

Keadaan alternatif:
- Nomor tracking kosong → "Nomor tracking wajib diisi."
- Nomor tracking tidak ditemukan → "Data pengajuan tidak ditemukan."

## Menjalankan

```bash
flutter pub get
flutter run            # pilih device (Chrome / emulator Android)
flutter analyze
flutter test
```

Nomor tracking contoh (data simulasi): `SIMATA-001`, `SIMATA-002`, `SIMATA-003`.
