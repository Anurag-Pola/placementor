import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import './firebase_options.dart';
import 'Front End/screens/login_screen.dart';
import 'Front End/screens/off_campus_company_screen.dart';
import 'Front End/screens/to_do_screen.dart';
import 'Front End/screens/tnp_coordinators_screen.dart';
import 'Front End/screens/off_campus_form_screen.dart';
import 'Front End/screens/off_campus_opp_screen.dart';
import 'Front End/screens/on_campus_company_screen.dart';
import 'Front End/screens/raise_ticket_screen.dart';
import 'Front End/screens/tabs_screen.dart';
import 'Front End/screens/introduction_screen.dart';
import 'Front End/screens/status_tracker_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      builder: (context, widget) {
        return ScrollConfiguration(
            behavior: const ScrollBehaviorModified(), child: widget!);
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      routes: {
        '/loginPage': (context) => const LoginScreen(),
        '/tabsPage': (context) => const TabsScreen(),
        '/OffCampusFormPage': (context) => const OffCampusFormScreen(),
        '/RaiseTicketPage': (context) => const RaiseTicketScreen(),
        '/OffCampusOppPage': (context) => const OffCampusOppScreen(),
        '/onCampusCompanyPage': (context) => const OnCampusComapnyScreen(),
        '/offCampusCompanyPage': (context) => const OffCampusComapnyScreen(),
        '/tnpCoordinatorsPage': (context) => const TnPCoordinatorsScreen(),
        '/toDoListPage': (context) => const ToDoListScreen(),
        '/statusTrackerPage': (context) => const StatusTrackerScreen(),
      },
      home: IntroductionScreen(),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
