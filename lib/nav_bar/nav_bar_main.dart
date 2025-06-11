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
            MdiIcons.rss,
            size: 35,
          ),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            MdiIcons.plusCircleOutline,
            size: 35,
          ),
          label: 'Add',
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
      case MainViews.feed:
        return 0;
      case MainViews.add:
        return 1;
      case MainViews.user:
        return 2;
    }
  }

  // Maps the BottomNavigationBar index to the corresponding MainViews enum.
  MainViews _mapIndexToEnum(int index) {
    switch (index) {
      case 0:
        return MainViews.feed;
      case 1:
        return MainViews.add;
      case 2:
        return MainViews.user;
      default:
        return MainViews.feed;
    }
  }
}
