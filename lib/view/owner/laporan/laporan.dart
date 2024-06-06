import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/view/mo/laporan/stokBahan/laporan_stok_bahan.dart';

class LaporanMO extends StatefulWidget {
  const LaporanMO({super.key});

  @override
  State<LaporanMO> createState() => _LaporanMOState();
}

class _LaporanMOState extends State<LaporanMO> {
  final List<String> laporanTitles = [
    "Laporan Penjualan Bulanan",
    "Laporan per produk",
    "Laporan stok bahan baku",
    "Laporan Penggunaan Bahan Baku",
    "Laporan Presensi dan Gaji",
    "Laporan Pemasukan dan Pengeluaran",
    "Laporan Transaksi Penitip"
  ];

  void navigateToLaporanPage(BuildContext context, String title) {
    switch (title) {
      case "Laporan stok bahan baku":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LaporanStokBahanMO()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: ListView.builder(
        itemCount: laporanTitles.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(laporanTitles[index]),
              onTap: () => navigateToLaporanPage(context, laporanTitles[index]),
            ),
          );
        },
      ),
    );
  }
}
