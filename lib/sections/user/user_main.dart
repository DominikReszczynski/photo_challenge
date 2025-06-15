import 'package:cas_house/providers/user_provider.dart';
import 'package:cas_house/sections/login.dart';
import 'package:cas_house/sections/user/user_section_header.dart';
import 'package:cas_house/sections/user_images/user_images_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSectionMain extends StatefulWidget {
  const UserSectionMain({super.key});

  @override
  State<UserSectionMain> createState() => _UserSectionMainState();
}

class _UserSectionMainState extends State<UserSectionMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserProvider>(builder: (context, userProvider, child) {
        return Column(
          children: [
            UserSectionHeader(
              onLogout: () {
                userProvider.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "📸 Galeria Twoich zdjęć",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF926C20),
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(child: UserImagesMain())
          ],
        );
      }),
    );
  }
}
