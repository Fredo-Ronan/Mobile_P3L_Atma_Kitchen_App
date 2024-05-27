// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/presensi_karyawan_client.dart';
import 'package:mobile_app_atma_kitchen/entity/presensi_karyawan.dart';
import 'package:mobile_app_atma_kitchen/view/mo/home_mo.dart';

class DetilPresensi extends StatefulWidget {
  final Presensi presensi;

  const DetilPresensi({super.key, required this.presensi});

  @override
  State<DetilPresensi> createState() => _DetilPresensiState();
}

class _DetilPresensiState extends State<DetilPresensi> {
  
  bool isLoading = false;
  TextEditingController presensiController = TextEditingController();

  final List<String> listKehadiran = [
    'Hadir',
    'Tidak Hadir',
  ];
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  Future<void> editPresensi(int idpresensi) async {
    setState(() {
      isLoading = true;
    });
    try {
      await PresensiKaryawanClient.update(
          presensiController.text, idpresensi.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Berhasil Edit Presensi Karyawan'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal Edit Presensi Karyawan'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          width: 415,
          height: 75,
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(12, 57, 235, 0.91),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainMOView(selectedIndex: 1),
                    ));
                  },
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 40),
                child: Text(
                  'Edit Presensi Karyawan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                width: 370,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 201, 199, 195),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Nama Karyawan: ${widget.presensi.namaKaryawan}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                margin: EdgeInsets.only(top: 20),
                width: 370,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 201, 199, 195),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'Tanggal Presensi: ${widget.presensi.tanggalPresensi}',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: DropdownMenu<String>(
                  menuHeight: 200,
                  key: const ValueKey('dropdown_presensi_karyawan'),
                  controller: presensiController,
                  initialSelection: widget.presensi != null
                      ? widget.presensi!.statusPresensi
                      : listKehadiran.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  dropdownMenuEntries: listKehadiran
                      .map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  editPresensi(widget.presensi.idPresensi!);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Edit Presensi',
                        style: TextStyle(fontSize: 20),
                      ),
              ),
            ],
          ),
        ),
      ],
    )));
  }
}
