import 'package:flutter/material.dart';
import 'package:placementor_tnp/on_campus_company_form.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnCampusCompanyForm(),
      // body: Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: Card(
      //     elevation: 10,
      //     child: Column(
      //       children: const [
      //         Icon(
      //           Icons.error_outline_rounded,
      //         ),
      //         Text(
      //           'Tickets',
      //           style: TextStyle(
      //             fontSize: 25,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
