import 'package:cas_house/providers/defects_provider.dart';
import 'package:cas_house/providers/properties_provider.dart';
import 'package:cas_house/sections/properties/add_new_property.dart';
import 'package:cas_house/sections/properties/property_tile.dart';
import 'package:cas_house/widgets/animated_background.dart';
import 'package:cas_house/widgets/loading.dart';
import 'package:cas_house/widgets/togglebutton_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ShoppingMain extends StatefulWidget {
  const ShoppingMain({super.key});

  @override
  _ShoppingMainState createState() => _ShoppingMainState();
}

class _ShoppingMainState extends State<ShoppingMain> {
  bool isLoading = false;
  bool showRentals = false;
  late PropertiesProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PropertiesProvider>(context, listen: false);
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    setState(() => isLoading = true);
    await provider.getAllPropertiesByOwner();
    setState(() => isLoading = false);
  }

  Future<void> _loadRentals() async {
    setState(() => isLoading = true);
    await provider.getAllPropertiesByTenant();
    setState(() => isLoading = false);
  }

  void _onToggle(bool rentalsSelected) {
    if (showRentals == rentalsSelected) return;
    setState(() => showRentals = rentalsSelected);
    if (rentalsSelected) {
      _loadRentals();
    } else {
      _loadProperties();
    }
  }

  @override
  Widget build(BuildContext context) {
    final propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: true);

    return AnimatedBackground(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: PremisesRentalsToggle(
                      isRentals: showRentals,
                      onToggle: _onToggle,
                      firstText: 'In progress',
                      secondText: 'Solved',
                    ),
                  ),
                  IconButton(
                    icon: Icon(MdiIcons.plus),
                    tooltip: 'Add defect',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AddNewProperty(propertiesProvider: provider),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: LoadingWidget())
                  : _buildSeparatedList(showRentals, propertiesProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparatedList(
      bool rentals, PropertiesProvider propertiesProvider) {
    final list = rentals
        ? propertiesProvider.propertiesListTenant
        : propertiesProvider.propertiesListOwner;

    if (list.isEmpty) {
      return const Center(child: Text('No defects found.'));
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(),
      itemBuilder: (context, index) {
        final item = list[index]!;
        return PropertyTile(provider: provider, property: item);
      },
    );
  }
}
