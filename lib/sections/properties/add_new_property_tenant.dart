import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cas_house/providers/properties_provider.dart';

class AddNewPropertyTenant extends StatefulWidget {
  const AddNewPropertyTenant(
      {super.key, required PropertiesProvider propertiesProvider});

  @override
  State<AddNewPropertyTenant> createState() => _AddNewPropertyTenantState();
}

class _AddNewPropertyTenantState extends State<AddNewPropertyTenant> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _propertyID = TextEditingController();
  final TextEditingController _ownerPin = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Provider.of<PropertiesProvider>(context, listen: false)
          .addTenantToProperty(_propertyID.text, _ownerPin.text)
          .then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mieszkanie zostało dodane.')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Wystąpił błąd!')),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _propertyID,
            decoration: const InputDecoration(labelText: 'ID mieszkania'),
            validator: (value) => value == null || value.isEmpty
                ? 'Wymagane ID mieszkania'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _ownerPin,
            decoration: const InputDecoration(labelText: 'PIN właściciela'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Wymagany PIN' : null,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('DODAJ MIESZKANIE'),
          ),
        ],
      ),
    );
  }
}
