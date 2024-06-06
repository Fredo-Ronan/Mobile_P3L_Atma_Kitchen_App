import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_atma_kitchen/database/laporan_stok_bahan_client.dart';
import 'package:mobile_app_atma_kitchen/entity/laporan_stok_bahan.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class LaporanStokBahanMO extends StatefulWidget {
  const LaporanStokBahanMO({super.key});

  @override
  State<LaporanStokBahanMO> createState() => _LaporanStokBahanMOState();
}

class _LaporanStokBahanMOState extends State<LaporanStokBahanMO> {
  bool _isLoading = true;
  List<LaporanStokBahan>? listStokBahan;

  void getStokBahan() async {
    try {
      List<LaporanStokBahan> dataLaporanStokBahan =
          await LaporanStokBahanClient.fetchLaporanStok();

      setState(() {
        listStokBahan = dataLaporanStokBahan;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getStokBahan();
  }

  Future<void> generatePdf() async {
    if (await _requestPermission(Permission.storage)) {
      final pdf = pw.Document();
      final page = pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Atma Kitchen\nJl. Centralpark No. 10 Yogyakarta\n\n"
                  "Laporan Stok Bahan Baku\nTanggal Cetak : ${DateFormat('d MMMM yyyy').format(DateTime.now())}\n\n",
                  style: const pw.TextStyle(fontSize: 16),
                ),
                pw.Table(
                  border: pw.TableBorder.all(),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Text("Nama Bahan", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text("Satuan", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text("Stok", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    ...listStokBahan!.map(
                      (bahan) => pw.TableRow(
                        children: [
                          pw.Text(bahan.namaBahan ?? ''),
                          pw.Text(bahan.satuan ?? ''),
                          pw.Text(bahan.stok?.toString() ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ));

      final directory = Directory('/storage/emulated/0/Download');
      final filePath = path.join(directory.path, 'laporan_stok_bahan_${DateFormat('d MMMM yyyy').format(DateTime.now())}.pdf');
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('PDF saved at $filePath'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission denied'),
      ));
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('d MMMM yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan Stok Bahan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: generatePdf,
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : listStokBahan == null || listStokBahan!.isEmpty
              ? const Center(child: Text('No data available'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Atma Kitchen',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text('Jl. Centralpark No. 10 Yogyakarta',
                              style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 20),
                          const Text('Laporan Stok Bahan Baku',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Tanggal Cetak : $currentDate',
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Nama Bahan')),
                              DataColumn(label: Text('Satuan')),
                              DataColumn(label: Text('Stok')),
                            ],
                            rows: listStokBahan!
                                .map(
                                  (bahan) => DataRow(
                                    cells: [
                                      DataCell(Text(bahan.namaBahan ?? '')),
                                      DataCell(Text(bahan.satuan ?? '')),
                                      DataCell(
                                          Text(bahan.stok?.toString() ?? '')),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
