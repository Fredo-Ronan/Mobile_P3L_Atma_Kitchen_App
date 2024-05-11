// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/presensi_karyawan_client.dart';
import 'package:mobile_app_atma_kitchen/entity/presensi_karyawan.dart';
import 'package:mobile_app_atma_kitchen/view/mo/presensiKaryawan/detil_presensi.dart';

class PresensiView extends StatefulWidget {
  const PresensiView({super.key});

  @override
  State<PresensiView> createState() => _PresensiViewState();
}

class _PresensiViewState extends State<PresensiView> {
  List<Presensi> listPresensi = [];
  bool isLoading = false;
  bool isLoadingButton = false;

  void presensi() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<Presensi> fetchedData = await PresensiKaryawanClient.fetchAll();

      setState(() {
        listPresensi = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Gagal Mengambil Data Karyawan!'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    presensi();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
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
              child: Center(
                child: Text(
                  'Presensi Karyawan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? buildLoading()
                  : ListView.builder(
                      itemCount: listPresensi.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 100,
                          height: 80,
                          margin: EdgeInsets.only(
                              top: 5, bottom: 10, right: 5, left: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 100, 147, 255)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => DetilPresensi(
                                    presensi: listPresensi[index]),
                              ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 280,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 15),
                                        child: Text(
                                          'Nama Karyawan: ${listPresensi[index].namaKaryawan} ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 7, left: 15),
                                        child: Text(
                                          'Status Presensi: ${listPresensi[index].statusPresensi}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                    '${listPresensi[index].tanggalPresensi}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
