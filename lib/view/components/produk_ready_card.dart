import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_atma_kitchen/entity/produk.dart';

class ProdukReadyItem extends StatelessWidget {
  final Produk? produkReady;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  ProdukReadyItem({Key? key, required this.produkReady}) : super(key: key);

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
              produkReady?.namaProduk ?? 'No Name', // Providing a default value
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            produkReady?.gambarProduk != null &&
                    produkReady!.gambarProduk!.isNotEmpty
                ? Image.network(
                    produkReady!.gambarProduk!,
                    height: 100, // You can adjust this height as needed
                    fit: BoxFit.cover,
                  )
                : const SizedBox(
                    height: 100, child: Center(child: Text('No Image'))),
            const SizedBox(height: 8),
            Text(
              'Rp. ${numberFormat.format(produkReady?.hargaProduk)}', // Providing a default value
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Sisa ${produkReady?.stok.toString()}',
              style: TextStyle(
                color:
                    (produkReady?.stok ?? 0) < 10 ? Colors.red : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
