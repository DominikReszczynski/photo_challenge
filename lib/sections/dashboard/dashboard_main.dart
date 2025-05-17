import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:cas_house/providers/dasboard_provider.dart';
import 'package:cas_house/sections/dashboard/image_picker.dart';
import 'package:cas_house/sections/dashboard/images_list.dart';
import 'package:cas_house/sections/dashboard/multi_image_picker.dart';

class HomeSectionMain extends StatefulWidget {
  const HomeSectionMain({super.key});
  @override
  State<HomeSectionMain> createState() => _HomeSectionMainState();
}

class _HomeSectionMainState extends State<HomeSectionMain>
    with SingleTickerProviderStateMixin {
  late DashboardProvider dashboardProvider;

  @override
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView.separated(
            itemCount: _buildChildren().length,
            itemBuilder: (context, index) => _buildChildren()[index],
            separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }

  /// Zwraca listę głównych widżetów ekranu
  List<Widget> _buildChildren() {
    return [
      // Logo
      Center(
        child: Image.asset(
          'assets/images/livo_logo.webp',
          height: 50,
        ),
      ),

      // Powitanie
      const Padding(
        padding: EdgeInsets.only(top: 10),
        child: AutoSizeText(
          "Hi, Dominik",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
      ),

      // MultiImagePicker
      const MultiImagePickerExample(),

      // SingleImageUploader
      SingleImageUploader(
        onImageSelected: (File file) {/* … */},
      ),

      // Lista zdalnych obrazków
      const RemoteImageList(
        filenames: [
          '42d068d4-6994-4bd1-881a-c18cdb7eb33e.jpg',
          '1743413813108.jpg',
        ],
      ),
    ];
  }
}
