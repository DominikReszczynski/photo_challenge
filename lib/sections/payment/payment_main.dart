import 'package:cas_house/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentMain extends StatefulWidget {
  const PaymentMain({super.key});

  @override
  PaymentMainState createState() => PaymentMainState();
}

class PaymentMainState extends State<PaymentMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment List"),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: Icon(MdiIcons.plus),
            iconSize: 30,
          ),
        ],
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, provider, child) {
          // final shoppingList = provider.shoppingList;

          // return ListView.builder(
          //   itemCount: shoppingList.length,
          //   itemBuilder: (context, index) {
          //     return PrductTile(
          //       product: shoppingList[index],
          //       updateIsBuy: () {
          //         provider.toggleIsBuy(index);
          //       },
          //     );
          //   },
          // );
          return const Text('placeholder');
        },
      ),
    );
  }
}
