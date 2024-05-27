import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';
import 'package:mobile_app_atma_kitchen/view/components/produk_preorder_card.dart';

class ProdukPreOrderListBuilder extends StatelessWidget {
  final List<Produk>? listProdukPreOrder;
  const ProdukPreOrderListBuilder({Key? key, this.listProdukPreOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listProdukPreOrder == null || listProdukPreOrder!.isEmpty) {
      return const Center(
        child: Text('Produk Pre Order Kosong'),
      );
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.7,
      ),
      itemCount: listProdukPreOrder?.length ?? 0,
      itemBuilder: (context, index) {
        return ProdukPreOrderItem(produkPreOrder: listProdukPreOrder![index]);
      },
    );
  }
}
