// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_app_atma_kitchen/entity/karyawan.dart';
import 'package:mobile_app_atma_kitchen/view/mo/home/home_mo.dart';
import 'package:mobile_app_atma_kitchen/view/mo/presensiKaryawan/presensi.dart';

class MainMOView extends StatefulWidget {
  const MainMOView({super.key, required this.selectedIndex});

  final int? selectedIndex;

  @override
  State<MainMOView> createState() => _MainMOViewState();
}

class _MainMOViewState extends State<MainMOView> {
  Karyawan? dataKaryawan;
  bool isLoading = false;
  bool isLoadingButton = false;
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MOView(),
    PresensiView(),
  ];

  void _onItemTapped(int index) {
    //* setState berkaitan dengan fungsi untuk menampilkan perubahan kondisi & dalam banyak kasus akan menggunakan ini\
    setState(() {
      _selectedIndex = index;
    });
  }

  void setSelectedIndex(int index) {
    _selectedIndex = index;
  }

  @override
  void initState() {
    super.initState();
    setSelectedIndex(widget.selectedIndex!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 85,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 211, 211, 211),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 23,
            items: const [
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    key: ValueKey('bottom_navbar_home'),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: FaIcon(
                    FontAwesomeIcons.calendarCheck,
                    key: ValueKey('bottom_navbar_daftar_periksa'),
                  ),
                  label: 'Presensi'),
              // BottomNavigationBarItem(
              //     icon: FaIcon(
              //       FontAwesomeIcons.bluetooth,
              //       key: Key('bottom_navbar_daftar_kamar'),
              //     ),
              //     label: 'Nganu'),
              // BottomNavigationBarItem(
              //     icon: FaIcon(
              //       FontAwesomeIcons.car,
              //       key: Key('bottom_navbar_profile'),
              //     ),
              //     label: 'Mobil'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
