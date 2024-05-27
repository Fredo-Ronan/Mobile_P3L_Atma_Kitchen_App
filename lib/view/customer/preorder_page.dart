import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/database/produk/produk_pre_order_client.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';
import 'package:mobile_app_atma_kitchen/view/components/produk_preorder_list_builder.dart';

class PreOrderPage extends StatefulWidget {
  const PreOrderPage({super.key});

  @override
  State<PreOrderPage> createState() => _PreOrderPageState();
}

class _PreOrderPageState extends State<PreOrderPage> {
  List<Produk>? listProdukPreOrder;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProdukPreOrder();
  }

  void getProdukPreOrder() async {
    try {
      List<Produk> dataProdukPreOrder =
          await ProdukPreOrderClient.getProdukPreOrder();

      setState(() {
        listProdukPreOrder = dataProdukPreOrder;
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
        title: const Text('Produk Pre Order'),
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
                    "Pre Order",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Expanded(
                  child: ProdukPreOrderListBuilder(
                      listProdukPreOrder: listProdukPreOrder),
                ),
              ],
            ),
    );
  }
}
