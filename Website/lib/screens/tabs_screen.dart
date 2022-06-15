import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  final Map<dynamic, dynamic> _tabsRouteMap = {
    'Companies': '/companies',
    'Tickets': '/tickets',
    'Newsfeed': '/newsfeed',
    'Resources': '/resources',
    'Off Campus Opportunities': '/off-campus-opportunities',
    'T&P Coordinators': '/admins-page',
    'Students': '/students-page'
  };
  TabsScreen({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ..._tabsRouteMap.entries
            .map((routeMapEntry) => ListTile(
                title: Text(routeMapEntry.key),
                onTap: () {
                  Navigator.pushNamed(context, routeMapEntry.value);
                }))
            .toList(),
        ListTile(
            title: const Text("Log Out"),
            onTap: () async {
              await auth.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            }),
      ],
    ));
  }
}
