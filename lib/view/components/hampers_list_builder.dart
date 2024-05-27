import 'package:flutter/material.dart';
import 'package:mobile_app_atma_kitchen/entity/hampers.dart';
import 'package:mobile_app_atma_kitchen/view/components/hampers_card.dart';

class HampersListBuilder extends StatelessWidget {
  final List<Hampers>? listHampers;

  const HampersListBuilder({Key? key, this.listHampers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listHampers == null || listHampers!.isEmpty) {
      return const Center(child: Text('No hampers available'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.45,
      ),
      itemCount: listHampers?.length ?? 0,
      itemBuilder: (context, index) {
        return HampersItem(hampers: listHampers![index]);
      },
    );
  }
}
