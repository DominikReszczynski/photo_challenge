import 'package:cas_house/providers/user_provider.dart';
import 'package:cas_house/sections/login.dart';
import 'package:cas_house/sections/user/user_section_header.dart';
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
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return ListView(
        children: [
          const UserSectionHeader(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Wyloguj się'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                userProvider.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
