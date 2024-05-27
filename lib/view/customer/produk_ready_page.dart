import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/produk/produk_ready_client.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';
import 'package:mobile_app_atma_kitchen/view/components/produk_ready_list_builder.dart';

class ProdukReadyPage extends StatefulWidget {
  const ProdukReadyPage({super.key});

  @override
  State<ProdukReadyPage> createState() => _ProdukReadyPageState();
}

class _ProdukReadyPageState extends State<ProdukReadyPage> {
  List<Produk>? listProdukReady;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProdukReady();
  }

  void getProdukReady() async {
    try {
      List<Produk> dataProdukReady = await ProdukReadyClient.getProdukReady();

      setState(() {
        listProdukReady = dataProdukReady;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk Ready Stock'),
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
                    "Produk Ready Stock",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Expanded(
                  child:
                      ProdukReadyListBuilder(listProdukReady: listProdukReady),
                ),
              ],
            ),
    );
  }
}
