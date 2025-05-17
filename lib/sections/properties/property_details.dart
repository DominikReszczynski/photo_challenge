import 'dart:io';

import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/properties.dart';
import 'package:cas_house/providers/properties_provider.dart';
import 'package:cas_house/sections/properties/add_tenant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetails extends StatefulWidget {
  final Property property;
  final PropertiesProvider provider;
  const PropertyDetails(
      {super.key, required this.property, required this.provider});

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class PropertyProvider {}

class _PropertyDetailsState extends State<PropertyDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const String urlPrefix = ApiService.baseUrl;

  Future<void> openMapWithAddress(String address) async {
    final encodedAddress = Uri.encodeComponent(address);

    final url = Platform.isIOS
        ? 'http://maps.apple.com/?q=$encodedAddress'
        : 'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    final uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nie można otworzyć aplikacji map.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.network(
                "$urlPrefix/uploads/${widget.property.mainImage}",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40,
                left: 16,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          openMapWithAddress(widget.property.location),
                      icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.map, color: Colors.black)),
                    ),
                    widget.property.status == "wynajęte"
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Contact ${widget.property.ownerId != loggedUser!.id ? "Owner" : "Tenant"}"),
                                    content: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "Would you like to contact the owner of this property?"),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Ok"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person, color: Colors.black)),
                          )
                        : IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTenant(
                                      propertyID: widget.property.id!,
                                      propertyPin: widget.property.pin),
                                ),
                              );
                            },
                            icon: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person_add,
                                    color: Colors.black)),
                          ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(text: "Home"),
              Tab(text: "Nameless1"),
              Tab(text: "Nameless2"),
              // if (widget.property.status == "wynajęte") Tab(text: "Najemca"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMenuTab(),
                const Center(child: Text("No promotions available")),
                const Center(child: Text("No reviews yet")),
                // if (widget.property.status == "wynajęte")
                //   Center(child: Text("No reviews yet")),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(widget.property.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          _buildDetailItem("Lokalizacja", widget.property.location),
          _buildDetailItem("Powierzchnia", "${widget.property.size} m²"),
          _buildDetailItem("Pokoje", "${widget.property.rooms}"),
          _buildDetailItem("Piętro", "${widget.property.floor}"),
          _buildDetailItem("Status", widget.property.status),
          if (widget.property.status == "wynajęte")
            _buildDetailItem("Okres najmu",
                "${formatDate(widget.property.rentalStart!)} - ${formatDate(widget.property.rentalEnd!)}"),
          _buildDetailItem(
              "Czynsz", "${widget.property.rentAmount.toStringAsFixed(2)} zł"),
          _buildDetailItem("Kaucja",
              "${widget.property.depositAmount.toStringAsFixed(2)} zł"),
          _buildDetailItem("Cykl płatności", widget.property.paymentCycle),
          if (widget.property.features != null &&
              widget.property.features!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                const Text("Dodatkowe cechy:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                for (var feature in widget.property.features!)
                  Text(feature, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          if (widget.property.notes != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: _buildDetailItem("Notatki", widget.property.notes!),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Skopiowano do schowka")),
                      );
                    },
                    child: Text(value)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
