import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class ProdukPreOrderItem extends StatelessWidget {
  final Produk? produkPreOrder;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  ProdukPreOrderItem({Key? key, required this.produkPreOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              produkPreOrder?.namaProduk ??
                  'No Name', // Providing a default value
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            produkPreOrder?.gambarProduk != null &&
                    produkPreOrder!.gambarProduk!.isNotEmpty
                ? Image.network(
                    produkPreOrder!.gambarProduk!,
                    height: 100, // You can adjust this height as needed
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    height: 100, child: Center(child: Text('No Image'))),
            const SizedBox(height: 8),
            Text('${produkPreOrder?.loyang}'),
            const SizedBox(height: 8),
            Text(
              'Rp. ${numberFormat.format(produkPreOrder?.hargaProduk)}', // Providing a default value
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            (produkPreOrder?.stok ?? 0) > 0
                ? const Text(
                    'Produk ini ada juga yang ready stock!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }
}
