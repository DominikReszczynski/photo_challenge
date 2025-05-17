import 'package:cas_house/main_global.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavBarMain extends StatefulWidget {
  const NavBarMain({
    super.key,
  });

  @override
  State<NavBarMain> createState() => _NavBarMainState();
}

class _NavBarMainState extends State<NavBarMain> {
  @override
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: mainGrey,
      currentIndex: _mapEnumToIndex(currentSite.value),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.viewDashboard,
            size: 35,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.home,
            size: 35,
          ),
          label: 'Properties',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.bug,
            size: 35,
          ),
          label: 'Defects',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.creditCard,
            size: 35,
          ),
          label: 'Payment',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.account,
            size: 35,
          ),
          label: 'User',
        ),
      ],
      onTap: (index) {
        setState(() {
          // Updates the global ValueNotifier with the selected view.
          currentSite.value = _mapIndexToEnum(index);
        });
      },
    );
  }

  // Maps the MainViews enum to the corresponding BottomNavigationBar index.
  int _mapEnumToIndex(MainViews view) {
    switch (view) {
      case MainViews.dashboard:
        return 0;
      case MainViews.properties:
        return 1;
      case MainViews.defects:
        return 2;
      case MainViews.payment:
        return 3;
      case MainViews.user:
        return 4;
    }
  }

  // Maps the BottomNavigationBar index to the corresponding MainViews enum.
  MainViews _mapIndexToEnum(int index) {
    switch (index) {
      case 0:
        return MainViews.dashboard;
      case 1:
        return MainViews.properties;
      case 2:
        return MainViews.defects;
      case 3:
        return MainViews.payment;
      case 4:
        return MainViews.user;
      default:
        return MainViews.dashboard;
    }
  }
}
