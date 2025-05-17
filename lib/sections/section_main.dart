// import 'package:cas_house/main_global.dart';
// import 'package:cas_house/sections/dashboard/dashboard_main.dart';
// import 'package:cas_house/sections/family/family_main.dart';
// import 'package:cas_house/sections/home/home_main.dart';
// import 'package:cas_house/sections/shopping/shopping_main.dart';
// import 'package:cas_house/sections/user/user_main.dart';
// import 'package:flutter/material.dart';

// class SectionMain extends StatefulWidget {
//   final Sections chosenSection;
//   const SectionMain({super.key, required this.chosenSection});

//   @override
//   State<SectionMain> createState() => _SectionMainState();
// }

// class _SectionMainState extends State<SectionMain> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: SizedBox(
//           width: double.maxFinite,
//           child: _buildSectionContent(widget.chosenSection)),
//     );
//   }
// }

// Widget _buildSectionContent(Sections section) {
//   switch (section) {
//     case Sections.Home:
//       return const Center(child: HomeSectionMain());
//     case Sections.Dashboard:
//       return const Center(child: DashboardSectionMain());
//     case Sections.User:
//       return const Center(child: UserSectionMain());
//     case Sections.Shopping:
//       return const Center(child: ShoppingMain());
//     case Sections.Family:
//       return const Center(child: FamilyMain());
//     default:
//       return const Center(
//         child: Text(
//           "Unknown Section",
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       );
//   }
// }
