/// Kerangka navigasi utama SIMATA.
///
/// Mobile (< 600 px): bottom navigation Beranda · Tracking · Petugas.
/// Web/layar lebar (>= 600 px): navigation rail di sisi kiri dengan
/// urutan menu yang sama (sesuai modul Minggu 3 & 4).
library;

import 'package:flutter/material.dart';

import '../pages/beranda_page.dart';
import '../pages/login_petugas_page.dart';
import '../pages/tracking_pengajuan_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  void _pindahTab(int index) {
    setState(() => _index = index);
  }

  static const List<NavigationDestination> _tujuan = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
      label: 'Tracking',
    ),
    NavigationDestination(
      icon: Icon(Icons.badge_outlined),
      selectedIcon: Icon(Icons.badge),
      label: 'Petugas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bool layarLebar = MediaQuery.sizeOf(context).width >= 600;

    final List<Widget> halaman = [
      BerandaPage(
        onLacak: () => _pindahTab(1),
        onPetugas: () => _pindahTab(2),
      ),
      const TrackingPengajuanPage(),
      const LoginPetugasPage(),
    ];

    final Widget isi = IndexedStack(index: _index, children: halaman);

    if (layarLebar) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              onDestinationSelected: _pindahTab,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text('Beranda'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.search_outlined),
                  selectedIcon: Icon(Icons.search),
                  label: Text('Tracking'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.badge_outlined),
                  selectedIcon: Icon(Icons.badge),
                  label: Text('Petugas'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: isi),
          ],
        ),
      );
    }

    return Scaffold(
      body: isi,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _pindahTab,
        destinations: _tujuan,
      ),
    );
  }
}
