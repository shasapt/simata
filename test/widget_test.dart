import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simata/main.dart';

void main() {
  testWidgets('Beranda SIMATA tampil dan tombol lacak berfungsi',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SimataApp());

    // Beranda menampilkan nama app (app bar + judul) dan tombol utama.
    expect(find.text('SIMATA'), findsWidgets);
    expect(find.text('Lacak Pengajuan'), findsOneWidget);

    // Tap tombol utama -> pindah ke Tracking Pengajuan.
    await tester.tap(find.text('Lacak Pengajuan'));
    await tester.pumpAndSettle();

    expect(find.text('Tracking Pengajuan'), findsOneWidget);
  });

  testWidgets('Tracking menolak nomor kosong dengan pesan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SimataApp());
    await tester.tap(find.text('Lacak Pengajuan'));
    await tester.pumpAndSettle();

    // Cari tanpa mengisi nomor -> pesan error.
    await tester.tap(find.text('Cari Pengajuan'));
    await tester.pump();

    expect(find.text('Nomor tracking wajib diisi.'), findsOneWidget);
  });

  testWidgets('Nomor tracking valid membuka Detail Status Pengajuan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SimataApp());
    await tester.tap(find.text('Lacak Pengajuan'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'SIMATA-001');
    await tester.tap(find.text('Cari Pengajuan'));
    await tester.pumpAndSettle();

    expect(find.text('Detail Status Pengajuan'), findsOneWidget);
    expect(find.text('SIMATA-001'), findsOneWidget);
  });

  testWidgets('Login petugas membuka halaman Kelola Pengajuan',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SimataApp());

    // Pindah ke tab Petugas lewat navigasi.
    await tester.tap(find.text('Petugas'));
    await tester.pumpAndSettle();
    expect(find.text('Masuk sebagai Petugas'), findsOneWidget);

    // Isi form login (masih simulasi).
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'petugas@simata.test',
    );
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'rahasia123',
    );
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Kelola Pengajuan'), findsOneWidget);
    expect(find.text('SIMATA-001'), findsOneWidget);
  });

  testWidgets('Login petugas menolak email kosong',
      (WidgetTester tester) async {
    await tester.pumpWidget(const SimataApp());
    await tester.tap(find.text('Petugas'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Masuk'));
    await tester.pump();

    expect(find.text('Email wajib diisi.'), findsOneWidget);
    expect(find.text('Kata sandi wajib diisi.'), findsOneWidget);
  });
}
