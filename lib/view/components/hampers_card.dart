import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers.dart';

class HampersItem extends StatelessWidget {
  final Hampers? hampers;
  const HampersItem({Key? key, required this.hampers}) : super(key: key);

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
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: hampers?.listProduk?.length ?? 0,
                itemBuilder: (context, index) {
                  return Image.network(
                      hampers!.listProduk![index].gambarProduk ?? 'No Image');
                },
              ),
            ),
            Text(
              hampers?.deskripsiHampers!.split("+")[0] ??
                  'No Description', // Providing a default value
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Rp. ${hampers?.hargaHampers}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
