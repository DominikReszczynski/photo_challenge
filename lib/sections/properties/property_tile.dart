import 'package:cas_house/api_service.dart';
import 'package:cas_house/models/properties.dart';
import 'package:cas_house/providers/properties_provider.dart';
import 'package:cas_house/sections/properties/property_details.dart';
import 'package:flutter/material.dart';

class PropertyTile extends StatefulWidget {
  final PropertiesProvider provider;
  final Property property;
  const PropertyTile(
      {super.key, required this.property, required this.provider});

  @override
  _PropertyTileState createState() => _PropertyTileState();
}

class _PropertyTileState extends State<PropertyTile>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    const String urlPrefix = ApiService.baseUrl;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetails(
                property: widget.property, provider: widget.provider),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Obraz
            SizedBox(
              height: 180,
              width: double.infinity,
              child: Image.network(
                "$urlPrefix/uploads/${widget.property.mainImage}",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),

            // Informacje tekstowe
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.property.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.property.location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.property.rentAmount} PLN / ${widget.property.paymentCycle}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Chip(
                        label: Text(
                          widget.property.status == "wynajęte"
                              ? "Wynajęte"
                              : "Dostępne",
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: widget.property.status == "wynajęte"
                            ? Colors.red
                            : Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
