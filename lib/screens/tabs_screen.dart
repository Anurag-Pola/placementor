import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';

import './companies_screen.dart';
import './profile_screen.dart';
import './references_screen.dart';

class FluidNavBarDemo extends StatefulWidget {
  const FluidNavBarDemo({Key? key}) : super(key: key);
  @override
  State createState() {
    return _FluidNavBarDemoState();
  }
}

class _FluidNavBarDemoState extends State<FluidNavBarDemo> {
  Widget? _child;

  @override
  void initState() {
    _child = CompaniesScreen();
    super.initState();
  }

  @override
  Widget build(context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color(0xFF75B7E1),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
              icon: Icons.business,
              extras: {"label": "companies"},
            ),
            FluidNavBarIcon(
              icon: Icons.menu_book,
              extras: {"label": "references"},
            ),
            FluidNavBarIcon(
              icon: Icons.person,
              extras: {"label": "profile"},
            ),
          ],
          onChange: _handleNavigationChange,
          style: const FluidNavBarStyle(
              iconUnselectedForegroundColor: Colors.grey),
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
          _child = CompaniesScreen();
          break;
        case 1:
          _child = const ReferencesScreen();
          break;
        case 2:
          _child = const ProfileScreen();
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
