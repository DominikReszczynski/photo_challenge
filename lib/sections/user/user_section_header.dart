import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/main_global.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserSectionHeader extends StatefulWidget {
  const UserSectionHeader({super.key});

  @override
  State<UserSectionHeader> createState() => _UserSectionHeaderState();
}

class _UserSectionHeaderState extends State<UserSectionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.transparent, border: Border(bottom: BorderSide())),
      child: Column(
        children: [
          ValueListenableBuilder<ThemeMode>(
              valueListenable: chosenMode,
              builder: (context, themeMode, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          MdiIcons.bookEdit,
                          color: chosenMode.value == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          chosenMode.value = chosenMode.value == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                        },
                        icon: Icon(
                          MdiIcons.whiteBalanceSunny,
                          color: chosenMode.value == ThemeMode.dark
                              ? Colors.white
                              : Colors.black,
                        ))
                  ],
                );
              }),
          Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey),
                child: Center(
                    child: Text(
                  loggedUser!.username[0].toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 60,
                      color: Colors.white),
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: AutoSizeText(
                  loggedUser!.username,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
