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
          },
        )
      ],
    ));
  }
}
