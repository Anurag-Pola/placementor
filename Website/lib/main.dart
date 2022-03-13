import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import './screens/companies_screen.dart';
import './screens/on_campus_company_form.dart';
import './screens/tickets_screen.dart';
import './screens/login_screen.dart';
import './screens/off_campus_company_screen.dart';
import './screens/on_campus_company_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/tickets': (context) => const TicketsScreen(),
        '/companies': (context) => const CompaniesScreen(),
        '/onCampusCompanyForm': (context) => const OnCampusCompanyForm(),
        '/onCampusCompanyPage': (context) => const OnCampusComapnyScreen(),
        '/offCampusCompanyPage': (context) => const OffCampusComapnyScreen(),
      },
    );
  }
}
