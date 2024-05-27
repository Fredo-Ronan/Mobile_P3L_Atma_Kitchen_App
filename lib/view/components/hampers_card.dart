import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers.dart';

class HampersItem extends StatelessWidget {
  final Hampers? hampers;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('id');
  HampersItem({Key? key, required this.hampers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hampers?.namaHampers ?? 'No Name', // Providing a default value
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.85,
                ),
                itemCount: hampers?.listProduk?.length ?? 0,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(hampers!.listProduk![index].gambarProduk ??
                          'No Image'),
                      Text(hampers!.listProduk![index].namaProduk ?? ''),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hampers?.deskripsiHampers!.split("+")[0] ??
                  'No Description', // Providing a default value
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Rp. ${numberFormat.format(hampers?.hargaHampers)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
