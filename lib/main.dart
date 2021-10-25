import 'package:flutter/material.dart';
import './screens/tnp_coordinators_screen.dart';
import './screens/off_campus_form_screen.dart';
import './screens/off_campus_opp_screen.dart';
import './screens/on_campus_company_screen.dart';
import './screens/raise_ticket_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/OffCampusFormPage': (context) => const OffCampusFormScreen(),
        '/RaiseTicketPage': (context) => const RaiseTicketScreen(),
        '/OffCampusOppPage': (context) => const OffCampusOppScreen(),
        '/onCampusCompanyPage': (context) => const OnCampusComapnyScreen(),
        '/tnpCoordinatorsPage': (context) => const TnPCoordinatorsScreen(),
      },
      home: const FluidNavBarDemo(),
    );
  }
}
