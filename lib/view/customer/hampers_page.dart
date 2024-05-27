import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/hampers/hampers_client.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers.dart';
import 'package:mobile_app_atma_kitchen/view/components/hampers_list_builder.dart';

class HampersPage extends StatefulWidget {
  const HampersPage({super.key});

  @override
  State<HampersPage> createState() => _HampersPageState();
}

class _HampersPageState extends State<HampersPage> {
  List<Hampers>? listHampers;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getDataHampers();
  }

  void getDataHampers() async {
    try {
      List<Hampers> dataHampers = await HampersClient.getHampers();
      setState(() {
        listHampers = dataHampers;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors if needed
      // print('Failed to fetch hampers: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hampers Page'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Hampers",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: HampersListBuilder(listHampers: listHampers),
                ),
              ],
            ),
    );
  }
}
