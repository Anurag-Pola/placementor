import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        ListTile(
            title: const Text("Companies"),
            onTap: () {
              Navigator.pushNamed(context, '/companies');
            }),
        ListTile(
            title: const Text("Tickets"),
            onTap: () {
              Navigator.pushNamed(context, '/tickets');
            }),
        ListTile(
            title: const Text("Newsfeed"),
            onTap: () {
              Navigator.pushNamed(context, '/newsfeed');
            }),
        ListTile(
            title: const Text("Manage Users"),
            onTap: () {
              Navigator.pushNamed(context, '/manage-users');
            }),
        ListTile(
            title: const Text("Resources"),
            onTap: () {
              Navigator.pushNamed(context, '/resources');
            }),
        ListTile(
            title: const Text("Off Campus Opportunities"),
            onTap: () {
              Navigator.pushNamed(context, '/offCampusOpportunities');
            }),
      ],
    ));
  }
}
