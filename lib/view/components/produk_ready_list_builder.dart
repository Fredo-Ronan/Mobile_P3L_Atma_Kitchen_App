import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';
import 'package:mobile_app_atma_kitchen/view/components/produk_ready_card.dart';

class ProdukReadyListBuilder extends StatelessWidget {
  final List<Produk>? listProdukReady;
  const ProdukReadyListBuilder({Key? key, this.listProdukReady})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listProdukReady == null || listProdukReady!.isEmpty) {
      return const Center(
        child: Text('Produk Ready Stock Kosong'),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemCount: listProdukReady?.length ?? 0,
      itemBuilder: (context, index) {
        return ProdukReadyItem(produkReady: listProdukReady![index]);
      },
    );
  }
}
