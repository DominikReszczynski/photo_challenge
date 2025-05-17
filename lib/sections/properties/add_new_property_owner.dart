import 'dart:io';

import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/properties.dart';
import 'package:cas_house/sections/dashboard/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cas_house/providers/properties_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewPropertyOwner extends StatefulWidget {
  const AddNewPropertyOwner(
      {super.key, required PropertiesProvider propertiesProvider});

  @override
  State<AddNewPropertyOwner> createState() => _AddNewPropertyOwnerState();
}

class _AddNewPropertyOwnerState extends State<AddNewPropertyOwner> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _rentAmountController = TextEditingController();
  final TextEditingController _depositAmountController =
      TextEditingController();
  final TextEditingController _paymentCycleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  late File? _imageFile;

  String _status = 'wolne';
  DateTime? _rentalStart;
  DateTime? _rentalEnd;

  List<String> _features = [];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final prefs = await SharedPreferences.getInstance();
      final storedUserId = prefs.getString('userId');
      final property = Property(
        ownerId: storedUserId!,
        name: _nameController.text.trim(),
        location: _locationController.text.trim(),
        size: double.parse(_sizeController.text.trim()),
        rooms: int.parse(_roomsController.text.trim()),
        floor: int.parse(_floorController.text.trim()),
        features: _features,
        status: _status,
        rentAmount: double.parse(_rentAmountController.text.trim()),
        depositAmount: double.parse(_depositAmountController.text.trim()),
        paymentCycle: _paymentCycleController.text.trim(),
        rentalStart: _rentalStart?.toIso8601String(),
        rentalEnd: _rentalEnd?.toIso8601String(),
      );

      Provider.of<PropertiesProvider>(context, listen: false)
          .addProperty(property, _imageFile)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mieszkanie zostało dodane.')),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _rentalStart = picked;
        } else {
          _rentalEnd = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SingleImageUploader(
              onImageSelected: (File file) {
                setState(() {
                  _imageFile = file;
                });
              },
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nazwa mieszkania'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Wymagana nazwa' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Lokalizacja'),
              validator: (value) => value == null || value.isEmpty
                  ? 'Wymagana lokalizacja'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _sizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Powierzchnia (m²)'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _roomsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Liczba pokoi'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _floorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Piętro'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _status,
              items: ['wolne', 'wynajęte']
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _rentAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Kwota czynszu'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _depositAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Kwota kaucji'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _paymentCycleController,
              decoration: const InputDecoration(
                  labelText: 'Cykl płatności (np. miesięczny)'),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Start najmu: ${_rentalStart != null ? DateFormat('yyyy-MM-dd').format(_rentalStart!) : 'Nie wybrano'}'),
                TextButton(
                  onPressed: () => _pickDate(context, true),
                  child: const Text('Wybierz'),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Koniec najmu: ${_rentalEnd != null ? DateFormat('yyyy-MM-dd').format(_rentalEnd!) : 'Nie wybrano'}'),
                TextButton(
                  onPressed: () => _pickDate(context, false),
                  child: const Text('Wybierz'),
                )
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notatki'),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('DODAJ MIESZKANIE'),
            ),
          ],
        ),
      ),
    );
  }
}
