import 'package:auto_size_text/auto_size_text.dart';
import 'package:cas_house/main_global.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserSectionHeader extends StatefulWidget {
  final VoidCallback onLogout;

  const UserSectionHeader({super.key, required this.onLogout});

  @override
  State<UserSectionHeader> createState() => _UserSectionHeaderState();
}

class _UserSectionHeaderState extends State<UserSectionHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
        border: const Border(bottom: BorderSide()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Column(
          children: [
            ValueListenableBuilder<ThemeMode>(
              valueListenable: chosenMode,
              builder: (context, themeMode, _) {
                final iconColor = themeMode == ThemeMode.dark
                    ? Colors.black87
                    : const Color(0xFF926C20);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        chosenMode.value = chosenMode.value == ThemeMode.light
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                      icon: Icon(
                        MdiIcons.whiteBalanceSunny,
                        color: iconColor,
                        size: 28,
                      ),
                      tooltip: 'Zmień motyw',
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            MdiIcons.cogOutline,
                            color: iconColor,
                            size: 26,
                          ),
                          tooltip: 'Ustawienia',
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            MdiIcons.informationOutline,
                            color: iconColor,
                            size: 26,
                          ),
                          tooltip: 'Informacje',
                        ),
                        IconButton(
                          onPressed: widget.onLogout,
                          icon: Icon(
                            MdiIcons.logout,
                            color: iconColor,
                            size: 28,
                          ),
                          tooltip: 'Wyloguj',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF926C20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.brown.shade100,
                      width: 4,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      loggedUser!.username[0].toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 60,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: AutoSizeText(
                    loggedUser!.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Color(0xFF926C20),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Dodatkowe statyczne ikony opcji
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Icon(MdiIcons.trophyOutline,
                            color: const Color(0xFF926C20), size: 28),
                        const SizedBox(height: 4),
                        const Text(
                          'Wyniki',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF926C20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 28),
                    Column(
                      children: [
                        Icon(MdiIcons.cameraOutline,
                            color: const Color(0xFF926C20), size: 28),
                        const SizedBox(height: 4),
                        const Text(
                          'Moje zdjęcia',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF926C20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 28),
                    Column(
                      children: [
                        Icon(MdiIcons.accountGroupOutline,
                            color: const Color(0xFF926C20), size: 28),
                        const SizedBox(height: 4),
                        const Text(
                          'Znajomi',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF926C20),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
