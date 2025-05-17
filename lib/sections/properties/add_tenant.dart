import 'package:cas_house/providers/properties_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AddTenant extends StatefulWidget {
  final String propertyID;
  final String? propertyPin;

  const AddTenant({
    super.key,
    required this.propertyID,
    this.propertyPin,
  });

  @override
  State<AddTenant> createState() => _AddTenantState();
}

class _AddTenantState extends State<AddTenant> {
  String _pin = "";

  void _onSubmit(PropertiesProvider provider) {
    if (_pin.length == 5) {
      provider.setPin(widget.propertyID, _pin).then((success) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("PIN ustawiony pomyślnie!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => AddTenant(
                propertyID: widget.propertyID,
                propertyPin: _pin,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Błąd podczas ustawiania PINu.")),
          );
        }
      });
    }
  }

  void _deletePin(PropertiesProvider provider) async {
    final success = await provider.deletePin(widget.propertyID);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PIN usunięty pomyślnie!")),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AddTenant(
            propertyID: widget.propertyID,
            propertyPin: null,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nie udało się usunąć PINu.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PropertiesProvider>(
      builder: (context, provider, child) {
        return widget.propertyPin == null
            ? _buildPinEntryView(provider)
            : _buildPinSummaryView(provider);
      },
    );
  }

  Widget _buildPinEntryView(PropertiesProvider provider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ustaw PIN"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Divider(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Wprowadź 5-cyfrowy PIN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 5,
                obscureText: false,
                animationType: AnimationType.fade,
                autoFocus: true,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.grey.shade100,
                  inactiveFillColor: Colors.grey.shade100,
                  activeColor: Colors.blue,
                  selectedColor: Colors.blueAccent,
                  inactiveColor: Colors.grey,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                onChanged: (value) {
                  setState(() {
                    _pin = value;
                  });
                },
                onCompleted: (_) => _onSubmit(provider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinSummaryView(PropertiesProvider provider) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PIN ustawiony"),
        actions: [
          IconButton(
            onPressed: () => _deletePin(provider),
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: 'Usuń PIN',
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: Divider(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "ID nieruchomości:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: widget.propertyID));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("ID skopiowane do schowka!")),
                      );
                    },
                    child: Text(
                      widget.propertyID,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "PIN:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Text(
                widget.propertyPin!,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
