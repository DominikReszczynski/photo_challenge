import 'package:cas_house/models/product_model.dart';

import 'package:flutter/material.dart';

class AddProductPopUp extends StatefulWidget {
  final Function(ProductModel) addProductFun;
  const AddProductPopUp({super.key, required this.addProductFun});

  @override
  State<AddProductPopUp> createState() => _AddProductPopUpState();
}

class _AddProductPopUpState extends State<AddProductPopUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _producerController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Bezpieczne parsowanie double
  double parseSafeDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _producerController.dispose();
    _shopController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Add Item to Shopping List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Nazwa przedmiotu
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Producent
            TextField(
              controller: _producerController,
              decoration: const InputDecoration(
                labelText: "Producer",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Sklep
            TextField(
              controller: _shopController,
              decoration: const InputDecoration(
                labelText: "Shop",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),
            // Przycisk dodawania
            ElevatedButton(
              onPressed: () {},
              child: const Text("Add Item"),
            ),
          ],
        ),
      ),
    );
  }
}
