import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

import './newsfeed_screen.dart';
import './companies_screen.dart';
import './profile_screen.dart';
import 'resources_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);
  @override
  State createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  Widget? _child;

  @override
  void initState() {
    _child = const CompaniesScreen();
    super.initState();
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
              icon: Icons.business,
              extras: {"label": "companies"},
            ),
            FluidNavBarIcon(
              icon: Icons.feed_rounded,
              extras: {"label": "newsfeed"},
            ),
            FluidNavBarIcon(
              icon: Icons.menu_book,
              extras: {"label": "resources"},
            ),
            FluidNavBarIcon(
              icon: Icons.person,
              extras: {"label": "profile"},
            ),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
            iconUnselectedForegroundColor: Colors.white,
            barBackgroundColor: Color(0x9900A3FF),
            iconBackgroundColor: Color(0x2000A3FF),
          ),
          scaleFactor: 1.5,
          // defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const CompaniesScreen();
          break;
        case 1:
          _child = const NewsfeedScreen();
          break;
        case 2:
          _child = const ResourcesScreen();
          break;
        case 3:
          _child = ProfileScreen();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
