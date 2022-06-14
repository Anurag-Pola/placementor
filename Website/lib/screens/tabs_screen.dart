import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  TabsScreen({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;
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
        ListTile(
            title: const Text("T&P Coordinators"),
            onTap: () {
              Navigator.pushNamed(context, '/tnpCoordinators');
            }),
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
