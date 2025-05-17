import 'package:cas_house/providers/properties_provider.dart';
import 'package:cas_house/sections/properties/add_new_property_owner.dart';
import 'package:cas_house/sections/properties/add_new_property_tenant.dart';
import 'package:flutter/material.dart';

class AddNewProperty extends StatefulWidget {
  final PropertiesProvider propertiesProvider;
  const AddNewProperty({super.key, required this.propertiesProvider});

  @override
  State<AddNewProperty> createState() => _AddNewPropertyState();
}

class _AddNewPropertyState extends State<AddNewProperty>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dodaj mieszkanie')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: const [
              Tab(text: "Tenant"),
              Tab(text: "Owner"),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AddNewPropertyTenant(
                    propertiesProvider: widget.propertiesProvider),
                AddNewPropertyOwner(
                    propertiesProvider: widget.propertiesProvider),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
